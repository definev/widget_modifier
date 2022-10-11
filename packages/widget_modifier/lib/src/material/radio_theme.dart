import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a radio theme to descendant [Radio] widgets.
///
/// Descendant widgets obtain the current theme's [RadioTheme] object using
/// [RadioTheme.of]. When a widget uses [RadioTheme.of], it is automatically
/// rebuilt if the theme later changes.
///
/// A radio theme can be specified as part of the overall Material theme using
/// [ThemeData.radioTheme].
///
/// See also:
///
///  * [RadioThemeData], which describes the actual configuration of a radio
///    theme.
class RadioThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a radio theme that configures all descendant [Radio] widgets.
  const RadioThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });


  /// The properties used for all descendant [Radio] widgets.
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
