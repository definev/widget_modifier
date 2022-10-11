import 'package:flutter/material.dart';

import '../modifier.dart';

/// Overrides the default [ButtonStyle] of its [OutlinedButton] descendants.
///
/// See also:
///
///  * [OutlinedButtonThemeData], which is used to configure this theme.
///  * [OutlinedButton.defaultStyleOf], which returns the default [ButtonStyle]
///    for outlined buttons.
///  * [OutlinedButton.styleFrom], which converts simple values into a
///    [ButtonStyle] that's consistent with [OutlinedButton]'s defaults.
///  * [ThemeData.outlinedButtonTheme], which can be used to override the default
///    [ButtonStyle] for [OutlinedButton]s below the overall [Theme].
class OutlinedButtonThemeModifier extends SingleChildStatelessModifier {
  /// Create a [OutlinedButtonTheme].
  ///
  /// The [data] parameter must not be null.
  const OutlinedButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The configuration of this theme.
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
