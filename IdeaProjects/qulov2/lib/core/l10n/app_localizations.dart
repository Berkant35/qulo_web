import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  late final Map<String, String> _strings;

  AppLocalizations(this.locale) {
    _strings = _localizedValues[locale.languageCode] ?? _localizedValues['tr']!;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get(String key) => _strings[key] ?? key;

  String errorMessage(String code) {
    final key = 'error_${code.toLowerCase()}';
    return _strings[key] ?? _strings['error_unknown']!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'tr': _tr,
    'en': _en,
  };

  static const _tr = <String, String>{
    // General
    'app_name': 'Qulo',
    'ok': 'Tamam',
    'cancel': 'İptal',
    'save': 'Kaydet',
    'delete': 'Sil',
    'loading': 'Yükleniyor...',
    'error': 'Hata',
    'success': 'Başarılı',
    'retry': 'Tekrar Dene',
    'yes': 'Evet',
    'no': 'Hayır',

    // Auth
    'welcome_back': 'Tekrar hoş geldin',
    'login': 'Giriş Yap',
    'register': 'Kayıt Ol',
    'email': 'E-posta',
    'password': 'Şifre',
    'forgot_password': 'Şifremi unuttum?',
    'no_account': 'Hesabın yok mu?',
    'reset_password': 'Şifre Sıfırla',
    'reset_password_desc': 'E-posta adresini gir, sıfırlama bağlantısı gönderelim.',
    'send_reset_link': 'Sıfırlama Bağlantısı Gönder',
    'reset_email_sent': 'E-posta adresin kayıtlıysa sıfırlama bağlantısı gönderildi',
    'check_email': 'E-postanı kontrol et ve doğrula',
    'name': 'Ad',
    'surname': 'Soyad',
    'age': 'Yaş',
    'gender': 'Cinsiyet',
    'male': 'Erkek',
    'female': 'Kadın',

    // Validation
    'field_required': 'Bu alan zorunlu',
    'email_required': 'E-posta zorunlu',
    'email_invalid': 'Geçersiz e-posta',
    'password_required': 'Şifre zorunlu',
    'password_min': 'En az 8 karakter',
    'age_range': '18-99 arası',

    // Onboarding
    'onboarding_title_1': "Qulo'ya Hoş Geldin",
    'onboarding_sub_1': 'Soruları cevaplayarak eşleşme bul',
    'onboarding_title_2': 'Sorularını Hazırla',
    'onboarding_sub_2': 'Seninle eşleşmek isteyenler için 2-6 soru oluştur',
    'onboarding_title_3': 'Profilini Tamamla',
    'onboarding_sub_3': 'Fotoğraf ve bilgilerini ekleyerek öne çık',
    'next': 'İleri',
    'skip': 'Atla',
    'get_started': 'Başla',

    // Discover
    'discover': 'Keşfet',
    'no_more_profiles': 'Gösterilecek profil kalmadı',
    'refresh': 'Yenile',
    'questions_count': '{count} soru',

    // Quiz
    'quiz_match': 'Eşleşme!',
    'quiz_match_desc': 'Tüm soruları doğru cevapladın!',
    'quiz_failed': 'Başarısız',
    'quiz_failed_desc': 'Yanlış cevap. Bir dahaki sefere!',

    // Matches
    'matches': 'Eşleşmeler',
    'no_matches': 'Henüz eşleşme yok',
    'start_swiping': 'Eşleşme bulmak için keşfetmeye başla!',

    // Chat
    'chat': 'Sohbet',
    'say_hello': 'Merhaba de!',
    'message_hint': 'Mesaj...',
    'type_message': 'Mesaj yaz...',

    // Matches extras
    'new_matches': 'Yeni Eslesmeler',
    'solve_to_meet': 'Sorulari Coz',
    'online': 'Cevrimici',
    'offline': 'Cevrimdisi',

    // Profile
    'profile': 'Profil',
    'edit_profile': 'Profili Düzenle',
    'my_questions': 'Sorularım',
    'diamonds': 'Elmaslar',
    'passport': 'Pasaport',
    'complete': 'tamamlandı',

    // Questions
    'add_question': 'Yeni Soru',
    'question': 'Soru',
    'answer_n': 'Cevap {n}',
    'correct_answer': 'Doğru Cevap',
    'min_questions': 'En az {count} soru ekle',
    'max_questions': 'En fazla 6 soru',

    // Diamonds
    'green_diamonds': 'Yeşil Elmaslar',
    'purple_diamonds': 'Mor Elmaslar',
    'purchase_purple': 'Mor Elmas Satın Al',
    'history': 'Geçmiş',
    'no_transactions': 'Henüz işlem yok',

    // Passport
    'passport_explore': 'Başka bir şehirdeki profilleri keşfet',
    'passport_cost': 'Maliyet: {cost} mor elmas / aktivasyon',
    'passport_active': 'Aktif: {city}',
    'city': 'Şehir',
    'activate_passport': 'Pasaportu Aktifleştir',
    'deactivate': 'Deaktif Et',

    // Settings
    'settings': 'Ayarlar',
    'language': 'Dil',
    'theme': 'Tema',
    'theme_system': 'Sistem',
    'theme_light': 'Acik',
    'theme_dark': 'Koyu',
    'logout': 'Çıkış Yap',
    'logout_confirm': 'Çıkış yapmak istediğine emin misin?',
    'delete_account': 'Hesabı Sil',
    'delete_account_desc': 'Bu işlem geri alınamaz. Tüm verilerin silinecek.',

    // Powers
    'power_copy': 'Kopya',
    'power_half': '50/50',
    'power_skip': 'Geç',
    'power_hint': 'İpucu',
    'power_time': '+15sn',
    'power_skip_all': 'Hepsini Geç',

    // Error codes
    'error_invalid_credentials': 'Email veya şifre hatalı',
    'error_email_already_exists': 'Bu email zaten kayıtlı',
    'error_email_not_verified': 'Lütfen önce emailinizi doğrulayın',
    'error_validation_error': 'Lütfen girişlerinizi kontrol edin',
    'error_rate_limited': 'Çok fazla deneme, lütfen daha sonra tekrar deneyin',
    'error_server_error': 'Bir hata oluştu, lütfen tekrar deneyin',
    'error_unknown': 'Beklenmeyen bir hata oluştu',

    // Register wizard
    'step_name': 'Adın ne?',
    'step_birthday': 'Doğum günün ne zaman?',
    'step_gender': 'Cinsiyetin ne?',
    'step_email': 'Hesabını oluştur',
    'step_terms': 'Neredeyse tamam!',
    'birthday': 'Doğum tarihi',
    'select_date': 'Tarih seçin',
    'must_be_18': 'En az 18 yaşında olmalısınız',
    'man': 'Erkek',
    'woman': 'Kadın',
    'other': 'Diğer',
    'continue_btn': 'Devam',
    'accept_terms': 'Kabul ediyorum:',
    'terms_of_service': 'Kullanım Koşulları',
    'privacy_policy': 'Gizlilik Politikası',
    'and_word': 've',
    'must_accept_terms': 'Devam etmek için koşulları kabul etmelisiniz',

    // Location step
    'step_location': 'Konumunu paylaş',
    'step_location_desc':
        'Yakınındaki kişilerle eşleşebilmemiz için konumuna ihtiyacımız var.',
    'enable_location': 'Konumu Etkinleştir',
    'location_granted': 'Konum alındı',
    'location_skip': 'Şimdilik atla',
    'location_service_disabled': 'Konum servisleri kapalı. Lütfen ayarlardan açın.',
    'location_permission_denied': 'Konum izni reddedildi.',
    'location_permission_denied_forever':
        'Konum izni kalıcı olarak reddedildi. Ayarlardan etkinleştirin.',
    'open_settings': 'Ayarları Aç',

    // Profile - Badge
    'badge_rookie': 'Çaylak',
    'badge_popular': 'Popüler',
    'badge_master': 'Profil Ustası',
    'badge_no_badge': 'Başlangıç',
    'badge_progress_hint': 'kaldı',
    'badge_reward_claimed': 'Tebrikler! Mor elmas kazandın!',
    'badge_discover_warning': 'Profilini tamamla, keşfette görün!',

    // Profile - Hints
    'hint_add_photos': '3 fotoğraf ekle → görünürlüğün %20 artar!',
    'hint_add_bio': 'Bio ekle → daha fazla eşleşme!',
    'hint_add_job': 'Mesleğini ekle → profilini tamamla!',
    'hint_add_details': 'Detaylarını ekle → profil seviyeni yükselt!',

    // Profile - Edit
    'edit_photos': 'Fotoğraflar',
    'edit_about': 'Hakkımda',
    'edit_basic_info': 'Temel Bilgiler',
    'edit_details': 'Detaylar',
    'edit_preferences': 'Tercihler',
    'save_changes': 'Değişiklikleri Kaydet',
    'bio_hint': 'Kendinden biraz bahset...',
    'update_location': 'Konumu Güncelle',
    'make_primary': 'Ana Fotoğraf Yap',
    'delete_photo': 'Fotoğrafı Sil',
    'delete_photo_confirm': 'Bu fotoğrafı silmek istediğine emin misin?',
    'photo_upload_error': 'Fotoğraf yüklenemedi',
    'photo_max_reached': 'En fazla 6 fotoğraf ekleyebilirsin',
    'changes_saved': 'Değişiklikler kaydedildi',
    'select_photo_source': 'Fotoğraf Kaynağı',
    'from_gallery': 'Galeriden Seç',
    'from_camera': 'Kamera',

    // Details labels
    'height': 'Boy',
    'weight': 'Kilo',
    'zodiac': 'Burç',
    'job': 'Meslek',
    'school': 'Okul',
    'smoking': 'Sigara',
    'alcohol': 'Alkol',
    'pets_label': 'Evcil Hayvan',
    'music_type': 'Müzik Türü',
    'personality': 'Kişilik',
    'cm': 'cm',
    'kg': 'kg',

    // Preferences
    'gender_preference': 'Cinsiyet Tercihi',
    'distance_range': 'Mesafe',
    'km': 'km',
    'men': 'Erkek',
    'women': 'Kadın',
    'both': 'Herkes',

    // Zodiac signs
    'zodiac_aries': 'Koç',
    'zodiac_taurus': 'Boğa',
    'zodiac_gemini': 'İkizler',
    'zodiac_cancer': 'Yengeç',
    'zodiac_leo': 'Aslan',
    'zodiac_virgo': 'Başak',
    'zodiac_libra': 'Terazi',
    'zodiac_scorpio': 'Akrep',
    'zodiac_sagittarius': 'Yay',
    'zodiac_capricorn': 'Oğlak',
    'zodiac_aquarius': 'Kova',
    'zodiac_pisces': 'Balık',

    // Frequency
    'freq_yes': 'Evet',
    'freq_no': 'Hayır',
    'freq_sometimes': 'Bazen',
  };

  static const _en = <String, String>{
    // General
    'app_name': 'Qulo',
    'ok': 'OK',
    'cancel': 'Cancel',
    'save': 'Save',
    'delete': 'Delete',
    'loading': 'Loading...',
    'error': 'Error',
    'success': 'Success',
    'retry': 'Retry',
    'yes': 'Yes',
    'no': 'No',

    // Auth
    'welcome_back': 'Welcome back',
    'login': 'Login',
    'register': 'Register',
    'email': 'Email',
    'password': 'Password',
    'forgot_password': 'Forgot password?',
    'no_account': "Don't have an account?",
    'reset_password': 'Reset Password',
    'reset_password_desc': 'Enter your email address and we will send you a link to reset your password.',
    'send_reset_link': 'Send Reset Link',
    'reset_email_sent': 'If your email exists, you will receive a reset link',
    'check_email': 'Check your email to verify',
    'name': 'Name',
    'surname': 'Surname',
    'age': 'Age',
    'gender': 'Gender',
    'male': 'Male',
    'female': 'Female',

    // Validation
    'field_required': 'This field is required',
    'email_required': 'Email is required',
    'email_invalid': 'Invalid email',
    'password_required': 'Password is required',
    'password_min': 'Min 8 characters',
    'age_range': '18-99',

    // Onboarding
    'onboarding_title_1': 'Welcome to Qulo',
    'onboarding_sub_1': 'Find your match by answering questions',
    'onboarding_title_2': 'Create Your Questions',
    'onboarding_sub_2': 'Prepare 2-6 questions for people who want to match with you',
    'onboarding_title_3': 'Complete Your Profile',
    'onboarding_sub_3': 'Add photos and details to stand out',
    'next': 'Next',
    'skip': 'Skip',
    'get_started': 'Get Started',

    // Discover
    'discover': 'Discover',
    'no_more_profiles': 'No more profiles',
    'refresh': 'Refresh',
    'questions_count': '{count} questions',

    // Quiz
    'quiz_match': 'Match!',
    'quiz_match_desc': 'You answered all questions correctly!',
    'quiz_failed': 'Failed',
    'quiz_failed_desc': 'Wrong answer. Better luck next time!',

    // Matches
    'matches': 'Matches',
    'no_matches': 'No matches yet',
    'start_swiping': 'Start swiping to find matches!',

    // Chat
    'chat': 'Chat',
    'say_hello': 'Say hello!',
    'message_hint': 'Message...',
    'type_message': 'Type a message...',

    // Matches extras
    'new_matches': 'New Matches',
    'solve_to_meet': 'Solve Questions',
    'online': 'Online',
    'offline': 'Offline',

    // Profile
    'profile': 'Profile',
    'edit_profile': 'Edit Profile',
    'my_questions': 'My Questions',
    'diamonds': 'Diamonds',
    'passport': 'Passport',
    'complete': 'complete',

    // Questions
    'add_question': 'New Question',
    'question': 'Question',
    'answer_n': 'Answer {n}',
    'correct_answer': 'Correct Answer',
    'min_questions': 'Add at least {count} questions',
    'max_questions': 'Max 6 questions',

    // Diamonds
    'green_diamonds': 'Green Diamonds',
    'purple_diamonds': 'Purple Diamonds',
    'purchase_purple': 'Purchase Purple Diamonds',
    'history': 'History',
    'no_transactions': 'No transactions yet',

    // Passport
    'passport_explore': 'Explore profiles in another city',
    'passport_cost': 'Cost: {cost} purple diamonds / activation',
    'passport_active': 'Active: {city}',
    'city': 'City',
    'activate_passport': 'Activate Passport',
    'deactivate': 'Deactivate',

    // Settings
    'settings': 'Settings',
    'language': 'Language',
    'theme': 'Theme',
    'theme_system': 'System',
    'theme_light': 'Light',
    'theme_dark': 'Dark',
    'logout': 'Logout',
    'logout_confirm': 'Are you sure you want to logout?',
    'delete_account': 'Delete Account',
    'delete_account_desc': 'This action is irreversible. All your data will be deleted.',

    // Powers
    'power_copy': 'Copy',
    'power_half': '50/50',
    'power_skip': 'Skip',
    'power_hint': 'Hint',
    'power_time': '+15s',
    'power_skip_all': 'Skip All',

    // Error codes
    'error_invalid_credentials': 'Email or password is incorrect',
    'error_email_already_exists': 'This email is already registered',
    'error_email_not_verified': 'Please verify your email first',
    'error_validation_error': 'Please check your input',
    'error_rate_limited': 'Too many attempts, please try again later',
    'error_server_error': 'Something went wrong, please try again',
    'error_unknown': 'An unexpected error occurred',

    // Register wizard
    'step_name': "What's your name?",
    'step_birthday': "When's your birthday?",
    'step_gender': 'How do you identify?',
    'step_email': 'Create your account',
    'step_terms': 'Almost there!',
    'birthday': 'Date of birth',
    'select_date': 'Select date',
    'must_be_18': 'You must be at least 18 years old',
    'man': 'Man',
    'woman': 'Woman',
    'other': 'Other',
    'continue_btn': 'Continue',
    'accept_terms': 'I accept the',
    'terms_of_service': 'Terms of Service',
    'privacy_policy': 'Privacy Policy',
    'and_word': 'and',
    'must_accept_terms': 'You must accept the terms to continue',

    // Location step
    'step_location': 'Share your location',
    'step_location_desc':
        'We need your location to match you with people nearby.',
    'enable_location': 'Enable Location',
    'location_granted': 'Location acquired',
    'location_skip': 'Skip for now',
    'location_service_disabled': 'Location services are off. Please enable in settings.',
    'location_permission_denied': 'Location permission denied.',
    'location_permission_denied_forever':
        'Location permission permanently denied. Enable in settings.',
    'open_settings': 'Open Settings',

    // Profile - Badge
    'badge_rookie': 'Rookie',
    'badge_popular': 'Popular',
    'badge_master': 'Profile Master',
    'badge_no_badge': 'Beginner',
    'badge_progress_hint': 'left',
    'badge_reward_claimed': 'Congratulations! You earned purple diamonds!',
    'badge_discover_warning': 'Complete your profile to appear in discover!',

    // Profile - Hints
    'hint_add_photos': 'Add 3 photos → 20% more visibility!',
    'hint_add_bio': 'Add a bio → more matches!',
    'hint_add_job': 'Add your job → complete your profile!',
    'hint_add_details': 'Add details → level up your profile!',

    // Profile - Edit
    'edit_photos': 'Photos',
    'edit_about': 'About Me',
    'edit_basic_info': 'Basic Info',
    'edit_details': 'Details',
    'edit_preferences': 'Preferences',
    'save_changes': 'Save Changes',
    'bio_hint': 'Tell a bit about yourself...',
    'update_location': 'Update Location',
    'make_primary': 'Make Primary Photo',
    'delete_photo': 'Delete Photo',
    'delete_photo_confirm': 'Are you sure you want to delete this photo?',
    'photo_upload_error': 'Failed to upload photo',
    'photo_max_reached': 'Maximum 6 photos allowed',
    'changes_saved': 'Changes saved',
    'select_photo_source': 'Photo Source',
    'from_gallery': 'Choose from Gallery',
    'from_camera': 'Camera',

    // Details labels
    'height': 'Height',
    'weight': 'Weight',
    'zodiac': 'Zodiac',
    'job': 'Job',
    'school': 'School',
    'smoking': 'Smoking',
    'alcohol': 'Alcohol',
    'pets_label': 'Pets',
    'music_type': 'Music Type',
    'personality': 'Personality',
    'cm': 'cm',
    'kg': 'kg',

    // Preferences
    'gender_preference': 'Gender Preference',
    'distance_range': 'Distance',
    'km': 'km',
    'men': 'Men',
    'women': 'Women',
    'both': 'Everyone',

    // Zodiac signs
    'zodiac_aries': 'Aries',
    'zodiac_taurus': 'Taurus',
    'zodiac_gemini': 'Gemini',
    'zodiac_cancer': 'Cancer',
    'zodiac_leo': 'Leo',
    'zodiac_virgo': 'Virgo',
    'zodiac_libra': 'Libra',
    'zodiac_scorpio': 'Scorpio',
    'zodiac_sagittarius': 'Sagittarius',
    'zodiac_capricorn': 'Capricorn',
    'zodiac_aquarius': 'Aquarius',
    'zodiac_pisces': 'Pisces',

    // Frequency
    'freq_yes': 'Yes',
    'freq_no': 'No',
    'freq_sometimes': 'Sometimes',
  };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['tr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
