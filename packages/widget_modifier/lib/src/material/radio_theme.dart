import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class RadioThemeModifier extends SingleChildStatelessModifier {
  const RadioThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final RadioThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RadioTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
