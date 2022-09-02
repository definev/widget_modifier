import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ElevatedButtonModifier extends SingleChildStatelessWidget {
  const ElevatedButtonModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(key: key, child: child);

  factory ElevatedButtonModifier.icon({
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
  }) = _ElevatedButtonModifierWithIcon;

  final Key? modifierKey;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ElevatedButton(
      key: modifierKey,
      onPressed: onPressed,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      style: style,
      child: child,
    );
  }
}

class _ElevatedButtonModifierWithIcon extends ElevatedButtonModifier {
  _ElevatedButtonModifierWithIcon({
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
  }) : super(
          focusNode: focusNode,
          key: key,
          modifierKey: modifierKey,
          onFocusChange: onFocusChange,
          onHover: onHover,
          onLongPress: onLongPress,
          style: style,
          onPressed: onPressed,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _ElevatedButtonWithIconChild(icon: icon, label: label),
        );
}

class _ElevatedButtonWithIconChild extends StatelessWidget {
  const _ElevatedButtonWithIconChild({required this.label, required this.icon});

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}
