import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TextSelectionToolbarTextButtonModifier extends SingleChildStatelessModifier {
  const TextSelectionToolbarTextButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.padding,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final EdgeInsets padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextSelectionToolbarTextButton(
      key: modifierKey,
      onPressed: onPressed,
      padding: padding,
      child: child!,
    );
  }
}
