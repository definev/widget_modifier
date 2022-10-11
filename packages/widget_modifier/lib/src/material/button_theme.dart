import 'package:flutter/material.dart';

import '../modifier.dart';

/// Used with [ButtonThemeData] to configure the color and geometry of buttons.
///
/// This class is planned to be deprecated in a future release.
/// Please use one or more of these buttons and associated themes instead:
///
///  * [TextButton], [TextButtonTheme], [TextButtonThemeData],
///  * [ElevatedButton], [ElevatedButtonTheme], [ElevatedButtonThemeData],
///  * [OutlinedButton], [OutlinedButtonTheme], [OutlinedButtonThemeData]
///
/// A button theme can be specified as part of the overall Material theme
/// using [ThemeData.buttonTheme]. The Material theme's button theme data
/// can be overridden with [ButtonTheme].
///
/// The actual appearance of buttons depends on the button theme, the
/// button's enabled state, its elevation (if any), and the overall [Theme].
///
/// See also:
///
///  * [RawMaterialButton], which can be used to configure a button that doesn't
///    depend on any inherited themes.
class ButtonThemeModifier extends SingleChildStatelessModifier {
  /// Creates a button theme.
  ///
  /// The [textTheme], [minWidth], [height], and [colorScheme] arguments
  /// must not be null.
  ButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    ButtonTextTheme textTheme = ButtonTextTheme.normal,
    ButtonBarLayoutBehavior layoutBehavior = ButtonBarLayoutBehavior.padded,
    double minWidth = 88.0,
    double height = 36.0,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    bool alignedDropdown = false,
    Color? buttonColor,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    ColorScheme? colorScheme,
    MaterialTapTargetSize? materialTapTargetSize,
  })  : data = ButtonThemeData(
          textTheme: textTheme,
          minWidth: minWidth,
          height: height,
          padding: padding,
          shape: shape,
          alignedDropdown: alignedDropdown,
          layoutBehavior: layoutBehavior,
          buttonColor: buttonColor,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorScheme: colorScheme,
          materialTapTargetSize: materialTapTargetSize,
        );

  /// Creates a button theme from [data].
  ///
  /// The [data] argument must not be null.
  const ButtonThemeModifier.fromButtonThemeData({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the color and geometry of buttons.
  final ButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ButtonTheme.fromButtonThemeData(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
