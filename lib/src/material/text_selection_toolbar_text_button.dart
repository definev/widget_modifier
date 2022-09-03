import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class TextSelectionToolbarTextButtonModifier
    extends SingleChildStatelessWidget {
  const TextSelectionToolbarTextButtonModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.padding,
    this.onPressed,
  });

  final Key? modifierKey;
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
