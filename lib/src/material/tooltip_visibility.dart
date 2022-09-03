import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class TooltipVisibilityModifier extends SingleChildStatelessWidget {
  const TooltipVisibilityModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.visible,
  });

  final Key? modifierKey;
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
