import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TextSelectionThemeModifier extends SingleChildStatelessModifier {
  const TextSelectionThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final TextSelectionThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextSelectionTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
