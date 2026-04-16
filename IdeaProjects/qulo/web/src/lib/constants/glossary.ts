export interface GlossaryTerm {
  slug: string;
  emoji: string;
  terms: Record<string, string>;
  definitions: Record<string, string>;
}

export const GLOSSARY_TERMS: GlossaryTerm[] = [
  {
    slug: "ghosting",
    emoji: "\u{1F47B}",
    terms: { tr: "Ghosting", en: "Ghosting", de: "Ghosting", fr: "Ghosting", es: "Ghosting" },
    definitions: {
      tr: "Bir ki\u015Fiyle mesajla\u015F\u0131rken veya g\u00F6r\u00FC\u015Ft\u00FCkten sonra hi\u00E7bir a\u00E7\u0131klama yapmadan aniden ileti\u015Fimi tamamen kesmek. Dating uygulamalar\u0131nda en yayg\u0131n sorunlardan biri. Qulo'da efor gerektiren e\u015Fle\u015Fme sayesinde ghosting oran\u0131 \u00E7ok daha d\u00FC\u015F\u00FCkt\u00FCr.",
      en: "Suddenly cutting off all communication with someone you've been messaging or dating without any explanation. One of the most common issues on dating apps. On Qulo, ghosting rates are much lower thanks to effort-based matching.",
      de: "Das pl\u00F6tzliche Abbrechen jeglicher Kommunikation mit jemandem, mit dem man geschrieben oder sich getroffen hat, ohne jede Erkl\u00E4rung. Eines der h\u00E4ufigsten Probleme bei Dating-Apps.",
      fr: "Couper soudainement toute communication avec quelqu'un sans aucune explication. L'un des probl\u00E8mes les plus courants sur les apps de rencontre.",
      es: "Cortar repentinamente toda comunicaci\u00F3n con alguien sin dar ninguna explicaci\u00F3n. Uno de los problemas m\u00E1s comunes en las apps de citas.",
    },
  },
  {
    slug: "catfishing",
    emoji: "\u{1F431}",
    terms: { tr: "Catfishing", en: "Catfishing", de: "Catfishing", fr: "Catfishing", es: "Catfishing" },
    definitions: {
      tr: "Sahte profil foto\u011Fraflar\u0131 veya bilgiler kullanarak ba\u015Fka biri gibi davranmak. Online dating'in en ciddi g\u00FCvenlik sorunlar\u0131ndan biri. Qulo'nun soru tabanl\u0131 sistemi, sahte profilleri do\u011Fal olarak filtreler.",
      en: "Pretending to be someone else by using fake profile photos or information. One of the most serious safety concerns in online dating. Qulo's question-based system naturally filters fake profiles.",
      de: "Sich als jemand anderes ausgeben, indem man gef\u00E4lschte Profilfotos oder Informationen verwendet. Eines der gravierendsten Sicherheitsprobleme beim Online-Dating.",
      fr: "Se faire passer pour quelqu'un d'autre en utilisant de fausses photos ou informations. L'un des probl\u00E8mes de s\u00E9curit\u00E9 les plus graves du dating en ligne.",
      es: "Hacerse pasar por otra persona usando fotos o informaci\u00F3n falsa. Uno de los problemas de seguridad m\u00E1s graves en las citas online.",
    },
  },
  {
    slug: "breadcrumbing",
    emoji: "\u{1F35E}",
    terms: { tr: "Breadcrumbing", en: "Breadcrumbing", de: "Breadcrumbing", fr: "Breadcrumbing", es: "Breadcrumbing" },
    definitions: {
      tr: "Birinin ilgisini s\u00FCrd\u00FCrmek i\u00E7in arada s\u0131rada mesaj at\u0131p sonra kaybolmak. Ki\u015Fi ciddi bir ili\u015Fki istemez ama kar\u015F\u0131 taraf\u0131 da tamamen b\u0131rakmaz. Qulo'da e\u015Fle\u015Fme s\u00FCreci efor gerektirdi\u011Finden breadcrumbing daha az ya\u015Fan\u0131r.",
      en: "Sending occasional messages to keep someone interested but then disappearing. The person doesn't want a serious relationship but doesn't fully let go either. Breadcrumbing happens less on Qulo because the matching process requires effort.",
      de: "Gelegentlich Nachrichten senden, um jemanden bei der Stange zu halten, dann aber wieder verschwinden. Die Person will keine ernste Beziehung, l\u00E4sst aber auch nicht ganz los.",
      fr: "Envoyer des messages occasionnels pour maintenir l'int\u00E9r\u00EAt de quelqu'un puis dispara\u00EEtre. La personne ne veut pas de relation s\u00E9rieuse mais ne l\u00E2che pas non plus.",
      es: "Enviar mensajes ocasionales para mantener el inter\u00E9s de alguien y luego desaparecer. La persona no quiere una relaci\u00F3n seria pero tampoco suelta del todo.",
    },
  },
  {
    slug: "swipe-fatigue",
    emoji: "\u{1F629}",
    terms: { tr: "Swipe Yorgunlu\u011Fu", en: "Swipe Fatigue", de: "Swipe-M\u00FCdigkeit", fr: "Fatigue du Swipe", es: "Cansancio del Swipe" },
    definitions: {
      tr: "Dating uygulamalar\u0131nda s\u00FCrekli sola-sa\u011Fa kayd\u0131rma eyleminin yaratt\u0131\u011F\u0131 zihinsel ve duygusal t\u00FCkenmi\u015Flik. Kullan\u0131c\u0131lar\u0131n %78'inin deneyimledi\u011Fi bu sorun, Qulo'nun soru tabanl\u0131 e\u015Fle\u015Fme sistemiyle tamamen ortadan kalkar.",
      en: "Mental and emotional exhaustion caused by endless swiping left and right on dating apps. Experienced by 78% of users, this problem is completely eliminated by Qulo's question-based matching system.",
      de: "Mentale und emotionale Ersch\u00F6pfung durch endloses Links-Rechts-Wischen auf Dating-Apps. 78% der Nutzer erleben dieses Problem.",
      fr: "L'\u00E9puisement mental et \u00E9motionnel caus\u00E9 par le balayage sans fin sur les apps de rencontre. V\u00E9cu par 78% des utilisateurs.",
      es: "Agotamiento mental y emocional causado por deslizar sin parar en las apps de citas. Experimentado por el 78% de los usuarios.",
    },
  },
  {
    slug: "love-bombing",
    emoji: "\u{1F4A3}",
    terms: { tr: "Love Bombing", en: "Love Bombing", de: "Love Bombing", fr: "Love Bombing", es: "Love Bombing" },
    definitions: {
      tr: "Yeni tan\u0131\u015Ft\u0131\u011F\u0131n\u0131z birinin sizi a\u015F\u0131r\u0131 ilgi, hediye ve iltifatlarla bo\u011Fmas\u0131. Ba\u015Flang\u0131\u00E7ta romantik g\u00F6r\u00FCnse de genellikle manip\u00FClatif bir davran\u0131\u015Ft\u0131r ve ili\u015Fkide kontrol kurma giri\u015Fimidir.",
      en: "When someone you just met overwhelms you with excessive attention, gifts, and compliments. While it may seem romantic at first, it's usually manipulative behavior and an attempt to gain control in the relationship.",
      de: "Wenn jemand, den man gerade kennengelernt hat, einen mit \u00FCberm\u00E4\u00DFiger Aufmerksamkeit, Geschenken und Komplimenten \u00FCberh\u00E4uft. Obwohl es zun\u00E4chst romantisch wirken mag, ist es meist manipulatives Verhalten.",
      fr: "Quand quelqu'un que vous venez de rencontrer vous submerge d'attention excessive, de cadeaux et de compliments. Bien que cela puisse sembler romantique au d\u00E9but, c'est g\u00E9n\u00E9ralement un comportement manipulateur.",
      es: "Cuando alguien que acabas de conocer te abruma con atenci\u00F3n excesiva, regalos y cumplidos. Aunque puede parecer rom\u00E1ntico al principio, suele ser un comportamiento manipulador.",
    },
  },
  {
    slug: "situationship",
    emoji: "\u{1F937}",
    terms: { tr: "Situationship", en: "Situationship", de: "Situationship", fr: "Situationship", es: "Situationship" },
    definitions: {
      tr: "Resmi bir ili\u015Fki tan\u0131m\u0131 olmayan, 'bir \u015Feyler ya\u015F\u0131yoruz ama ne oldu\u011Fu belirsiz' durumu. Dating uygulamalar\u0131nda \u00E7ok yayg\u0131nd\u0131r. Qulo'da sorular arac\u0131l\u0131\u011F\u0131yla niyetlerinizi ba\u015Ftan belli edebilirsiniz.",
      en: "A relationship without any official label \u2014 the 'we're something but it's unclear what' situation. Very common on dating apps. On Qulo, you can make your intentions clear from the start through your questions.",
      de: "Eine Beziehung ohne offizielles Label \u2014 die 'Wir sind irgendwas, aber unklar was'-Situation. Sehr verbreitet auf Dating-Apps.",
      fr: "Une relation sans \u00E9tiquette officielle \u2014 la situation du 'on est quelque chose mais ce n'est pas clair'. Tr\u00E8s courant sur les apps de rencontre.",
      es: "Una relaci\u00F3n sin etiqueta oficial \u2014 la situaci\u00F3n de 'somos algo pero no est\u00E1 claro qu\u00E9'. Muy com\u00FAn en las apps de citas.",
    },
  },
  {
    slug: "benching",
    emoji: "\u{1FA91}",
    terms: { tr: "Benching", en: "Benching", de: "Benching", fr: "Benching", es: "Benching" },
    definitions: {
      tr: "Birini yedek se\u00E7enek olarak tutmak \u2014 ilgileniyormu\u015F gibi yap\u0131p asla bulu\u015Fmaya ge\u00E7memek. Spordaki 'yedek kul\u00FCbesinde oturmak' kavram\u0131ndan t\u00FCremi\u015Ftir.",
      en: "Keeping someone as a backup option \u2014 acting interested but never actually meeting up. Derived from the sports concept of 'sitting on the bench.'",
      de: "Jemanden als Reserve-Option behalten \u2014 Interesse zeigen, sich aber nie wirklich treffen. Abgeleitet vom Sport-Konzept des 'Auf-der-Bank-Sitzens'.",
      fr: "Garder quelqu'un comme option de secours \u2014 sembler int\u00E9ress\u00E9 mais ne jamais se rencontrer. D\u00E9riv\u00E9 du concept sportif d'\u00EAtre 'sur le banc'.",
      es: "Mantener a alguien como opci\u00F3n de respaldo \u2014 actuar interesado pero nunca quedar. Derivado del concepto deportivo de 'estar en el banquillo'.",
    },
  },
  {
    slug: "orbiting",
    emoji: "\u{1FA90}",
    terms: { tr: "Orbiting", en: "Orbiting", de: "Orbiting", fr: "Orbiting", es: "Orbiting" },
    definitions: {
      tr: "Biriyle konu\u015Fmay\u0131 kestikten sonra sosyal medyada payla\u015F\u0131mlar\u0131n\u0131 be\u011Fenmeye, hikayeleri izlemeye devam etmek. Ghosting'in modern bir versiyonudur \u2014 ki\u015Fi hayat\u0131n\u0131zdan \u00E7\u0131kmaz ama ileti\u015Fim de kurmaz.",
      en: "After cutting off conversation with someone, continuing to like their posts and view their stories on social media. A modern version of ghosting \u2014 the person doesn't leave your life but doesn't communicate either.",
      de: "Nach dem Abbruch des Kontakts weiterhin Beitr\u00E4ge liken und Stories anschauen. Eine moderne Version von Ghosting.",
      fr: "Apr\u00E8s avoir coup\u00E9 la conversation avec quelqu'un, continuer \u00E0 aimer ses publications et regarder ses stories. Une version moderne du ghosting.",
      es: "Despu\u00E9s de cortar la conversaci\u00F3n con alguien, seguir dando like a sus publicaciones y viendo sus historias. Una versi\u00F3n moderna del ghosting.",
    },
  },
  {
    slug: "slow-dating",
    emoji: "\u{1F422}",
    terms: { tr: "Slow Dating", en: "Slow Dating", de: "Slow Dating", fr: "Slow Dating", es: "Slow Dating" },
    definitions: {
      tr: "H\u0131zl\u0131 swipe k\u00FClt\u00FCr\u00FCne kar\u015F\u0131, daha az ama daha anlaml\u0131 ba\u011Flant\u0131lara odaklanan yakla\u015F\u0131m. Qulo'nun felsefesiyle do\u011Frudan uyumlu bir trend \u2014 kalite, niceli\u011Fin \u00F6n\u00FCnde.",
      en: "An approach that focuses on fewer but more meaningful connections, counter to the fast swipe culture. Directly aligned with Qulo's philosophy \u2014 quality over quantity.",
      de: "Ein Ansatz, der sich auf weniger, aber bedeutungsvollere Verbindungen konzentriert. Direkt im Einklang mit Qulos Philosophie \u2014 Qualit\u00E4t vor Quantit\u00E4t.",
      fr: "Une approche qui se concentre sur moins de connexions mais plus significatives. Directement align\u00E9e avec la philosophie de Qulo \u2014 la qualit\u00E9 avant la quantit\u00E9.",
      es: "Un enfoque que se centra en menos conexiones pero m\u00E1s significativas. Directamente alineado con la filosof\u00EDa de Qulo \u2014 calidad sobre cantidad.",
    },
  },
  {
    slug: "cuffing-season",
    emoji: "\u{1F9E4}",
    terms: { tr: "Cuffing Season", en: "Cuffing Season", de: "Cuffing Season", fr: "Cuffing Season", es: "Cuffing Season" },
    definitions: {
      tr: "Sonbahar ve k\u0131\u015F aylar\u0131nda insanlar\u0131n yaln\u0131z kalmamak i\u00E7in daha aktif \u015Fekilde partner aramas\u0131. Dating uygulamalar\u0131nda Ekim-\u015Eubat aras\u0131 kullan\u0131m %30-40 artar.",
      en: "The period during fall and winter when people more actively seek partners to avoid being alone. Dating app usage increases by 30-40% between October and February.",
      de: "Die Zeit im Herbst und Winter, in der Menschen aktiver nach Partnern suchen, um nicht allein zu sein. Die Nutzung von Dating-Apps steigt zwischen Oktober und Februar um 30-40%.",
      fr: "La p\u00E9riode en automne et en hiver o\u00F9 les gens cherchent plus activement un partenaire pour ne pas \u00EAtre seuls. L'utilisation des apps de rencontre augmente de 30-40% entre octobre et f\u00E9vrier.",
      es: "El per\u00EDodo durante oto\u00F1o e invierno cuando las personas buscan pareja m\u00E1s activamente para no estar solas. El uso de apps de citas aumenta un 30-40% entre octubre y febrero.",
    },
  },
  {
    slug: "rizz",
    emoji: "\u2728",
    terms: { tr: "Rizz", en: "Rizz", de: "Rizz", fr: "Rizz", es: "Rizz" },
    definitions: {
      tr: "Kar\u015F\u0131 cinsi etkileme yetene\u011Fi, \u00E7ekicilik ve karizma. Z ku\u015Fa\u011F\u0131 slang'inden gelen bu terim, dating d\u00FCnyas\u0131nda 'fl\u00F6rt yetene\u011Fi' anlam\u0131nda kullan\u0131l\u0131r. Qulo'da iyi sorular haz\u0131rlamak da bir 'rizz' g\u00F6stergesi olabilir!",
      en: "The ability to attract the opposite sex, charm and charisma. Coming from Gen Z slang, this term is used in the dating world to mean 'flirting ability.' On Qulo, crafting great questions can be a sign of 'rizz' too!",
      de: "Die F\u00E4higkeit, das andere Geschlecht anzuziehen, Charme und Charisma. Aus dem Gen-Z-Slang stammend, wird dieser Begriff in der Dating-Welt als 'Flirtf\u00E4higkeit' verwendet.",
      fr: "La capacit\u00E9 d'attirer le sexe oppos\u00E9, le charme et le charisme. Issu de l'argot de la G\u00E9n\u00E9ration Z, ce terme d\u00E9signe la 'capacit\u00E9 \u00E0 flirter' dans le monde du dating.",
      es: "La capacidad de atraer al sexo opuesto, encanto y carisma. Proveniente del slang de la Generaci\u00F3n Z, este t\u00E9rmino se usa en el mundo de las citas para referirse a la 'habilidad para ligar'.",
    },
  },
  {
    slug: "ick",
    emoji: "\u{1F62C}",
    terms: { tr: "Ick", en: "Ick", de: "Ick", fr: "Ick", es: "Ick" },
    definitions: {
      tr: "Birinden ho\u015Flan\u0131rken aniden rahats\u0131z edici bir detay fark edip t\u00FCm \u00E7ekicili\u011Fin kaybolmas\u0131. 'Ick' almak tamamen subjektiftir ve k\u00FC\u00E7\u00FCk bir davran\u0131\u015F bile tetikleyebilir.",
      en: "When you're into someone and suddenly notice a disturbing detail that makes all attraction disappear. Getting an 'ick' is entirely subjective and can be triggered by even the smallest behavior.",
      de: "Wenn man jemanden mag und pl\u00F6tzlich ein st\u00F6rendes Detail bemerkt, das die gesamte Anziehung verschwinden l\u00E4sst. Ein 'Ick' ist v\u00F6llig subjektiv.",
      fr: "Quand vous \u00EAtes attir\u00E9 par quelqu'un et que vous remarquez soudainement un d\u00E9tail d\u00E9rangeant qui fait dispara\u00EEtre toute l'attirance. Le 'ick' est enti\u00E8rement subjectif.",
      es: "Cuando te gusta alguien y de repente notas un detalle perturbador que hace desaparecer toda la atracci\u00F3n. El 'ick' es completamente subjetivo.",
    },
  },
  {
    slug: "talking-stage",
    emoji: "\u{1F4AC}",
    terms: { tr: "Talking Stage", en: "Talking Stage", de: "Talking Stage", fr: "Talking Stage", es: "Talking Stage" },
    definitions: {
      tr: "E\u015Fle\u015Ftikten sonra hen\u00FCz resmi olarak \u00E7\u0131kmaya ba\u015Flamadan \u00F6nceki mesajla\u015Fma d\u00F6nemi. Bu a\u015Fama haftalar hatta aylarca s\u00FCrebilir. Qulo'da sorular do\u011Fal sohbet ba\u015Flat\u0131c\u0131lar\u0131 sa\u011Flayarak talking stage'i daha verimli hale getirir.",
      en: "The messaging period after matching but before officially starting to date. This phase can last weeks or even months. On Qulo, questions provide natural conversation starters, making the talking stage more productive.",
      de: "Die Nachrichten-Phase nach dem Match, aber bevor man offiziell miteinander ausgeht. Diese Phase kann Wochen oder sogar Monate dauern.",
      fr: "La p\u00E9riode de messagerie apr\u00E8s le match mais avant de commencer officiellement \u00E0 sortir ensemble. Cette phase peut durer des semaines voire des mois.",
      es: "El per\u00EDodo de mensajes despu\u00E9s del match pero antes de empezar a salir oficialmente. Esta fase puede durar semanas o incluso meses.",
    },
  },
  {
    slug: "red-flag",
    emoji: "\u{1F6A9}",
    terms: { tr: "Red Flag (K\u0131rm\u0131z\u0131 Bayrak)", en: "Red Flag", de: "Red Flag", fr: "Red Flag", es: "Red Flag (Bandera Roja)" },
    definitions: {
      tr: "Bir ili\u015Fkide veya dating s\u00FCrecinde potansiyel bir sorun oldu\u011Funa i\u015Faret eden uyar\u0131 belirtisi. \u00D6rne\u011Fin: a\u015F\u0131r\u0131 k\u0131skan\u00E7l\u0131k, kontrol etme iste\u011Fi, tutars\u0131z davran\u0131\u015Flar. Dating uygulamalar\u0131nda erken fark etmek \u00F6nemlidir.",
      en: "A warning sign that indicates a potential problem in a relationship or dating process. Examples: excessive jealousy, desire to control, inconsistent behavior. Important to recognize early on dating apps.",
      de: "Ein Warnsignal, das auf ein potenzielles Problem in einer Beziehung oder beim Dating hinweist. Beispiele: \u00FCberm\u00E4\u00DFige Eifersucht, Kontrollbed\u00FCrfnis, inkonsequentes Verhalten.",
      fr: "Un signal d'alerte qui indique un probl\u00E8me potentiel dans une relation ou un processus de rencontre. Exemples : jalousie excessive, d\u00E9sir de contr\u00F4le, comportement incoh\u00E9rent.",
      es: "Una se\u00F1al de advertencia que indica un problema potencial en una relaci\u00F3n o proceso de citas. Ejemplos: celos excesivos, deseo de control, comportamiento inconsistente.",
    },
  },
  {
    slug: "green-flag",
    emoji: "\u{1F7E2}",
    terms: { tr: "Green Flag (Ye\u015Fil Bayrak)", en: "Green Flag", de: "Green Flag", fr: "Green Flag", es: "Green Flag (Bandera Verde)" },
    definitions: {
      tr: "Bir ki\u015Finin iyi bir partner olabilece\u011Fine i\u015Faret eden olumlu belirtiler. \u00D6rne\u011Fin: iyi ileti\u015Fim, sayg\u0131l\u0131 davran\u0131\u015F, tutarl\u0131l\u0131k. Qulo'da sorular\u0131n cevaplar\u0131 ki\u015Finin green flag'lerini erken ortaya koyar.",
      en: "Positive signs indicating someone could be a good partner. Examples: good communication, respectful behavior, consistency. On Qulo, question answers reveal a person's green flags early on.",
      de: "Positive Zeichen, die darauf hindeuten, dass jemand ein guter Partner sein k\u00F6nnte. Beispiele: gute Kommunikation, respektvolles Verhalten, Best\u00E4ndigkeit.",
      fr: "Des signes positifs indiquant que quelqu'un pourrait \u00EAtre un bon partenaire. Exemples : bonne communication, comportement respectueux, coh\u00E9rence.",
      es: "Se\u00F1ales positivas que indican que alguien podr\u00EDa ser una buena pareja. Ejemplos: buena comunicaci\u00F3n, comportamiento respetuoso, consistencia.",
    },
  },
  {
    slug: "fomo",
    emoji: "\u{1F4F1}",
    terms: { tr: "FOMO (Ka\u00E7\u0131rma Korkusu)", en: "FOMO (Fear of Missing Out)", de: "FOMO", fr: "FOMO", es: "FOMO" },
    definitions: {
      tr: "Dating ba\u011Flam\u0131nda, 'daha iyi biri olabilir' d\u00FC\u015F\u00FCncesiyle mevcut e\u015Fle\u015Fmeyi de\u011Ferlendirmeme. Swipe tabanl\u0131 uygulamalarda \u00E7ok yayg\u0131n olan bu durum, Qulo'da efor gerektiren e\u015Fle\u015Fme sayesinde azal\u0131r.",
      en: "In dating context, not appreciating current matches due to the thought that 'someone better might be out there.' Very common on swipe-based apps, this is reduced on Qulo thanks to effort-based matching.",
      de: "Im Dating-Kontext: aktuelle Matches nicht wertsch\u00E4tzen, weil man denkt, dass 'jemand Besseres da drau\u00DFen sein k\u00F6nnte.' Auf Swipe-basierten Apps sehr verbreitet.",
      fr: "Dans le contexte du dating, ne pas appr\u00E9cier ses matchs actuels en pensant que 'quelqu'un de mieux pourrait exister'. Tr\u00E8s courant sur les apps de swipe.",
      es: "En el contexto de las citas, no valorar los matches actuales por pensar que 'alguien mejor podr\u00EDa estar ah\u00ED fuera'. Muy com\u00FAn en apps basadas en swipe.",
    },
  },
  {
    slug: "match",
    emoji: "\u{1F495}",
    terms: { tr: "Match (E\u015Fle\u015Fme)", en: "Match", de: "Match", fr: "Match", es: "Match" },
    definitions: {
      tr: "\u0130ki kullan\u0131c\u0131n\u0131n kar\u015F\u0131l\u0131kl\u0131 olarak birbirini be\u011Fenmesi sonucu olu\u015Fan ba\u011Flant\u0131. Geleneksel uygulamalarda kar\u015F\u0131l\u0131kl\u0131 swipe ile, Qulo'da ise t\u00FCm sorular\u0131n do\u011Fru cevaplanmas\u0131yla ger\u00E7ekle\u015Fir.",
      en: "A connection formed when two users mutually express interest. On traditional apps through mutual swiping, on Qulo through answering all questions correctly.",
      de: "Eine Verbindung, die entsteht, wenn zwei Nutzer gegenseitig Interesse zeigen. Bei traditionellen Apps durch gegenseitiges Swipen, bei Qulo durch das korrekte Beantworten aller Fragen.",
      fr: "Une connexion form\u00E9e lorsque deux utilisateurs expriment mutuellement leur int\u00E9r\u00EAt. Sur les apps traditionnelles par swipe mutuel, sur Qulo en r\u00E9pondant correctement \u00E0 toutes les questions.",
      es: "Una conexi\u00F3n formada cuando dos usuarios expresan inter\u00E9s mutuamente. En apps tradicionales mediante swipe mutuo, en Qulo respondiendo correctamente todas las preguntas.",
    },
  },
  {
    slug: "super-like",
    emoji: "\u2B50",
    terms: { tr: "Super Like", en: "Super Like", de: "Super Like", fr: "Super Like", es: "Super Like" },
    definitions: {
      tr: "Normal be\u011Feniden daha g\u00FC\u00E7l\u00FC bir ilgi ifadesi. Kar\u015F\u0131 tarafa \u00F6zellikle ilgilendi\u011Finizi g\u00F6sterir. Qulo'da benzer konsept 'g\u00FC\u00E7 kullan\u0131m\u0131' (power) olarak uygulan\u0131r \u2014 sorulara ekstra efor g\u00F6stermek.",
      en: "A stronger expression of interest than a regular like. Shows the other person you're especially interested. On Qulo, a similar concept applies as 'power usage' \u2014 putting extra effort into answering questions.",
      de: "Ein st\u00E4rkerer Ausdruck des Interesses als ein normales Like. Zeigt der anderen Person, dass man besonders interessiert ist.",
      fr: "Une expression d'int\u00E9r\u00EAt plus forte qu'un like normal. Montre \u00E0 l'autre personne que vous \u00EAtes particuli\u00E8rement int\u00E9ress\u00E9.",
      es: "Una expresi\u00F3n de inter\u00E9s m\u00E1s fuerte que un like normal. Muestra a la otra persona que est\u00E1s especialmente interesado.",
    },
  },
  {
    slug: "compatibility",
    emoji: "\u{1F9E9}",
    terms: { tr: "Uyumluluk", en: "Compatibility", de: "Kompatibilit\u00E4t", fr: "Compatibilit\u00E9", es: "Compatibilidad" },
    definitions: {
      tr: "\u0130ki ki\u015Finin de\u011Ferler, ya\u015Fam tarz\u0131, ileti\u015Fim bi\u00E7imi ve hedefler a\u00E7\u0131s\u0131ndan ne kadar iyi uyu\u015Ftu\u011Fu. Qulo'nun temel felsefesi uyumluluk \u00F6l\u00E7\u00FCm\u00FCne dayan\u0131r \u2014 sorular arac\u0131l\u0131\u011F\u0131yla ger\u00E7ek uyumluluk test edilir.",
      en: "How well two people align in terms of values, lifestyle, communication style, and goals. Qulo's core philosophy is built on measuring compatibility \u2014 real compatibility is tested through questions.",
      de: "Wie gut zwei Menschen in Bezug auf Werte, Lebensstil, Kommunikationsstil und Ziele zusammenpassen. Qulos Kernphilosophie basiert auf der Messung von Kompatibilit\u00E4t.",
      fr: "La mesure dans laquelle deux personnes s'alignent en termes de valeurs, style de vie, communication et objectifs. La philosophie fondamentale de Qulo repose sur la mesure de la compatibilit\u00E9.",
      es: "Qu\u00E9 tan bien se alinean dos personas en t\u00E9rminos de valores, estilo de vida, comunicaci\u00F3n y objetivos. La filosof\u00EDa central de Qulo se basa en medir la compatibilidad.",
    },
  },
  {
    slug: "quiz-dating",
    emoji: "\u2753",
    terms: { tr: "Quiz Dating", en: "Quiz Dating", de: "Quiz Dating", fr: "Quiz Dating", es: "Quiz Dating" },
    definitions: {
      tr: "Swipe yerine soru-cevap mekanizmas\u0131 kullanan dating yakla\u015F\u0131m\u0131. Kullan\u0131c\u0131lar sorular haz\u0131rlar, di\u011Fer kullan\u0131c\u0131lar bu sorular\u0131 \u00E7\u00F6zer, do\u011Fru cevaplayan ki\u015Fiyle e\u015Fle\u015Fme ger\u00E7ekle\u015Fir. Qulo, quiz dating konseptinin \u00F6nc\u00FCs\u00FCd\u00FCr.",
      en: "A dating approach that uses question-and-answer mechanics instead of swiping. Users create questions, others solve them, and matching occurs with correct answers. Qulo is the pioneer of the quiz dating concept.",
      de: "Ein Dating-Ansatz, der Frage-Antwort-Mechaniken statt Swipen verwendet. Nutzer erstellen Fragen, andere l\u00F6sen sie, und Matching erfolgt bei richtigen Antworten. Qulo ist der Pionier des Quiz-Dating-Konzepts.",
      fr: "Une approche de dating qui utilise des m\u00E9caniques de questions-r\u00E9ponses au lieu du swipe. Les utilisateurs cr\u00E9ent des questions, d'autres les r\u00E9solvent, et le match se fait avec les bonnes r\u00E9ponses. Qulo est le pionnier du concept de quiz dating.",
      es: "Un enfoque de citas que usa mec\u00E1nicas de preguntas y respuestas en lugar de deslizar. Los usuarios crean preguntas, otros las resuelven, y el match ocurre con las respuestas correctas. Qulo es el pionero del concepto de quiz dating.",
    },
  },
];
