import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a switch theme to descendant [Switch] widgets.
///
/// Descendant widgets obtain the current theme's [SwitchTheme] object using
/// [SwitchTheme.of]. When a widget uses [SwitchTheme.of], it is automatically
/// rebuilt if the theme later changes.
///
/// A switch theme can be specified as part of the overall Material theme using
/// [ThemeData.switchTheme].
///
/// See also:
///
///  * [SwitchThemeData], which describes the actual configuration of a switch
///    theme.
class SwitchThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a switch theme that configures all descendant [Switch] widgets.
  const SwitchThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties used for all descendant [Switch] widgets.
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
