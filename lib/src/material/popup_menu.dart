import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class PopupMenuItemModifier<T> extends SingleChildStatelessWidget {
  const PopupMenuItemModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.value,
    this.onTap,
    this.enabled = true,
    this.height = kMinInteractiveDimension,
    this.padding,
    this.textStyle,
    this.mouseCursor,
  });

  final Key? modifierKey;
  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  final double height;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final MouseCursor? mouseCursor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuItem<T>(
      key: modifierKey,
      enabled: enabled,
      height: height,
      mouseCursor: mouseCursor,
      onTap: onTap,
      padding: padding,
      textStyle: textStyle,
      value: value,
      child: child,
    );
  }
}

class CheckedPopupMenuItemModifier<T> extends PopupMenuItemModifier<T> {
  const CheckedPopupMenuItemModifier({
    super.key,
    super.modifierKey,
    super.value,
    this.checked = false,
    super.enabled,
    super.padding,
    super.height,
    super.mouseCursor,
    super.child,
  });

  final bool checked;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckedPopupMenuItem<T>(
      key: modifierKey,
      checked: checked,
      enabled: enabled,
      height: height,
      mouseCursor: mouseCursor,
      padding: padding,
      value: value,
      child: child,
    );
  }
}

class PopupMenuButtonModifier<T> extends SingleChildStatelessWidget {
  const PopupMenuButtonModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback,
    this.constraints,
    this.position = PopupMenuPosition.over,
  });

  final Key? modifierKey;
  final PopupMenuItemBuilder<T> itemBuilder;
  final T? initialValue;
  final PopupMenuItemSelected<T>? onSelected;
  final PopupMenuCanceled? onCanceled;
  final String? tooltip;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final double? splashRadius;
  final Widget? icon;
  final Offset offset;
  final bool enabled;
  final ShapeBorder? shape;
  final Color? color;
  final bool? enableFeedback;
  final double? iconSize;
  final BoxConstraints? constraints;
  final PopupMenuPosition position;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuButton<T>(
      key: modifierKey,
      color: color,
      constraints: constraints,
      elevation: elevation,
      enableFeedback: enableFeedback,
      enabled: enabled,
      icon: icon,
      iconSize: iconSize,
      initialValue: initialValue,
      offset: offset,
      onCanceled: onCanceled,
      onSelected: onSelected,
      padding: padding,
      position: position,
      shape: shape,
      splashRadius: splashRadius,
      tooltip: tooltip,
      itemBuilder: itemBuilder,
      child: child,
    );
  }
}
