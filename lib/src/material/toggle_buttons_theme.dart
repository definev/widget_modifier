import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ToggleButtonsThemeModifier extends SingleChildStatelessModifier {
  const ToggleButtonsThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final ToggleButtonsThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ToggleButtonsTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
