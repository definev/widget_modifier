import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class InputDecoratorModifier extends SingleChildStatelessModifier {
  const InputDecoratorModifier({
    super.key,
    super.modifierKey,
    required this.decoration,
    this.baseStyle,
    this.textAlign,
    this.textAlignVertical,
    this.isFocused = false,
    this.isHovering = false,
    this.expands = false,
    this.isEmpty = false,
  });

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
