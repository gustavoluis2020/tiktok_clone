import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFieldModel {
  InputTextFieldModel({
    required this.controller,
    this.text,
    this.isPassword,
    this.type,
    required this.validator,
    required this.formatters,
    this.onChanged,
    this.prefix,
    this.readOnly,
    this.isEnable = true,
    this.onFieldSubmitted,
    this.disableCheckIcon = false,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? text;
  final bool? isPassword;
  final TextInputType? type;
  final String? Function(String?) validator;
  final List<TextInputFormatter> formatters;
  final Function(String)? onChanged;
  final Widget? prefix;
  final bool? readOnly;
  final bool isEnable;
  void Function(String)? onFieldSubmitted;
  final bool disableCheckIcon;
  FocusNode? focusNode;
}
