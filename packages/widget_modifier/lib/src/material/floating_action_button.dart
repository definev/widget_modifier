import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonModifier extends SingleChildStatelessModifier {
  const FloatingActionButtonModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
    this.enableFeedback,
  })  : extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key, child: child);

  static SingleChildModifier small({
    Key? key,
    Widget? child,
    Key? modifierKey,
    String? tooltip,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
    Object? heroTag,
    required VoidCallback? onPressed,
    MouseCursor? mouseCursor,
    double? elevation,
    double? focusElevation,
    double? hoverElevation,
    double? highlightElevation,
    double? disabledElevation,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    bool? enableFeedback,
    double? extendedIconLabelSpacing,
    EdgeInsetsGeometry? extendedPadding,
    TextStyle? extendedTextStyle,
  }) =>
      _FloatingActionButtonModifierSmall(
        key: key,
        modifierKey: modifierKey,
        onPressed: onPressed,
        autofocus: autofocus,
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior,
        disabledElevation: disabledElevation,
        elevation: elevation,
        enableFeedback: enableFeedback,
        focusColor: focusColor,
        focusElevation: focusElevation,
        focusNode: focusNode,
        foregroundColor: foregroundColor,
        heroTag: heroTag,
        highlightElevation: highlightElevation,
        hoverColor: hoverColor,
        hoverElevation: hoverElevation,
        materialTapTargetSize: materialTapTargetSize,
        mouseCursor: mouseCursor,
        shape: shape,
        splashColor: splashColor,
        tooltip: tooltip,
        child: child,
      );

  static SingleChildModifier large({
    Key? key,
    Widget? child,
    Key? modifierKey,
    String? tooltip,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
    Object? heroTag,
    double? elevation,
    double? focusElevation,
    double? hoverElevation,
    double? highlightElevation,
    double? disabledElevation,
    required VoidCallback onPressed,
    MouseCursor? mouseCursor,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    bool? enableFeedback,
  }) =>
      _FloatingActionButtonModifierLarge(
        key: key,
        modifierKey: modifierKey,
        materialTapTargetSize: materialTapTargetSize,
        mouseCursor: mouseCursor,
        shape: shape,
        splashColor: splashColor,
        tooltip: tooltip,
        onPressed: onPressed,
        autofocus: autofocus,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        clipBehavior: clipBehavior,
        disabledElevation: disabledElevation,
        elevation: elevation,
        enableFeedback: enableFeedback,
        focusElevation: focusElevation,
        focusNode: focusNode,
        heroTag: heroTag,
        highlightElevation: highlightElevation,
        hoverElevation: hoverElevation,
        child: child,
      );

  static SingleChildModifier extended({
    Key? key,
    Widget? icon,
    Key? modifierKey,
    required Widget label,
    String? tooltip,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? focusColor,
    Color? hoverColor,
    Object? heroTag,
    double? elevation,
    double? focusElevation,
    double? hoverElevation,
    Color? splashColor,
    double? highlightElevation,
    double? disabledElevation,
    required VoidCallback onPressed,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    ShapeBorder? shape,
    bool isExtended = true,
    MaterialTapTargetSize? materialTapTargetSize,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    double? extendedIconLabelSpacing,
    EdgeInsetsGeometry? extendedPadding,
    TextStyle? extendedTextStyle,
    bool? enableFeedback,
  }) =>
      _FloatingActionButtonModifierExtended(
        key: key,
        modifierKey: modifierKey,
        icon: icon,
        label: label,
        onPressed: onPressed,
        autofocus: autofocus,
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior,
        disabledElevation: disabledElevation,
        elevation: elevation,
        enableFeedback: enableFeedback,
        extendedIconLabelSpacing: extendedIconLabelSpacing,
        extendedPadding: extendedPadding,
        extendedTextStyle: extendedTextStyle,
        focusColor: focusColor,
        focusElevation: focusElevation,
        focusNode: focusNode,
        foregroundColor: foregroundColor,
        heroTag: heroTag,
        highlightElevation: highlightElevation,
        hoverColor: hoverColor,
        hoverElevation: hoverElevation,
        isExtended: isExtended,
        materialTapTargetSize: materialTapTargetSize,
        mouseCursor: mouseCursor,
        shape: shape,
        splashColor: splashColor,
        tooltip: tooltip,
      );

  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Object? heroTag;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final bool mini;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final bool isExtended;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? enableFeedback;
  final double? extendedIconLabelSpacing;
  final EdgeInsetsGeometry? extendedPadding;
  final TextStyle? extendedTextStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FloatingActionButton(
      key: modifierKey,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      disabledElevation: disabledElevation,
      elevation: elevation,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusElevation: focusElevation,
      focusNode: focusNode,
      foregroundColor: foregroundColor,
      heroTag: heroTag,
      highlightElevation: highlightElevation,
      hoverColor: hoverColor,
      hoverElevation: hoverElevation,
      isExtended: isExtended,
      materialTapTargetSize: materialTapTargetSize,
      mini: mini,
      mouseCursor: mouseCursor,
      shape: shape,
      splashColor: splashColor,
      tooltip: tooltip,
      onPressed: onPressed,
      autofocus: autofocus,
      child: child,
    );
  }
}

class _FloatingActionButtonModifierSmall extends SingleChildStatelessModifier {
  const _FloatingActionButtonModifierSmall({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.enableFeedback,
  })  : mini = false,
        isExtended = false,
        extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key, child: child);

  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Object? heroTag;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final bool mini;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final bool isExtended;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? enableFeedback;
  final double? extendedIconLabelSpacing;
  final EdgeInsetsGeometry? extendedPadding;
  final TextStyle? extendedTextStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FloatingActionButton.small(
      key: modifierKey,
      onPressed: onPressed,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      disabledElevation: disabledElevation,
      elevation: elevation,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusElevation: focusElevation,
      focusNode: focusNode,
      foregroundColor: foregroundColor,
      heroTag: heroTag,
      highlightElevation: highlightElevation,
      hoverColor: hoverColor,
      hoverElevation: hoverElevation,
      materialTapTargetSize: materialTapTargetSize,
      mouseCursor: mouseCursor,
      shape: shape,
      splashColor: splashColor,
      tooltip: tooltip,
      child: child,
    );
  }
}

class _FloatingActionButtonModifierLarge extends SingleChildStatelessModifier {
  const _FloatingActionButtonModifierLarge({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.enableFeedback,
  })  : mini = false,
        isExtended = false,
        extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key, child: child);

  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Object? heroTag;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final bool mini;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final bool isExtended;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? enableFeedback;
  final double? extendedIconLabelSpacing;
  final EdgeInsetsGeometry? extendedPadding;
  final TextStyle? extendedTextStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FloatingActionButton.large(
      key: modifierKey,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      disabledElevation: disabledElevation,
      elevation: elevation,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusElevation: focusElevation,
      focusNode: focusNode,
      foregroundColor: foregroundColor,
      heroTag: heroTag,
      highlightElevation: highlightElevation,
      hoverColor: hoverColor,
      hoverElevation: hoverElevation,
      materialTapTargetSize: materialTapTargetSize,
      mouseCursor: mouseCursor,
      shape: shape,
      splashColor: splashColor,
      tooltip: tooltip,
      onPressed: onPressed,
      child: child,
    );
  }
}

class _FloatingActionButtonModifierExtended extends SingleChildStatelessModifier {
  const _FloatingActionButtonModifierExtended({
    Key? key,
    super.modifierKey,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.splashColor,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor = SystemMouseCursors.click,
    this.shape,
    this.isExtended = true,
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.extendedIconLabelSpacing,
    this.extendedPadding,
    this.extendedTextStyle,
    Widget? icon,
    required this.label,
    this.enableFeedback,
  })  : mini = false,
        super(key: key, child: icon);

  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Object? heroTag;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final bool mini;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final bool isExtended;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? enableFeedback;
  final double? extendedIconLabelSpacing;
  final EdgeInsetsGeometry? extendedPadding;
  final TextStyle? extendedTextStyle;
  final Widget label;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FloatingActionButton.extended(
      key: modifierKey,
      onPressed: onPressed,
      label: label,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      disabledElevation: disabledElevation,
      elevation: elevation,
      enableFeedback: enableFeedback,
      extendedIconLabelSpacing: extendedIconLabelSpacing,
      extendedPadding: extendedPadding,
      extendedTextStyle: extendedTextStyle,
      focusColor: focusColor,
      focusElevation: focusElevation,
      focusNode: focusNode,
      foregroundColor: foregroundColor,
      heroTag: heroTag,
      highlightElevation: highlightElevation,
      hoverColor: hoverColor,
      hoverElevation: hoverElevation,
      icon: child,
      isExtended: isExtended,
      materialTapTargetSize: materialTapTargetSize,
      mouseCursor: mouseCursor,
      shape: shape,
      splashColor: splashColor,
      tooltip: tooltip,
    );
  }
}
