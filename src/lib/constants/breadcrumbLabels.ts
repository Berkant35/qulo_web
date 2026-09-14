import type { Locale } from "@/lib/i18n/config";

/**
 * Yasal/kurumsal sayfalarin breadcrumb etiketleri (kisa bicim: "Privacy", "Privacy Policy" degil).
 * `Record<Locale, …>`: yeni dil eklenip burasi unutulursa derleme hatasi verir — 5 sayfada
 * ayri ayri tutulan map'ler 19. dilde sessizce Ingilizce'ye dusuyordu.
 */
export interface BreadcrumbLabels {
  privacy: string;
  terms: string;
  guidelines: string;
  safety: string;
  about: string;
}

export const BREADCRUMB_LABELS: Record<Locale, BreadcrumbLabels> = {
  tr: { privacy: "Gizlilik", terms: "Şartlar", guidelines: "Topluluk Kuralları", safety: "Güvenlik", about: "Hakkında" },
  en: { privacy: "Privacy", terms: "Terms", guidelines: "Guidelines", safety: "Safety", about: "About" },
  de: { privacy: "Datenschutz", terms: "Bedingungen", guidelines: "Richtlinien", safety: "Sicherheit", about: "Über uns" },
  fr: { privacy: "Confidentialité", terms: "Conditions", guidelines: "Règles", safety: "Sécurité", about: "À propos" },
  es: { privacy: "Privacidad", terms: "Términos", guidelines: "Normas", safety: "Seguridad", about: "Acerca de" },
  ar: { privacy: "الخصوصية", terms: "الشروط", guidelines: "إرشادات المجتمع", safety: "السلامة", about: "حول" },
  ru: { privacy: "Конфиденциальность", terms: "Условия", guidelines: "Правила", safety: "Безопасность", about: "О нас" },
  pt: { privacy: "Privacidade", terms: "Termos", guidelines: "Regras", safety: "Segurança", about: "Sobre" },
  it: { privacy: "Privacy", terms: "Termini", guidelines: "Linee Guida", safety: "Sicurezza", about: "Chi siamo" },
  ja: { privacy: "プライバシー", terms: "規約", guidelines: "ガイドライン", safety: "安全", about: "概要" },
  ko: { privacy: "개인정보", terms: "약관", guidelines: "가이드라인", safety: "안전", about: "소개" },
  zh: { privacy: "隐私", terms: "条款", guidelines: "社区准则", safety: "安全", about: "关于" },
  nl: { privacy: "Privacy", terms: "Voorwaarden", guidelines: "Richtlijnen", safety: "Veiligheid", about: "Over ons" },
  pl: { privacy: "Prywatność", terms: "Warunki", guidelines: "Zasady", safety: "Bezpieczeństwo", about: "O nas" },
  sv: { privacy: "Integritet", terms: "Villkor", guidelines: "Regler", safety: "Säkerhet", about: "Om oss" },
  hi: { privacy: "गोपनीयता", terms: "शर्तें", guidelines: "दिशानिर्देश", safety: "सुरक्षा", about: "के बारे में" },
  th: { privacy: "ความเป็นส่วนตัว", terms: "ข้อกำหนด", guidelines: "กฎของชุมชน", safety: "ความปลอดภัย", about: "เกี่ยวกับ" },
  id: { privacy: "Privasi", terms: "Ketentuan", guidelines: "Pedoman", safety: "Keamanan", about: "Tentang" },
};
