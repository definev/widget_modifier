import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class RawMaterialButtonModifier extends SingleChildStatelessModifier {
  const RawMaterialButtonModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 2.0,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 8.0,
    this.disabledElevation = 0.0,
    this.padding = EdgeInsets.zero,
    this.visualDensity = VisualDensity.standard,
    this.constraints = const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
    this.shape = const RoundedRectangleBorder(),
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    this.enableFeedback = true,
  })  : materialTapTargetSize = materialTapTargetSize ?? MaterialTapTargetSize.padded,
        super(key: key, child: child);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHighlightChanged;
  final MouseCursor? mouseCursor;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double elevation;
  final double hoverElevation;
  final double focusElevation;
  final double highlightElevation;
  final double disabledElevation;
  final EdgeInsetsGeometry padding;
  final VisualDensity visualDensity;
  final BoxConstraints constraints;
  final ShapeBorder shape;
  final Duration animationDuration;
  final MaterialTapTargetSize materialTapTargetSize;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final bool enableFeedback;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RawMaterialButton(
      key: modifierKey,
      animationDuration: animationDuration,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      constraints: constraints,
      disabledElevation: disabledElevation,
      elevation: elevation,
      enableFeedback: enableFeedback,
      fillColor: fillColor,
      focusColor: focusColor,
      focusElevation: focusElevation,
      focusNode: focusNode,
      highlightColor: highlightColor,
      highlightElevation: highlightElevation,
      hoverColor: hoverColor,
      hoverElevation: hoverElevation,
      materialTapTargetSize: materialTapTargetSize,
      mouseCursor: mouseCursor,
      onHighlightChanged: onHighlightChanged,
      onLongPress: onLongPress,
      padding: padding,
      shape: shape,
      splashColor: splashColor,
      textStyle: textStyle,
      visualDensity: visualDensity,
      onPressed: onPressed,
      child: child,
    );
  }
}
