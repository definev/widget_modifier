import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class SwitchThemeModifier extends SingleChildStatelessModifier {
  const SwitchThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final SwitchThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SwitchTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
