import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class TextSelectionThemeModifier extends SingleChildStatelessWidget {
  const TextSelectionThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
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
