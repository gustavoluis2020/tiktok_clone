import 'package:flutter/material.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/components/text_field/text_field_style.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    required this.model,
  });

  final InputTextFieldModel model;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool passwordHidden = true;
  bool? validationSuccess;

  void passwordToggle() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }

  @override
  void initState() {
    widget.model.controller.addListener(() {
      final validation = widget.model.validator(widget.model.controller.text);
      setState(() {
        validationSuccess = validation == null;
      });
    });
    super.initState();
  }

  Color? _buildValidationColor(bool skipSuccess) {
    if (validationSuccess == null) {
      return InputTextFieldStyle.validationInitialColor;
    }
    if (validationSuccess == false) {
      return InputTextFieldStyle.validationWarningColor;
    }
    if (skipSuccess) return InputTextFieldStyle.validationInitialColor;
    return InputTextFieldStyle.validationSuccessColor;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.model.readOnly ?? false,
      controller: widget.model.controller,
      onChanged: widget.model.onChanged,
      onFieldSubmitted: widget.model.onFieldSubmitted,
      obscureText: widget.model.isPassword! ? passwordHidden : false,
      cursorColor: InputTextFieldStyle.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        label: Text(
          widget.model.text!,
          style: const TextStyle(fontSize: 14),
          // style: TextStyle(
          //   color: _buildValidationColor(false)!,
          //  ), //   fontSize: 14),
        ),
        labelStyle: TextStyle(
          color: _buildValidationColor(true),
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: InputTextFieldStyle
                .focusedBorderColor, // _buildValidationColor(false)!, // InputTextFieldStyle.focusedBorderColor,
          ),
        ),
        suffixIcon: Builder(
          builder: (context) {
            final isPassword = widget.model.isPassword;
            if (isPassword!) {
              return InkWell(
                onTap: passwordToggle,
                child: Icon(
                  passwordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: _buildValidationColor(false),
                ),
              );
            }
            if (validationSuccess == null || widget.model.disableCheckIcon) {
              return const SizedBox.shrink();
            }
            return Icon(
              validationSuccess == true ? Icons.check : Icons.close,
              color: _buildValidationColor(false),
            );
          },
        ),
        prefix: widget.model.prefix,
      ),
      keyboardType: widget.model.type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.model.validator,
      inputFormatters: widget.model.formatters,
      enabled: widget.model.isEnable,
    );
  }
}
