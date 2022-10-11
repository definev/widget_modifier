import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a scrollbar theme to descendant [Scrollbar] widgets.
///
/// Descendant widgets obtain the current theme's [ScrollbarThemeData] using
/// [ScrollbarTheme.of]. When a widget uses [ScrollbarTheme.of], it is
/// automatically rebuilt if the theme later changes.
///
/// A scrollbar theme can be specified as part of the overall Material theme
/// using [ThemeData.scrollbarTheme].
///
/// See also:
///
///  * [ScrollbarThemeData], which describes the configuration of a
///    scrollbar theme.
class ScrollbarThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a scrollbar theme that configures all descendant [Scrollbar]
  /// widgets.
  const ScrollbarThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties used for all descendant [Scrollbar] widgets.
  final ScrollbarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScrollbarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
