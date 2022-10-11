// ignore_for_file: avoid_field_initializers_in_const_classes
import 'package:flutter/material.dart';

import '../modifier.dart';

/// A Material Design floating action button.
///
/// A floating action button is a circular icon button that hovers over content
/// to promote a primary action in the application. Floating action buttons are
/// most commonly used in the [Scaffold.floatingActionButton] field.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=2uaoEDOgk_I}
///
/// Use at most a single floating action button per screen. Floating action
/// buttons should be used for positive actions such as "create", "share", or
/// "navigate". (If more than one floating action button is used within a
/// [Route], then make sure that each button has a unique [heroTag], otherwise
/// an exception will be thrown.)
///
/// If the [onPressed] callback is null, then the button will be disabled and
/// will not react to touch. It is highly discouraged to disable a floating
/// action button as there is no indication to the user that the button is
/// disabled. Consider changing the [backgroundColor] if disabling the floating
/// action button.
///
/// {@tool dartpad}
/// This example shows how to display a [FloatingActionButton] in a
/// [Scaffold], with a pink [backgroundColor] and a thumbs up [Icon].
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/floating_action_button.png)
///
/// ** See code in examples/api/lib/material/floating_action_button/floating_action_button.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to make an extended [FloatingActionButton] in a
/// [Scaffold], with a  pink [backgroundColor], a thumbs up [Icon] and a
/// [Text] label that reads "Approve".
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/floating_action_button_label.png)
///
/// ** See code in examples/api/lib/material/floating_action_button/floating_action_button.1.dart **
/// {@end-tool}
///
/// Material Design 3 introduced new types of floating action buttons.
/// {@tool dartpad}
/// This sample shows the creation of [FloatingActionButton] widget in the typical location in a Scaffold,
/// as described in: https://m3.material.io/components/floating-action-button/overview
///
/// ** See code in examples/api/lib/material/floating_action_button/floating_action_button.2.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows the creation of all the variants of [FloatingActionButton] widget as
/// described in: https://m3.material.io/components/floating-action-button/overview
///
/// ** See code in examples/api/lib/material/floating_action_button/floating_action_button.3.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Scaffold], in which floating action buttons typically live.
///  * [ElevatedButton], a filled button whose material elevates when pressed.
///  * <https://material.io/design/components/buttons-floating-action-button.html>
///  * <https://m3.material.io/components/floating-action-button>
class FloatingActionButtonModifier extends SingleChildStatelessModifier {
  /// Creates a circular floating action button.
  ///
  /// The [mini] and [clipBehavior] arguments must not be null. Additionally,
  /// [elevation], [highlightElevation], and [disabledElevation] (if specified)
  /// must be non-negative.
  const FloatingActionButtonModifier({
    super.key,
    super.child,
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
        extendedTextStyle = null;

  
  /// Creates a small circular floating action button.
  ///
  /// This constructor overrides the default size constraints of the floating
  /// action button.
  ///
  /// The [clipBehavior] and [autofocus] arguments must not be null.
  /// Additionally, [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], and [disabledElevation] (if specified) must be
  /// non-negative.
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

  /// Creates a large circular floating action button.
  ///
  /// This constructor overrides the default size constraints of the floating
  /// action button.
  ///
  /// The [clipBehavior] and [autofocus] arguments must not be null.
  /// Additionally, [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], and [disabledElevation] (if specified) must be
  /// non-negative.
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
  
  /// Creates a wider [StadiumBorder]-shaped floating action button with
  /// an optional [icon] and a [label].
  ///
  /// The [label], [autofocus], and [clipBehavior] arguments must not be null.
  /// Additionally, [elevation], [highlightElevation], and [disabledElevation]
  /// (if specified) must be non-negative.
  ///
  /// See also:
  ///  * <https://m3.material.io/components/extended-fab>
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

/// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The default foreground color for icons and text within the button.
  ///
  /// If this property is null, then the
  /// [FloatingActionButtonThemeData.foregroundColor] of
  /// [ThemeData.floatingActionButtonTheme] is used. If that property is also
  /// null, then the [ColorScheme.onSecondary] color of [ThemeData.colorScheme]
  /// is used.
  final Color? foregroundColor;

  /// The button's background color.
  ///
  /// If this property is null, then the
  /// [FloatingActionButtonThemeData.backgroundColor] of
  /// [ThemeData.floatingActionButtonTheme] is used. If that property is also
  /// null, then the [Theme]'s [ColorScheme.secondary] color is used.
  final Color? backgroundColor;

  /// The color to use for filling the button when the button has input focus.
  ///
  /// Defaults to [ThemeData.focusColor] for the current theme.
  final Color? focusColor;

  /// The color to use for filling the button when the button has a pointer
  /// hovering over it.
  ///
  /// Defaults to [ThemeData.hoverColor] for the current theme.
  final Color? hoverColor;

  /// The splash color for this [FloatingActionButton]'s [InkWell].
  ///
  /// If null, [FloatingActionButtonThemeData.splashColor] is used, if that is
  /// null, [ThemeData.splashColor] is used.
  final Color? splashColor;

  /// The tag to apply to the button's [Hero] widget.
  ///
  /// Defaults to a tag that matches other floating action buttons.
  ///
  /// Set this to null explicitly if you don't want the floating action button to
  /// have a hero tag.
  ///
  /// If this is not explicitly set, then there can only be one
  /// [FloatingActionButton] per route (that is, per screen), since otherwise
  /// there would be a tag conflict (multiple heroes on one route can't have the
  /// same tag). The Material Design specification recommends only using one
  /// floating action button per screen.
  final Object? heroTag;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The z-coordinate at which to place this button relative to its parent.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 6, the appropriate elevation for floating action buttons. The
  /// value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? elevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the button has the input focus.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 8, the appropriate elevation for floating action buttons
  /// while they have focus. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? focusElevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the button is enabled and has a pointer hovering over it.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 8, the appropriate elevation for floating action buttons while
  /// they have a pointer hovering over them. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? hoverElevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the user is touching the button.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 12, the appropriate elevation for floating action buttons
  /// while they are being touched. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  final double? highlightElevation;

  /// The z-coordinate at which to place this button when the button is disabled
  /// ([onPressed] is null).
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to the same value as [elevation]. Setting this to zero makes the
  /// floating action button work similar to an [ElevatedButton] but the titular
  /// "floating" effect is lost. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? disabledElevation;

  /// Controls the size of this button.
  ///
  /// By default, floating action buttons are non-mini and have a height and
  /// width of 56.0 logical pixels. Mini floating action buttons have a height
  /// and width of 40.0 logical pixels with a layout width and height of 48.0
  /// logical pixels. (The extra 4 pixels of padding on each side are added as a
  /// result of the floating action button having [MaterialTapTargetSize.padded]
  /// set on the underlying [RawMaterialButton.materialTapTargetSize].)
  final bool mini;

  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape. If the
  /// button has an elevation, then its drop shadow is defined by this
  /// shape as well.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// True if this is an "extended" floating action button.
  ///
  /// Typically [extended] buttons have a [StadiumBorder] [shape]
  /// and have been created with the [FloatingActionButton.extended]
  /// constructor.
  ///
  /// The [Scaffold] animates the appearance of ordinary floating
  /// action buttons with scale and rotation transitions. Extended
  /// floating action buttons are scaled and faded in.
  final bool isExtended;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// If null, [FloatingActionButtonThemeData.enableFeedback] is used.
  /// If both are null, then default value is true.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;


  /// The spacing between the icon and the label for an extended
  /// [FloatingActionButton].
  ///
  /// If null, [FloatingActionButtonThemeData.extendedIconLabelSpacing] is used.
  /// If that is also null, the default is 8.0.
  final double? extendedIconLabelSpacing;

  /// The padding for an extended [FloatingActionButton]'s content.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedPadding] is used. If that
  /// is also null, the default is
  /// `EdgeInsetsDirectional.only(start: 16.0, end: 20.0)` if an icon is
  /// provided, and `EdgeInsetsDirectional.only(start: 20.0, end: 20.0)` if not.
  final EdgeInsetsGeometry? extendedPadding;

  /// The text style for an extended [FloatingActionButton]'s label.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedTextStyle] is used. If
  /// that is also null, then [TextTheme.button] with a letter spacing of 1.2
  /// is used.
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
    super.key,
    super.child,
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
        extendedTextStyle = null;

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
    super.key,
    super.child,
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
        extendedTextStyle = null;

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
    super.key,
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
        super(child: icon);

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
