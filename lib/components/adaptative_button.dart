import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final ButtonStyle? style;

  const AdaptativeButton({super.key, required this.label, required, required this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    FilledButton(
      onPressed: onPressed, 
      style: style,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).appBarTheme.foregroundColor
        ),
      )
    )
    :
    CupertinoButton(
      color: Theme.of(context).appBarTheme.foregroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      onPressed: onPressed, 
      child: Text(label)
    )
    ;
  }
}