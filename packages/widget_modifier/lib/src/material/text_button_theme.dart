import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TextButtonThemeModifier extends SingleChildStatelessModifier {
  const TextButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final TextButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
