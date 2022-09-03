import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class OutlinedButtonModifier extends SingleChildStatelessWidget {
  const OutlinedButtonModifier({
    super.key,
    super.child,
    this.modifierKey,
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
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) =>
      _OutlinedButtonWithIcon(
        autofocus: autofocus,
        key: key,
        modifierKey: modifierKey,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        onLongPress: onLongPress,
        style: style,
        onPressed: onPressed,
        icon: icon,
        label: label,
      );

  final Key? modifierKey;
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
    return OutlinedButton(
      key: modifierKey,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      style: style,
      onPressed: onPressed,
      child: child!,
    );
  }
}

class _OutlinedButtonWithIcon extends SingleChildStatelessWidget {
  const _OutlinedButtonWithIcon({
    super.key,
    this.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    required this.icon,
    required this.label,
  });

  final Key? modifierKey;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final Widget icon;
  final Widget label;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OutlinedButton.icon(
      key: modifierKey,
      onPressed: onPressed,
      icon: icon,
      label: label,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onLongPress: onLongPress,
      style: style,
    );
  }
}
