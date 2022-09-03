import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TooltipVisibilityModifier extends SingleChildStatelessModifier {
  const TooltipVisibilityModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.visible,
  });

  final bool visible;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TooltipVisibility(
      key: modifierKey,
      visible: visible,
      child: child!,
    );
  }
}
