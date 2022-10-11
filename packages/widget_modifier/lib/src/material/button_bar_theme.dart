import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a button bar theme to descendant [ButtonBar] widgets.
///
/// A button bar theme describes the layout and properties for the buttons
/// contained in a [ButtonBar].
///
/// Descendant widgets obtain the current theme's [ButtonBarTheme] object using
/// [ButtonBarTheme.of]. When a widget uses [ButtonBarTheme.of], it is automatically
/// rebuilt if the theme later changes.
///
/// A button bar theme can be specified as part of the overall Material theme
/// using [ThemeData.buttonBarTheme].
///
/// See also:
///
///  * [ButtonBarThemeData], which describes the actual configuration of a button
///    bar theme.
class ButtonBarThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a button bar theme that configures all descendent [ButtonBar]
  /// widgets.
  ///
  /// The [data] must not be null.
  const ButtonBarThemeModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.data,
  });

  /// The properties used for all descendant [ButtonBar] widgets.
  final ButtonBarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ButtonBarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
