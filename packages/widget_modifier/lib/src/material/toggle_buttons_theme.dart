import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines color and border parameters for
/// [ToggleButtons] in this widget's subtree.
///
/// Values specified here are used for [ToggleButtons] properties that are not
/// given an explicit non-null value.
class ToggleButtonsThemeModifier extends SingleChildStatelessModifier {
  /// Creates a toggle buttons theme that controls the color and border
  /// parameters for [ToggleButtons].
  ///
  /// The data argument must not be null.
  const ToggleButtonsThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the color and border values for descendant [ToggleButtons] widgets.
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
