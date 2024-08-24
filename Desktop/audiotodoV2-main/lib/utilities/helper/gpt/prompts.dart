final class Prompts {
  static Map<String, dynamic> promptV1 = {
    "language": "meeting_lang_code",
    "meet_pure_text": "meeting_text",
    "meet_suggested_title": "meet_suggested_title",
    "meet_content_summarize": "meeting_content_summarize",
    "recognize_person_names": ['meeting_person_names'],
    "todos": [todoMap]
  };

  static Map<String,dynamic> todoMap = {
    "todo_title": "per_todo_title",
    "todo_content": "per_todo_content",
    "deadline": "",
    "tags": ['per_todo_tags'],
    "deadline_time": "",
    "created_time": "",
    "assigned_persons" : []
  };

  static Map<String,dynamic> periodicTodoList = {
    "todos" : [
      todoMap,
      todoMap
    ]
  };


  //Token sınırlaması için bunu yapıyoruz!

  static String getPromptPeriodicText(String periodicText,String detectedLanguageCode) {

    return "'$periodicText' bu metin için bana '$periodicTodoList' bu JSON formatına uygun olarak doldurun:"
        "todo_title todoya başlık bul ve {per_todo_title} yerine koy"
        "$detectedLanguageCode diline göre metinlerini yaz."
        "todo_content todoya içeriğinin ne olduğunu yaz ve {per_todo_content} yerine koy"
        "assigned_persons değerini toplantı metninden çıkarılan todo'nun içeriğine göre kişileri yaz 1 den fazla olabilir iki kelimeyi geçmesin ve ['{assigned_persons}'] şeklinde dizi simgesinin içerisine string değerler olarak koy"
        "deadline_time todonun ne zaman yapılması gerektiğini metinden çıkarabiliyorsan eğer  {{per_todo_deadline_time}} yerine koy yoksa null yaz"
        "tags değerini toplantı metninden çıkarılan todo'nun içeriğine göre etiket yaz 1 den fazla olabilir iki kelimeyi geçmesin ve ['{per_todo_tags}'] şeklinde dizi simgesinin içerisine string değerler olarak koy"
        "deadline kaç gün de yapılabilirliğini tahmin et ve onu   {per_todo_deadline} yerine  başında tahmini kelimesini ile birlikte koy yani 'Tahmini {per_todo_deadline} gün içerisinde yapılabilir.'"
        "created_time bugünün tarihini dd.MM.yyyy hh:mm:ss formatında yaz ve {per_todo_created_time} yerine koy"
        "hiç bir şekilde '\' veya '\n' gibi kaçış karakterleri kullanma";
  }



  static String getPromptText(String meetingText) {
    return "'$meetingText' Lütfen bu metni inceleyin ve içerisinde yer alan değerleri çıkararak  '${promptV1.toString()}' bu JSON formatına uygun olarak doldurun:\n\n"
        "Eğer Toplantı metin boş ise 'null' yazıp dönmeniz yeterli olacaktır.\n"
        "Bütün key değerlerini '$meetingText' burdaki metinden çıkarmalısı."
        "Value içerisinde yer alan [] karakterlerini sil ve içerisine belirlemiş olduğun değerleri gir"
        "json içerisindeki key değerlerini mutlaka '' içerisine almalısın!!"
        "Bu prompt'ta yazan koşullara göre bana bu json'ı doldur"
        "tags değerini toplantı metninden çıkarılan todo'nun içeriğine göre etiket yaz 1 den fazla olabilir"
        "deadline_time sence bu yapılacak iş ne kadar süreri bu değerin içerisine yaz yine toplantı metninden çıkarılacak olan tododaki içeriğe göre tahmin et ve o tarihi mevcut tarihe göre ekleyip yaz"
        "deadline mevcut olan todo ne kadar süreri bu değerin içerisine yaz"
        "meet_suggested_title değerini toplantının içeriğine göre başlık öner.\n"
        "Eğer Toplantı metin boş ise recognize_person_names değerine boş liste koyabilirsin yazıp dönmeniz yeterli olacaktır.\n"
        "meet_pure_text değerini $meetingText kısmını imla kurallarını düzelterek ve anlamsız cümle varsa onları düzelterek koymalısın\n"
        "meet_content_summarize değerini toplantı metninden çıkarılan todo'nun içeriğine göre özet yaz"
        // "created_time o anki zaman değeri neyse onu koy 'dd:mm:yyyy' formatta olsun"
        "${promptV1.toString()} JSON Formatının içerisinde bulunan 'todos' değerini '${todoMap.toString()}' JSON'lar oluşturarak listeyi oluştur. Bu işlemleri '$meetingText' burdaki toplantı metnini referans almalısın burası çok önemli kesinlikle içerisini bu metindeki konuşmalardan yola çıkarak doldurmalısın"
        "Eeğer 'todos' değerini doldurabilecek kadar görev yoksa '[]' boş liste dönmeniz yeterli olacaktır.\n\n"
        "Bu isteğime cevap verirken sadece json olarak cevap ver."
        "Sana gönderilen '${promptV1.toString()}' formatı gönderdiğim metine göre doldur karşılığı yoksa boş bırak."
        "todos: içerisindeki liste boş ise  '[]' bunu yazman yeterli"
        'Bütün söylediklerimi tırnak işaretleri('') içerisinde bulunan toplantı metninden faydalan'
        "Hiç bir açıklama yapma! Sadece json formatında cevap ver.\n\n"
        "tek tırnaklarla belirttiğim toplantı metnine göre dediklerimi gerçekleştir."
        "${promptV1.toString()} burda yer alan language ne ise tüm özetin ve pure textin metni o olması gerekiyor bu kritik!";
  }
}
