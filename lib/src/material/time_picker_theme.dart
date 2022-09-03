import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class TimePickerThemeModifier extends SingleChildStatelessWidget {
  const TimePickerThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
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
