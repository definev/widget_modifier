import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a checkbox theme to descendant [Checkbox] widgets.
///
/// Descendant widgets obtain the current theme's [CheckboxTheme] object using
/// [CheckboxTheme.of]. When a widget uses [CheckboxTheme.of], it is
/// automatically rebuilt if the theme later changes.
///
/// A checkbox theme can be specified as part of the overall Material theme
/// using [ThemeData.checkboxTheme].
///
/// See also:
///
///  * [CheckboxThemeData], which describes the actual configuration of a
///  checkbox theme.
class CheckboxThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a checkbox theme that configures all descendant [Checkbox]
  /// widgets.
  const CheckboxThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties used for all descendant [Checkbox] widgets.
  final CheckboxThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckboxTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
