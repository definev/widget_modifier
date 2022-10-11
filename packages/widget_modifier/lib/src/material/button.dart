import 'package:flutter/material.dart';

import '../modifier.dart';

/// Creates a button based on [Semantics], [Material], and [InkWell]
/// widgets.
///
/// This class does not use the current [Theme] or [ButtonTheme] to
/// compute default values for unspecified parameters. It's intended to
/// be used for custom Material buttons that optionally incorporate defaults
/// from the themes or from app-specific sources.
///
/// This class is planned to be deprecated in a future release, see
/// [ButtonStyleButton], the base class of [TextButton], [ElevatedButton], and
/// [OutlinedButton].
///
/// See also:
///
///  * [TextButton], a simple flat button without a shadow.
///  * [ElevatedButton], a filled button whose material elevates when pressed.
///  * [OutlinedButton], a [TextButton] with a border outline.
class RawMaterialButtonModifier extends SingleChildStatelessModifier {
  /// Create a button based on [Semantics], [Material], and [InkWell] widgets.
  ///
  /// The [shape], [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], [disabledElevation], [padding], [constraints],
  /// [autofocus], and [clipBehavior] arguments must not be null. Additionally,
  /// [elevation], [focusElevation], [hoverElevation], [highlightElevation], and
  /// [disabledElevation] must be non-negative.
  const RawMaterialButtonModifier({
    super.key,
    super.child,
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
  })  : materialTapTargetSize = materialTapTargetSize ?? MaterialTapTargetSize.padded;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onPressed;
 
  /// Called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onLongPress;
  
  /// Called by the underlying [InkWell] widget's [InkWell.onHighlightChanged]
  /// callback.
  ///
  /// If [onPressed] changes from null to non-null while a gesture is ongoing,
  /// this can fire during the build phase (in which case calling
  /// [State.setState] is not allowed).
  final ValueChanged<bool>? onHighlightChanged;
  
  /// {@template flutter.material.RawMaterialButton.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// button.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.pressed].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;
  
  /// Defines the default text style, with [Material.textStyle], for the
  /// button's [child].
  ///
  /// If [TextStyle.color] is a [MaterialStateProperty<Color>], [MaterialStateProperty.resolve]
  /// is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.pressed].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  final TextStyle? textStyle;
  
  /// The color of the button's [Material].
  final Color? fillColor;
 
  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;
 
  /// The color for the button's [Material] when a pointer is hovering over it.
  final Color? hoverColor;
  
  /// The highlight color for the button's [InkWell].
  final Color? highlightColor;
  
  /// The splash color for the button's [InkWell].
  final Color? splashColor;
  
  /// The elevation for the button's [Material] when the button
  /// is [enabled] but not pressed.
  ///
  /// Defaults to 2.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [highlightElevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double elevation;
 
  /// The elevation for the button's [Material] when the button
  /// is [enabled] and a pointer is hovering over it.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// If the button is [enabled], and being pressed (in the highlighted state),
  /// then the [highlightElevation] take precedence over the [hoverElevation].
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double hoverElevation;
 
  /// The elevation for the button's [Material] when the button
  /// is [enabled] and has the input focus.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// If the button is [enabled], and being pressed (in the highlighted state),
  /// or a mouse cursor is hovering over the button, then the [hoverElevation]
  /// and [highlightElevation] take precedence over the [focusElevation].
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double focusElevation;
 
  /// The elevation for the button's [Material] when the button
  /// is [enabled] and pressed.
  ///
  /// Defaults to 8.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double highlightElevation;
 
  /// The elevation for the button's [Material] when the button
  /// is not [enabled].
  ///
  /// Defaults to 0.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double disabledElevation;
  
  /// The internal padding for the button's [child].
  final EdgeInsetsGeometry padding;
  
  /// Defines how compact the button's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all widgets
  ///    within a [Theme].
  final VisualDensity visualDensity;
  
  /// Defines the button's size.
  ///
  /// Typically used to constrain the button's minimum size.
  final BoxConstraints constraints;
  
  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape. If the
  /// button has an elevation, then its drop shadow is defined by this shape.
  ///
  /// If [shape] is a [MaterialStateProperty<ShapeBorder>], [MaterialStateProperty.resolve]
  /// is used for the following [MaterialState]s:
  ///
  /// * [MaterialState.pressed].
  /// * [MaterialState.hovered].
  /// * [MaterialState.focused].
  /// * [MaterialState.disabled].
  final ShapeBorder shape;
 
  /// Defines the duration of animated changes for [shape] and [elevation].
  ///
  /// The default value is [kThemeChangeDuration].
  final Duration animationDuration;
 
  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [MaterialTapTargetSize.padded].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize materialTapTargetSize;
  
  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;
  
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;
 
  /// {@macro flutter.material.Material.clipBehavior}
  final Clip clipBehavior;
  
  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
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
