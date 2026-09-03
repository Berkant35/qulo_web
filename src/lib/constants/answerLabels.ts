/**
 * UI chrome for the /answers hub and its pages.
 *
 * Kept separate from `ANSWER_PAGES` so the content (questions and answers) and
 * the furniture around it can be translated independently. English is the
 * fallback for any locale not listed.
 */
export interface AnswerLabels {
  hubTitle: string;
  hubIntro: string;
  updated: string;
  related: string;
  sourcesHeading: string;
  sourcesIntro: string;
  ctaTitle: string;
  ctaDesc: string;
  ctaLink: string;
}

export const ANSWER_LABELS: Record<string, AnswerLabels> = {
  en: {
    hubTitle: "Answers",
    hubIntro:
      "Straight answers to the questions people actually ask about Qulo and about question-based dating. Each page answers its question in the first paragraph.",
    updated: "Updated",
    related: "Other answers",
    sourcesHeading: "Sources",
    sourcesIntro:
      "External figures on this page trace to a primary source. We publish no number we cannot verify.",
    ctaTitle: "Try it yourself",
    ctaDesc:
      "Write two to ten questions and see who gets them right. Free to use, no swiping.",
    ctaLink: "Get Qulo →",
  },
  tr: {
    hubTitle: "Cevaplar",
    hubIntro:
      "Qulo ve soru tabanlı tanışma hakkında gerçekten sorulan soruların doğrudan cevapları. Her sayfa sorusunu ilk paragrafta yanıtlar.",
    updated: "Güncellendi",
    related: "Diğer cevaplar",
    sourcesHeading: "Kaynaklar",
    sourcesIntro:
      "Bu sayfadaki dış veriler birincil kaynağa dayanır. Doğrulayamadığımız hiçbir rakamı yayımlamayız.",
    ctaTitle: "Kendin dene",
    ctaDesc:
      "İki ile on arasında soru yaz, kimin doğru bildiğini gör. Ücretsiz, kaydırma yok.",
    ctaLink: "Qulo'yu edin →",
  },
  de: {
    hubTitle: "Antworten",
    hubIntro:
      "Klare Antworten auf die Fragen, die zu Qulo und zum Kennenlernen über Fragen wirklich gestellt werden. Jede Seite beantwortet ihre Frage schon im ersten Absatz.",
    updated: "Aktualisiert",
    related: "Weitere Antworten",
    sourcesHeading: "Quellen",
    sourcesIntro:
      "Externe Zahlen auf dieser Seite lassen sich bis zur Primärquelle zurückverfolgen. Wir veröffentlichen keine Zahl, die wir nicht prüfen können.",
    ctaTitle: "Probier es selbst aus",
    ctaDesc:
      "Schreib zwei bis zehn Fragen und sieh, wer sie richtig beantwortet. Kostenlos, ohne Wischen.",
    ctaLink: "Qulo holen →",
  },
  fr: {
    hubTitle: "Réponses",
    hubIntro:
      "Des réponses directes aux questions que l'on se pose vraiment sur Qulo et sur les rencontres par questions. Chaque page répond à sa question dès le premier paragraphe.",
    updated: "Mis à jour",
    related: "Autres réponses",
    sourcesHeading: "Sources",
    sourcesIntro:
      "Les chiffres externes de cette page remontent tous à une source primaire. Nous ne publions aucun chiffre que nous ne pouvons pas vérifier.",
    ctaTitle: "Essayez par vous-même",
    ctaDesc:
      "Écrivez de deux à dix questions et voyez qui trouve les bonnes réponses. Gratuit, sans balayage.",
    ctaLink: "Obtenir Qulo →",
  },
  es: {
    hubTitle: "Respuestas",
    hubIntro:
      "Respuestas directas a las preguntas que la gente hace de verdad sobre Qulo y sobre las citas basadas en preguntas. Cada página responde a su pregunta en el primer párrafo.",
    updated: "Actualizado",
    related: "Otras respuestas",
    sourcesHeading: "Fuentes",
    sourcesIntro:
      "Las cifras externas de esta página se remontan a una fuente primaria. No publicamos ningún dato que no podamos verificar.",
    ctaTitle: "Pruébalo tú mismo",
    ctaDesc:
      "Escribe de dos a diez preguntas y mira quién las acierta. Gratis y sin deslizar.",
    ctaLink: "Consigue Qulo →",
  },
  ar: {
    hubTitle: "إجابات",
    hubIntro:
      "إجابات مباشرة عن الأسئلة التي يطرحها الناس فعلًا عن Qulo وعن التعارف القائم على الأسئلة. كل صفحة تجيب عن سؤالها في الفقرة الأولى.",
    updated: "آخر تحديث",
    related: "إجابات أخرى",
    sourcesHeading: "المصادر",
    sourcesIntro:
      "تعود كل الأرقام الخارجية في هذه الصفحة إلى مصدر أساسي. ولا ننشر رقمًا لا نستطيع التحقق منه.",
    ctaTitle: "جرّبه بنفسك",
    ctaDesc:
      "اكتب من سؤالين إلى عشرة أسئلة، وانظر من يجيب عنها إجابة صحيحة. مجاني، وبلا تمرير.",
    ctaLink: "احصل على Qulo →",
  },
  ru: {
    hubTitle: "Ответы",
    hubIntro:
      "Прямые ответы на вопросы, которые действительно задают о Qulo и о знакомствах через вопросы. Каждая страница отвечает на свой вопрос уже в первом абзаце.",
    updated: "Обновлено",
    related: "Другие ответы",
    sourcesHeading: "Источники",
    sourcesIntro:
      "Все внешние цифры на этой странице восходят к первоисточнику. Мы не публикуем ни одного числа, которое не можем проверить.",
    ctaTitle: "Попробуйте сами",
    ctaDesc:
      "Составьте от двух до десяти вопросов и посмотрите, кто ответит правильно. Бесплатно и без свайпов.",
    ctaLink: "Установить Qulo →",
  },
  pt: {
    hubTitle: "Respostas",
    hubIntro:
      "Respostas diretas às perguntas que as pessoas realmente fazem sobre o Qulo e sobre o namoro baseado em perguntas. Cada página responde à sua pergunta logo no primeiro parágrafo.",
    updated: "Atualizado",
    related: "Outras respostas",
    sourcesHeading: "Fontes",
    sourcesIntro:
      "Os números externos desta página remetem a uma fonte primária. Não publicamos nenhum dado que não possamos verificar.",
    ctaTitle: "Experimente você mesmo",
    ctaDesc:
      "Escreva de duas a dez perguntas e veja quem acerta. Grátis, sem deslizar.",
    ctaLink: "Baixar o Qulo →",
  },
  it: {
    hubTitle: "Risposte",
    hubIntro:
      "Risposte dirette alle domande che si fanno davvero su Qulo e sugli incontri basati sulle domande. Ogni pagina risponde alla sua domanda già nel primo paragrafo.",
    updated: "Aggiornato",
    related: "Altre risposte",
    sourcesHeading: "Fonti",
    sourcesIntro:
      "I dati esterni di questa pagina risalgono a una fonte primaria. Non pubblichiamo nessun numero che non possiamo verificare.",
    ctaTitle: "Provalo tu stesso",
    ctaDesc:
      "Scrivi da due a dieci domande e guarda chi le indovina. Gratis, senza scorrere.",
    ctaLink: "Scarica Qulo →",
  },
  ja: {
    hubTitle: "回答",
    hubIntro:
      "Qulo と、質問で出会う仕組みについて実際によく聞かれることへの率直な回答です。どのページも最初の段落で質問に答えます。",
    updated: "更新日",
    related: "ほかの回答",
    sourcesHeading: "出典",
    sourcesIntro:
      "このページの外部データはすべて一次情報にさかのぼれます。確認できない数字は載せません。",
    ctaTitle: "自分で試す",
    ctaDesc:
      "質問を二問から十問つくって、誰が正解するか見てみましょう。無料で、スワイプはありません。",
    ctaLink: "Qulo を入手 →",
  },
  ko: {
    hubTitle: "답변",
    hubIntro:
      "Qulo와 질문으로 만나는 방식에 대해 사람들이 실제로 궁금해하는 것들에 대한 솔직한 답변입니다. 모든 페이지가 첫 문단에서 질문에 답합니다.",
    updated: "업데이트",
    related: "다른 답변",
    sourcesHeading: "출처",
    sourcesIntro:
      "이 페이지에 실린 외부 수치는 모두 원 출처로 이어집니다. 확인할 수 없는 숫자는 싣지 않습니다.",
    ctaTitle: "직접 해보기",
    ctaDesc:
      "질문을 두 개에서 열 개까지 만들고 누가 맞히는지 보세요. 무료이고 스와이프도 없습니다.",
    ctaLink: "Qulo 받기 →",
  },
  zh: {
    hubTitle: "解答",
    hubIntro:
      "关于 Qulo 和以问题为核心的交友方式，人们真正会问的问题，这里给出直接的解答。每个页面都在第一段就回答标题里的问题。",
    updated: "更新时间",
    related: "其他解答",
    sourcesHeading: "资料来源",
    sourcesIntro:
      "本页引用的外部数据都可追溯到一手来源。无法核实的数字，我们不会发布。",
    ctaTitle: "自己试试",
    ctaDesc: "写下两到十道问题，看看谁能答对。免费使用，无需滑动。",
    ctaLink: "获取 Qulo →",
  },
  nl: {
    hubTitle: "Antwoorden",
    hubIntro:
      "Directe antwoorden op de vragen die mensen echt stellen over Qulo en over daten via vragen. Elke pagina beantwoordt haar vraag al in de eerste alinea.",
    updated: "Bijgewerkt",
    related: "Andere antwoorden",
    sourcesHeading: "Bronnen",
    sourcesIntro:
      "Externe cijfers op deze pagina zijn terug te voeren op een primaire bron. We publiceren geen getal dat we niet kunnen verifiëren.",
    ctaTitle: "Probeer het zelf",
    ctaDesc:
      "Schrijf twee tot tien vragen en kijk wie ze goed heeft. Gratis, zonder swipen.",
    ctaLink: "Download Qulo →",
  },
  pl: {
    hubTitle: "Odpowiedzi",
    hubIntro:
      "Konkretne odpowiedzi na pytania, które ludzie naprawdę zadają o Qulo i o randkowanie oparte na pytaniach. Każda strona odpowiada na swoje pytanie już w pierwszym akapicie.",
    updated: "Zaktualizowano",
    related: "Inne odpowiedzi",
    sourcesHeading: "Źródła",
    sourcesIntro:
      "Wszystkie zewnętrzne dane na tej stronie prowadzą do źródła pierwotnego. Nie publikujemy liczby, której nie możemy zweryfikować.",
    ctaTitle: "Sprawdź sam",
    ctaDesc:
      "Ułóż od dwóch do dziesięciu pytań i zobacz, kto na nie odpowie. Za darmo, bez przesuwania.",
    ctaLink: "Pobierz Qulo →",
  },
  sv: {
    hubTitle: "Svar",
    hubIntro:
      "Raka svar på de frågor som folk faktiskt ställer om Qulo och om att dejta genom frågor. Varje sida besvarar sin fråga redan i första stycket.",
    updated: "Uppdaterad",
    related: "Andra svar",
    sourcesHeading: "Källor",
    sourcesIntro:
      "Externa siffror på den här sidan går att spåra till en primärkälla. Vi publicerar inga siffror som vi inte kan verifiera.",
    ctaTitle: "Testa själv",
    ctaDesc:
      "Skriv två till tio frågor och se vem som svarar rätt. Gratis att använda, utan svep.",
    ctaLink: "Hämta Qulo →",
  },
  hi: {
    hubTitle: "जवाब",
    hubIntro:
      "Qulo और सवालों पर आधारित डेटिंग के बारे में लोग जो सच में पूछते हैं, उनके सीधे जवाब। हर पेज अपने सवाल का जवाब पहले ही पैराग्राफ़ में दे देता है।",
    updated: "अपडेट किया गया",
    related: "और जवाब",
    sourcesHeading: "स्रोत",
    sourcesIntro:
      "इस पेज के बाहरी आँकड़े मूल स्रोत तक जाते हैं। जिस संख्या की पुष्टि न हो सके, उसे हम प्रकाशित नहीं करते।",
    ctaTitle: "खुद आज़माएँ",
    ctaDesc:
      "दो से दस सवाल लिखें और देखें कौन उन्हें सही करता है। मुफ़्त, बिना स्वाइप के।",
    ctaLink: "Qulo पाएँ →",
  },
};
