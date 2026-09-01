#!/usr/bin/env bash
# RLS guard — kanit temelli test kosumu.
# Kullanim:  ./rls-test.sh baseline   |  ./rls-test.sh verify
# Kural: CLAUDE.md "Guvenlik Migration'lari" bolumu.
set -uo pipefail

SP="${RLS_SECRET_DIR:?RLS_SECRET_DIR set edilmeli (anon key ve test sifresi burada)}"
OUT_DIR="$(cd "$(dirname "$0")" && pwd)/results"
mkdir -p "$OUT_DIR"
MODE="${1:-verify}"
OUT="$OUT_DIR/${MODE}.tsv"

SUPA_URL="https://vtntrtozgoyhjdvvurkj.supabase.co"
API_URL="https://qulo-server-production.up.railway.app/api/v1"
ANON="$(cat "$SP/.anon_key")"

# --- KIRMIZI: anon dogrudan erisim. Hedef = kapanmasi. ---
RED_TABLES="users user_details refresh_tokens admin_users diamond_transactions swipes
quiz_sessions quiz_answers questions blocks reports support_tickets user_subscriptions
iap_products iap_transactions app_config powers page_messages page_message_events
account_deletion_feedback email_unsubscribe_tokens question_pending_changes
ai_question_suggestions messages matches"

: > "$OUT"
echo "# mode=$MODE" >> "$OUT"

# HTTP kodu TEK BASINA yeterli degil: PostgREST, RLS reddinde 401 degil bos [] doner.
# Bu yuzden govde de siniflandirilir -> rows | empty | err:<code>
classify() {
  python3 -c '
import sys,json
b=sys.stdin.read().strip()
try: d=json.loads(b)
except Exception: print("nonjson"); raise SystemExit
if isinstance(d,list): print("rows" if d else "empty")
elif isinstance(d,dict): print("err:"+str(d.get("code") or d.get("message","?"))[:24])
else: print("other")'
}
for T in $RED_TABLES; do
  body=$(curl -s --max-time 20 -w "\n%{http_code}" \
      -H "apikey: $ANON" -H "Authorization: Bearer $ANON" \
      "$SUPA_URL/rest/v1/$T?select=*&limit=1")
  c=$(printf '%s' "$body" | tail -1)
  shape=$(printf '%s' "$body" | sed '$d' | classify)
  printf "RED\tselect\t%s\t%s/%s\n" "$T" "$c" "$shape" >> "$OUT"
done

# --- YESIL: uygulama yolu. Hedef = calismaya devam etmesi. ---
gc() { curl -s -o /dev/null -w "%{http_code}" --max-time 25 "$@"; }

printf "GREEN\thealth\tserver\t%s\n" "$(gc "https://qulo-server-production.up.railway.app/health")" >> "$OUT"

if [ -f "$SP/.test_user" ]; then
  EMAIL=$(sed -n 1p "$SP/.test_user"); PASS=$(sed -n 2p "$SP/.test_user")
  LOGIN=$(curl -s --max-time 25 -X POST "$API_URL/auth/login" \
      -H "Content-Type: application/json" \
      -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}")
  TOK=$(printf '%s' "$LOGIN" | python3 -c 'import sys,json;d=json.load(sys.stdin);print(d.get("data",{}).get("accessToken") or d.get("accessToken") or "")' 2>/dev/null)
  if [ -n "$TOK" ]; then
    printf "GREEN\tlogin\tauth\t200\n" >> "$OUT"
    for EP in "users/me" "matches/list" "matches/discover" "questions/me" "questions/count/me" \
           "diamonds/balance" "diamonds/history" "subscriptions/status" "subscriptions/daily-stats" \
           "users/me/languages" "users/me/notification-preferences" \
           "app/config" "app/economy" "powers" "page-messages"; do
      printf "GREEN\tapi\t%s\t%s\n" "$EP" \
        "$(gc -H "Authorization: Bearer $TOK" "$API_URL/$EP")" >> "$OUT"
    done
  else
    printf "GREEN\tlogin\tauth\tFAIL\n" >> "$OUT"
  fi
else
  printf "GREEN\tlogin\tauth\tSKIP-no-credentials\n" >> "$OUT"
fi

sort -o "$OUT" "$OUT"
echo "--> $OUT"
grep -c RED "$OUT" | xargs echo "kirmizi test:"
grep -c GREEN "$OUT" | xargs echo "yesil test:"
