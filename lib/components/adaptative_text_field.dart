import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final String? label;
  final TextInputType? keyboardType;
  
  const AdaptativeTextfield({super.key, this.controller, this.label, this.onSubmitted, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
    )
    :
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        controller: controller,
        onSubmitted: onSubmitted,
        placeholder: label,
        keyboardType: keyboardType,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 6, vertical: 12),
      ),
    )
    ;
  }
}