import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class OutlinedButtonThemeModifier extends SingleChildStatelessModifier {
  const OutlinedButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final OutlinedButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OutlinedButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
