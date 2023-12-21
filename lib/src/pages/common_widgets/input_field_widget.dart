import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    super.key,
    this.label,
    required this.icon,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.keyboarType,
    this.onSaved,
    this.formFieldKey,
  });

  final String? label;
  final Icon icon;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? keyboarType;
  final GlobalKey<FormFieldState>? formFieldKey;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool isObscure = true;

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        keyboardType: widget.keyboarType,
        controller: widget.controller,
        validator: widget.validator,
        onSaved: widget.onSaved,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          prefixIcon: widget.icon,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: const Icon(Icons.visibility))
              : null,
          labelText: widget.label,
        ),
      ),
    );
  }
}
