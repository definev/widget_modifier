import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class TextButtonModifier extends SingleChildStatelessModifier {
  const TextButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
  });

  static SingleChildModifier icon({
    Key? key,
    Key? modifierKey,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) =>
      _TextButtonWithIcon(
        key: key,
        modifierKey: modifierKey,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        onHover: onHover,
        onLongPress: onLongPress,
        style: style,
        icon: icon,
        label: label,
        onPressed: onPressed,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
      );

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialStatesController? statesController;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButton(
      key: modifierKey,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      style: style,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onPressed: onPressed,
      child: child!,
    );
  }
}

class _TextButtonWithIcon extends SingleChildStatelessModifier {
  const _TextButtonWithIcon({
    super.key,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final Clip? clipBehavior;
  final bool? autofocus;
  final Widget icon;
  final Widget label;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButton.icon(
      key: modifierKey,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      style: style,
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
