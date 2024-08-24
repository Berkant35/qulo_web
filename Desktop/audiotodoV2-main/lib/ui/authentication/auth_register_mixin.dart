//create mixin for auth_register

part of 'auth_register.dart';

mixin _AuthRegisterMixin on ConsumerState<AuthRegisterPage> {
  late TextEditingController userNameController;
  late TextEditingController surnameController;
  late TextEditingController mailController;
  late TextEditingController passwordController;
  late TextEditingController againPasswordController;
  final registerKey = GlobalKey<FormState>();
  static const _registerLoginKey = "register_button";

  bool formPrivacyChecked = false;


  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: kDebugMode ? "Berkant": null);
    surnameController = TextEditingController(text: kDebugMode ? "Çalıkuşu": null);
    mailController = TextEditingController(text: kDebugMode ? "berkantC93@gmail.com": null);
    passwordController = TextEditingController(text: kDebugMode ? "12345678": null);
    againPasswordController = TextEditingController(text: kDebugMode ? "12345678": null);
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    surnameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    againPasswordController.dispose();
  }

  List<Widget> getFormFields() {
    return [
      RowFormField(
          headerName: S.current.username,
          inputType: TextInputType.text,
          editingController: userNameController,
          custValidateFunction: (value) =>
              value!.isEmpty ? S.current.blank_empty : null),
      RowFormField(
          headerName: S.current.surname,
          inputType: TextInputType.text,
          editingController: surnameController,
          custValidateFunction: (value) =>
              value!.isEmpty ? S.current.blank_empty : null),
      RowFormField(
          headerName: S.current.email,
          inputType: TextInputType.emailAddress,
          editingController: mailController,
          custValidateFunction: (value) =>
              value!.isEmpty ? S.current.blank_empty : null),
      RowFormField(
        editingController: passwordController,
        headerName: S.current.password,
        visibleStatus: true,
        custValidateFunction: (value) => value != null && value.isNotEmpty
            ? value.length >= 8
                ? null
                : S.current.password_min_eight_character
            : S.current.blank_empty,
      ),
      RowFormField(
        editingController: againPasswordController,
        headerName: S.current.password,
        visibleStatus: true,
        custValidateFunction: (value) => value != null && value.isNotEmpty
            ? value.length >= 8
                ? againPasswordController.text != passwordController.text
                    ? S.current.passwords_not_same
                    : null
                : S.current.password_min_eight_character
            : S.current.blank_empty,
      )
    ];
  }
}
