import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ToggleButtonsThemeModifier extends SingleChildStatelessWidget {
  /// Creates a toggle buttons theme that controls the color and border
  /// parameters for [ToggleButtons].
  ///
  /// The data argument must not be null.
  const ToggleButtonsThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
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
