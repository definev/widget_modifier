import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TooltipThemeModifier extends SingleChildStatelessModifier {
  const TooltipThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

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
