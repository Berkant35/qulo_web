


import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IWordTemplateManager {
  Future<void> createDocument(WidgetRef ref);

  void definePageCount(String allTexts,WidgetRef ref);

  void setTemplateLogic(WidgetRef ref);

  Future<File> createContentOfDocx(WidgetRef ref);

}