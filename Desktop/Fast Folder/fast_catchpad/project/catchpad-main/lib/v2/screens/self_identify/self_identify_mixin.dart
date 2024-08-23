import 'package:catchpad/v2/screens/self_identify/self_identify_screen.dart';
import 'package:flutter/material.dart';

mixin SelfIdentifyMixin on State<SelfIdentifyScreen> {
  bool isClickedOthers = false;
  int currentIndex = 0;

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final String pickedGender = '';

  String? selectedValue;

  @override
  final List<String> selectedItems = [];
  final List<String> otherItems = [];
  final TextEditingController textController = TextEditingController();

  String headline() {
    return titles[currentIndex];
  }

  void addItem() {
    if (textController.text.isNotEmpty) {
      setState(() {
        otherItems.add(textController.text);
        textController.clear();
      });
    }
  }

  void removeItem(String item) {
    setState(() {
      otherItems.remove(item);
    });
  }

  List<String> kilogram =
      List<String>.generate(111, (index) => '${(index + 40)}kg');

  List<String> height =
      List<String>.generate(101, (index) => '${(index + 120)}cm');

  List<String> gender = ['Erkek', 'Kadın'];
  final List<String> titles = [
    'Hadi gelin eğitiminizi kişiselleştirelim\nKendini nasıl tanımlarsın?',
    'Hangilerine ilgi duyarsın?',
    'Kendini geliştirmek istediğin alanları seç.',
    'Verileriniz gizlidir ve CatchPad deneyiminizi\nkişiselleştirmek için kullanılır.',
    'Verileriniz gizlidir ve CatchPad deneyiminizi\nkişiselleştirmek için kullanılır.'
  ];

  final List<List<String>> chipContents = [
    [
      'profesyonel sporcu',
      'genç sporcu <13',
      'liseli/üniversiteli sporcu',
      'fitness tutkunu',
      'spor/perfromans koçu',
      'fitness antrenörü',
      'kişisel antrenör',
      'eğitimci',
      'ebeveyn',
      'beden eğitimcisi',
      'organizatör',
      'tıbbi/fizik tedavi uzmanı'
    ],
    [
      'futbol',
      'fitness',
      'basketbol',
      'tenis',
      'floorball',
      'çim hokeyi',
      'voleybol',
      'buz hokeyi',
      'rugby/AFL',
      'masa tenisi',
      'dövüş sanatları',
      'golf',
      'boks',
      'squash',
      'kriket',
      'hentbol',
      'atletizm',
      'vücut sporları',
      'beyzbol',
      'fizyoterapi',
      'çocuk fitness',
      'diğer'
    ],
    [
      'core',
      'görüş açısı',
      'karar verme',
      'çeviklik',
      'koordinasyon',
      'hız',
      'denge',
      'ev etkinliği',
      'reaksiyon',
      'fitness',
      'öğrenme&hafıza',
      'kondisyon',
      'odak',
      'reaktif zeka',
      'dayanıklılık',
      'kardiyo',
      'işitsel zeka',
      'kalecilik',
      'diğer'
    ]
  ];
}
