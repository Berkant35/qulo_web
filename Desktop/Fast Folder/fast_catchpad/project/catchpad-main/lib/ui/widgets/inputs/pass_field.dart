import 'package:flutter/material.dart';

class PassField extends StatefulWidget {
  final TextFormField field;
  final bool initiallyObscure;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  const PassField({
    required this.field,
    this.initiallyObscure = true,
    this.onChanged,
    this.controller,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<PassField> createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  @override
  void didChangeDependencies() {
    _ob = widget.initiallyObscure;
    super.didChangeDependencies();
  }

  bool _ob = true;

  void _toggleObscure() {
    _ob ^= true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          obscureText: _ob,
          onChanged: widget.onChanged,
          controller: widget.controller,
          validator: widget.validator,
        ),
        PositionedDirectional(
          end: 0,
          child: IconButton(
            onPressed: _toggleObscure,
            icon: Icon(
              _ob ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ],
    );
  }
}
