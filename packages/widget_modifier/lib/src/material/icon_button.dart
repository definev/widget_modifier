import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class IconButtonModifier extends SingleChildStatelessModifier {
  const IconButtonModifier({
    super.key,
    super.modifierKey,
    this.iconSize,
    this.visualDensity,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback = true,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
  });

  final double? iconSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  final double? splashRadius;
  final Widget icon;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? color;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? disabledColor;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool enableFeedback;
  final BoxConstraints? constraints;
  final ButtonStyle? style;
  final bool? isSelected;
  final Widget? selectedIcon;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IconButton(
      key: modifierKey,
      onPressed: onPressed,
      icon: icon,
      alignment: alignment,
      autofocus: autofocus,
      color: color,
      constraints: constraints,
      disabledColor: disabledColor,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusNode: focusNode,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      iconSize: iconSize,
      isSelected: isSelected,
      mouseCursor: mouseCursor,
      padding: padding,
      selectedIcon: selectedIcon,
      splashColor: splashColor,
      splashRadius: splashRadius,
      style: style,
      tooltip: tooltip,
      visualDensity: visualDensity,
    );
  }
}
