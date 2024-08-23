import 'package:catchpad/v2/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin OnboardingMixin on ConsumerState<OnboardingScreen> {
  final description = '''
      Bilimsel temellere dayalı, özenle hazırlanmış egzersizleri keşfedin.
      İhtiyaca göre, antrenman ayarlarınızı özelleştirin. 
      Sizi motive eden antrenmanlarınızı yaratın. 
      ''';

  final title = 'Sınırsız Egzersiz Dünyası';

  int currentIndex = 0;
  double dragDistance = 0.0;

  final List<OnboardingContent> onboardingContents = [
    OnboardingContent(
        title: 'Potansiyelini Keşfet!',
        description: '''
      CatchPad'in interaktif egzersiz platformu sayesinde antrenmanlarınızı
      iyileştirin ve gerçek potansiyelinizi ortaya çıkarın. 
      ''',
        imagePath: 'assets/v2/onboarding/onboarding_1.png',
        imageType: ImageType.background),
    OnboardingContent(
        title: 'Sınırsız Egzersiz Dünyası',
        description: '''
      Bilimsel temellere dayalı, özenle hazırlanmış egzersizleri keşfedin.
      İhtiyaca göre, antrenman ayarlarınızı özelleştirin. 
      Sizi motive eden antrenmanlarınızı yaratın. 
      ''',
        imagePath: 'assets/v2/onboarding/onboarding_2.png',
        imageType: ImageType.frame),
    OnboardingContent(
        title: 'Performans Takibi',
        description: '''
   Her antrenmanınızın detaylı verilerini görüntüleyin 
   ve gelişiminizi izleyin. İstatistiklerinizi görsel 
   grafiklerle takip ederek hedeflerinize ulaşın.
      ''',
        imagePath: 'assets/v2/onboarding/onboarding_3.png',
        imageType: ImageType.frame),
    OnboardingContent(
        title: 'Harekete Geç!',
        description: '''
   İnteraktif Egzersiz Platformu CatchPad ile 
antrenmanları iyileştir, kendini geliştir!
      ''',
        imagePath: 'assets/v2/onboarding/onboarding_5.png',
        imageType: ImageType.background),
  ];

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    // Kaydırma mesafesini toplar.
    dragDistance += details.delta.dx;
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    // Eşik mesafesi belirlenir, ekran genişliğinin %20'si olarak.
    final double threshold = MediaQuery.of(context).size.width * 0.2;

    if (dragDistance.abs() > threshold) {
      if (dragDistance < 0 && currentIndex < onboardingContents.length - 1) {
        // next page
        setState(() {
          currentIndex++;
        });
      } else if (dragDistance > 0 && currentIndex > 0) {
        // previous page
        setState(() {
          currentIndex--;
        });
      }
    }

    // Kaydırma mesafesi sıfırlanır.
    dragDistance = 0.0;
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;
  final ImageType imageType;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.imageType,
  });
}

enum ImageType { background, frame }
