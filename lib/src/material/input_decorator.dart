import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class InputDecoratorModifier extends SingleChildStatelessWidget {
  const InputDecoratorModifier({
    super.key,
    this.modifierKey,
    required this.decoration,
    this.baseStyle,
    this.textAlign,
    this.textAlignVertical,
    this.isFocused = false,
    this.isHovering = false,
    this.expands = false,
    this.isEmpty = false,
  });

  final Key? modifierKey;
  final InputDecoration decoration;
  final TextStyle? baseStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool isFocused;
  final bool isHovering;
  final bool expands;
  final bool isEmpty;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InputDecorator(
      key: modifierKey,
      baseStyle: baseStyle,
      expands: expands,
      isEmpty: isEmpty,
      isFocused: isFocused,
      isHovering: isHovering,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      decoration: decoration,
      child: child,
    );
  }
}
