import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TimePickerThemeModifier extends SingleChildStatelessModifier {
  const TimePickerThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final TimePickerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TimePickerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
