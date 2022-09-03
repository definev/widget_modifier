import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class TooltipThemeModifier extends SingleChildStatelessWidget {
  const TooltipThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final TooltipThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TooltipTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
