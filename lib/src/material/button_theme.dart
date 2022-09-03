import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ButtonThemeModifier extends SingleChildStatelessModifier {
  ButtonThemeModifier({
    Key? key,
    Widget? child,
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
        ),
        super(key: key, child: child);

  const ButtonThemeModifier.fromButtonThemeData({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

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
