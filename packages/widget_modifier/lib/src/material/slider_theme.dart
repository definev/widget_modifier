import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class SliderThemeModifier extends SingleChildStatelessModifier {
  const SliderThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final SliderThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliderTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
