import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a bottom navigation bar theme to descendant [BottomNavigationBar]
/// widgets.
///
/// Descendant widgets obtain the current theme's [BottomNavigationBarTheme]
/// object using [BottomNavigationBarTheme.of]. When a widget uses
/// [BottomNavigationBarTheme.of], it is automatically rebuilt if the theme
/// later changes.
///
/// A bottom navigation theme can be specified as part of the overall Material
/// theme using [ThemeData.bottomNavigationBarTheme].
///
/// See also:
///
///  * [BottomNavigationBarThemeData], which describes the actual configuration
///    of a bottom navigation bar theme.
class BottomNavigationBarThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a bottom navigation bar theme that configures all descendant
  /// [BottomNavigationBar] widgets.
  ///
  /// The [data] must not be null.
  const BottomNavigationBarThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties used for all descendant [BottomNavigationBar] widgets.
  final BottomNavigationBarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BottomNavigationBarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
