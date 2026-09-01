#!/usr/bin/env bash
# Qulo repo'larina push (web / qulo-server / qulov2).
#
# Bu repo'lar Berkant35 hesabinda; gunluk kullanilan gh hesabi ise farkli.
# Script push oncesi hesabi degistirir, push eder ve ONCEKI hesabi geri yukler
# (push basarisiz olsa bile). Boylece "gh durumu" her seferinde kendiliginden
# duzelir.
#
# Kullanim:
#   scripts/qulo-push.sh                 # bulundugun repo, mevcut branch
#   scripts/qulo-push.sh web             # qulo/web
#   scripts/qulo-push.sh web main        # dal belirterek
set -euo pipefail

REPO_ACCOUNT="Berkant35"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

target="${1:-.}"
case "$target" in
  web|qulo-server|qulov2) repo_dir="$ROOT/$target" ;;
  *)                      repo_dir="$(cd "$target" && pwd)" ;;
esac

cd "$repo_dir"
branch="${2:-$(git rev-parse --abbrev-ref HEAD)}"

if [ -z "$(git log --oneline "origin/$branch..HEAD" 2>/dev/null)" ]; then
  echo "→ $repo_dir ($branch): push edilecek commit yok."
  exit 0
fi

echo "→ $repo_dir ($branch) — push edilecek:"
git log --oneline "origin/$branch..HEAD" | sed 's/^/   /'

previous="$(gh api user --jq .login 2>/dev/null || true)"
restore() {
  if [ -n "${previous:-}" ] && [ "$previous" != "$REPO_ACCOUNT" ]; then
    gh auth switch --user "$previous" >/dev/null 2>&1 && echo "→ gh hesabi geri alindi: $previous"
  fi
}
trap restore EXIT

gh auth switch --user "$REPO_ACCOUNT" >/dev/null
gh auth setup-git >/dev/null
git push origin "$branch"
echo "✓ push tamam"
