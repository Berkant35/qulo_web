import 'package:flutter/material.dart';

class ComplexInherited extends InheritedWidget {
  ComplexInherited({
    super.key,
    required super.child,
  });

  final String jiraSoftwareExampleDomainText =
      "https://{your-domain}.atlassian.net";

  final TextEditingController clickUpApiKey = TextEditingController();
  final TextEditingController jiraSoftwareIntegrationApiKey =
      TextEditingController();
  final TextEditingController jiraSoftwareIntegrationDomainUserName =
      TextEditingController();

  final clickUpApiKeyForm = GlobalKey<FormState>();
  final jiraSoftwareIntegrationApiKeyForm = GlobalKey<FormState>();

  static ComplexInherited of(BuildContext context) {
    final ComplexInherited? result =
        context.dependOnInheritedWidgetOfExactType<ComplexInherited>();
    assert(result != null, 'No ComplexInherited found in context');
    return result!;
  }

  //Trigger anında alanları güncellememizi sağlar
  @override
  bool updateShouldNotify(ComplexInherited old) {
    return true;
  }
}
