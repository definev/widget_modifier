import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines the configuration for time pickers
/// displayed using [showTimePicker] in this widget's subtree.
///
/// Values specified here are used for time picker properties that are not
/// given an explicit non-null value.
class TimePickerThemeModifier extends SingleChildStatelessModifier {
  /// Creates a time picker theme that controls the configurations for
  /// time pickers displayed in its widget subtree.
  const TimePickerThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant time picker widgets.
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
