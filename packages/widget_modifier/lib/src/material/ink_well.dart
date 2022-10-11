import 'package:flutter/material.dart';

import '../modifier.dart';

/// An area of a [Material] that responds to touch. Has a configurable shape and
/// can be configured to clip splashes that extend outside its bounds or not.
///
/// For a variant of this widget that is specialized for rectangular areas that
/// always clip splashes, see [InkWell].
///
/// An [InkResponse] widget does two things when responding to a tap:
///
///  * It starts to animate a _highlight_. The shape of the highlight is
///    determined by [highlightShape]. If it is a [BoxShape.circle], the
///    default, then the highlight is a circle of fixed size centered in the
///    [InkResponse]. If it is [BoxShape.rectangle], then the highlight is a box
///    the size of the [InkResponse] itself, unless [getRectCallback] is
///    provided, in which case that callback defines the rectangle. The color of
///    the highlight is set by [highlightColor].
///
///  * Simultaneously, it starts to animate a _splash_. This is a growing circle
///    initially centered on the tap location. If this is a [containedInkWell],
///    the splash grows to the [radius] while remaining centered at the tap
///    location. Otherwise, the splash migrates to the center of the box as it
///    grows.
///
/// The following two diagrams show how [InkResponse] looks when tapped if the
/// [highlightShape] is [BoxShape.circle] (the default) and [containedInkWell]
/// is false (also the default).
///
/// The first diagram shows how it looks if the [InkResponse] is relatively
/// large:
///
/// ![The highlight is a disc centered in the box, smaller than the child widget.](https://flutter.github.io/assets-for-api-docs/assets/material/ink_response_large.png)
///
/// The second diagram shows how it looks if the [InkResponse] is small:
///
/// ![The highlight is a disc overflowing the box, centered on the child.](https://flutter.github.io/assets-for-api-docs/assets/material/ink_response_small.png)
///
/// The main thing to notice from these diagrams is that the splashes happily
/// exceed the bounds of the widget (because [containedInkWell] is false).
///
/// The following diagram shows the effect when the [InkResponse] has a
/// [highlightShape] of [BoxShape.rectangle] with [containedInkWell] set to
/// true. These are the values used by [InkWell].
///
/// ![The highlight is a rectangle the size of the box.](https://flutter.github.io/assets-for-api-docs/assets/material/ink_well.png)
///
/// The [InkResponse] widget must have a [Material] widget as an ancestor. The
/// [Material] widget is where the ink reactions are actually painted. This
/// matches the Material Design premise wherein the [Material] is what is
/// actually reacting to touches by spreading ink.
///
/// If a Widget uses this class directly, it should include the following line
/// at the top of its build function to call [debugCheckHasMaterial]:
///
/// ```dart
/// assert(debugCheckHasMaterial(context));
/// ```
///
/// ## Troubleshooting
///
/// ### The ink splashes aren't visible!
///
/// If there is an opaque graphic, e.g. painted using a [Container], [Image], or
/// [DecoratedBox], between the [Material] widget and the [InkResponse] widget,
/// then the splash won't be visible because it will be under the opaque graphic.
/// This is because ink splashes draw on the underlying [Material] itself, as
/// if the ink was spreading inside the material.
///
/// The [Ink] widget can be used as a replacement for [Image], [Container], or
/// [DecoratedBox] to ensure that the image or decoration also paints in the
/// [Material] itself, below the ink.
///
/// If this is not possible for some reason, e.g. because you are using an
/// opaque [CustomPaint] widget, alternatively consider using a second
/// [Material] above the opaque widget but below the [InkResponse] (as an
/// ancestor to the ink response). The [MaterialType.transparency] material
/// kind can be used for this purpose.
///
/// See also:
///
///  * [GestureDetector], for listening for gestures without ink splashes.
///  * [ElevatedButton] and [TextButton], two kinds of buttons in Material Design.
///  * [IconButton], which combines [InkResponse] with an [Icon].
class InkResponseModifier extends SingleChildStatelessModifier {
  /// Creates an area of a [Material] that responds to touch.
  ///
  /// Must have an ancestor [Material] widget in which to cause ink reactions.
  ///
  /// The [containedInkWell], [highlightShape], [enableFeedback],
  /// and [excludeFromSemantics] arguments must not be null.
  const InkResponseModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHighlightChanged,
    this.onHover,
    this.mouseCursor,
    this.containedInkWell = false,
    this.highlightShape = BoxShape.circle,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
    this.statesController,
  });

  /// Called when the user taps this part of the material.
  final GestureTapCallback? onTap;

  /// Called when the user taps down this part of the material.
  final GestureTapDownCallback? onTapDown;

  /// Called when the user releases a tap that was started on this part of the
  /// material. [onTap] is called immediately after.
  final GestureTapUpCallback? onTapUp;

  /// Called when the user cancels a tap that was started on this part of the
  /// material.
  final GestureTapCallback? onTapCancel;

  /// Called when the user double taps this part of the material.
  final GestureTapCallback? onDoubleTap;

  /// Called when the user long-presses on this part of the material.
  final GestureLongPressCallback? onLongPress;

  /// Called when this part of the material either becomes highlighted or stops
  /// being highlighted.
  ///
  /// The value passed to the callback is true if this part of the material has
  /// become highlighted and false if this part of the material has stopped
  /// being highlighted.
  ///
  /// If all of [onTap], [onDoubleTap], and [onLongPress] become null while a
  /// gesture is ongoing, then [onTapCancel] will be fired and
  /// [onHighlightChanged] will be fired with the value false _during the
  /// build_. This means, for instance, that in that scenario [State.setState]
  /// cannot be called.
  final ValueChanged<bool>? onHighlightChanged;

  /// Called when a pointer enters or exits the ink response area.
  ///
  /// The value passed to the callback is true if a pointer has entered this
  /// part of the material and false if a pointer has exited this part of the
  /// material.
  final ValueChanged<bool>? onHover;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// Whether this ink response should be clipped its bounds.
  ///
  /// This flag also controls whether the splash migrates to the center of the
  /// [InkResponse] or not. If [containedInkWell] is true, the splash remains
  /// centered around the tap location. If it is false, the splash migrates to
  /// the center of the [InkResponse] as it grows.
  ///
  /// See also:
  ///
  ///  * [highlightShape], the shape of the focus, hover, and pressed
  ///    highlights.
  ///  * [borderRadius], which controls the corners when the box is a rectangle.
  ///  * [getRectCallback], which controls the size and position of the box when
  ///    it is a rectangle.
  final bool containedInkWell;

  /// The shape (e.g., circle, rectangle) to use for the highlight drawn around
  /// this part of the material when pressed, hovered over, or focused.
  ///
  /// The same shape is used for the pressed highlight (see [highlightColor]),
  /// the focus highlight (see [focusColor]), and the hover highlight (see
  /// [hoverColor]).
  ///
  /// If the shape is [BoxShape.circle], then the highlight is centered on the
  /// [InkResponse]. If the shape is [BoxShape.rectangle], then the highlight
  /// fills the [InkResponse], or the rectangle provided by [getRectCallback] if
  /// the callback is specified.
  ///
  /// See also:
  ///
  ///  * [containedInkWell], which controls clipping behavior.
  ///  * [borderRadius], which controls the corners when the box is a rectangle.
  ///  * [highlightColor], the color of the highlight.
  ///  * [getRectCallback], which controls the size and position of the box when
  ///    it is a rectangle.
  final BoxShape highlightShape;

  /// The radius of the ink splash.
  ///
  /// Splashes grow up to this size. By default, this size is determined from
  /// the size of the rectangle provided by [getRectCallback], or the size of
  /// the [InkResponse] itself.
  ///
  /// See also:
  ///
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final double? radius;

  /// The clipping radius of the containing rect. This is effective only if
  /// [customBorder] is null.
  ///
  /// If this is null, it is interpreted as [BorderRadius.zero].
  final BorderRadius? borderRadius;

  /// The custom clip border which overrides [borderRadius].
  final ShapeBorder? customBorder;

  /// The color of the ink response when the parent widget is focused. If this
  /// property is null then the focus color of the theme,
  /// [ThemeData.focusColor], will be used.
  ///
  /// See also:
  ///
  ///  * [highlightShape], the shape of the focus, hover, and pressed
  ///    highlights.
  ///  * [hoverColor], the color of the hover highlight.
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final Color? focusColor;

  /// The color of the ink response when a pointer is hovering over it. If this
  /// property is null then the hover color of the theme,
  /// [ThemeData.hoverColor], will be used.
  ///
  /// See also:
  ///
  ///  * [highlightShape], the shape of the focus, hover, and pressed
  ///    highlights.
  ///  * [highlightColor], the color of the pressed highlight.
  ///  * [focusColor], the color of the focus highlight.
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final Color? hoverColor;

  /// The highlight color of the ink response when pressed. If this property is
  /// null then the highlight color of the theme, [ThemeData.highlightColor],
  /// will be used.
  ///
  /// See also:
  ///
  ///  * [hoverColor], the color of the hover highlight.
  ///  * [focusColor], the color of the focus highlight.
  ///  * [highlightShape], the shape of the focus, hover, and pressed
  ///    highlights.
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final Color? highlightColor;

  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// This default null property can be used as an alternative to
  /// [focusColor], [hoverColor], [highlightColor], and
  /// [splashColor]. If non-null, it is resolved against one of
  /// [MaterialState.focused], [MaterialState.hovered], and
  /// [MaterialState.pressed]. It's convenient to use when the parent
  /// widget can pass along its own MaterialStateProperty value for
  /// the overlay color.
  ///
  /// [MaterialState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec. The [overlayColor] doesn't map
  /// a state to [highlightColor] because a separate highlight is not
  /// used by the current design guidelines.  See
  /// https://material.io/design/interaction/states.html#pressed
  ///
  /// If the overlay color is null or resolves to null, then [focusColor],
  /// [hoverColor], [splashColor] and their defaults are used instead.
  ///
  /// See also:
  ///
  ///  * The Material Design specification for overlay colors and how they
  ///    match a component's state:
  ///    <https://material.io/design/interaction/states.html#anatomy>.
  final MaterialStateProperty<Color?>? overlayColor;

  /// The splash color of the ink response. If this property is null then the
  /// splash color of the theme, [ThemeData.splashColor], will be used.
  ///
  /// See also:
  ///
  ///  * [splashFactory], which defines the appearance of the splash.
  ///  * [radius], the (maximum) size of the ink splash.
  ///  * [highlightColor], the color of the highlight.
  final Color? splashColor;

  /// Defines the appearance of the splash.
  ///
  /// Defaults to the value of the theme's splash factory: [ThemeData.splashFactory].
  ///
  /// See also:
  ///
  ///  * [radius], the (maximum) size of the ink splash.
  ///  * [splashColor], the color of the splash.
  ///  * [highlightColor], the color of the highlight.
  ///  * [InkSplash.splashFactory], which defines the default splash.
  ///  * [InkRipple.splashFactory], which defines a splash that spreads out
  ///    more aggressively than the default.
  final InteractiveInkFeatureFactory? splashFactory;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool enableFeedback;

  /// Whether to exclude the gestures introduced by this widget from the
  /// semantics tree.
  ///
  /// For example, a long-press gesture for showing a tooltip is usually
  /// excluded because the tooltip itself is included in the semantics
  /// tree directly and so having a gesture to show it would result in
  /// duplication of information.
  final bool excludeFromSemantics;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool canRequestFocus;

  /// {@template flutter.material.inkwell.statesController}
  /// Represents the interactive "state" of this widget in terms of
  /// a set of [MaterialState]s, like [MaterialState.pressed] and
  /// [MaterialState.focused].
  ///
  /// Classes based on this one can provide their own
  /// [MaterialStatesController] to which they've added listeners.
  /// They can also update the controller's [MaterialStatesController.value]
  /// however, this may only be done when it's safe to call
  /// [State.setState], like in an event handler.
  /// {@endtemplate}
  final MaterialStatesController? statesController;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InkResponse(
      key: modifierKey,
      autofocus: autofocus,
      borderRadius: borderRadius,
      canRequestFocus: canRequestFocus,
      containedInkWell: containedInkWell,
      customBorder: customBorder,
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
      focusColor: focusColor,
      focusNode: focusNode,
      highlightColor: highlightColor,
      highlightShape: highlightShape,
      hoverColor: hoverColor,
      mouseCursor: mouseCursor,
      onDoubleTap: onDoubleTap,
      onFocusChange: onFocusChange,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      onLongPress: onLongPress,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      overlayColor: overlayColor,
      radius: radius,
      splashColor: splashColor,
      splashFactory: splashFactory,
      statesController: statesController,
      child: child,
    );
  }
}


/// A rectangular area of a [Material] that responds to touch.
///
/// For a variant of this widget that does not clip splashes, see [InkResponse].
///
/// The following diagram shows how an [InkWell] looks when tapped, when using
/// default values.
///
/// ![The highlight is a rectangle the size of the box.](https://flutter.github.io/assets-for-api-docs/assets/material/ink_well.png)
///
/// The [InkWell] widget must have a [Material] widget as an ancestor. The
/// [Material] widget is where the ink reactions are actually painted. This
/// matches the Material Design premise wherein the [Material] is what is
/// actually reacting to touches by spreading ink.
///
/// If a Widget uses this class directly, it should include the following line
/// at the top of its build function to call [debugCheckHasMaterial]:
///
/// ```dart
/// assert(debugCheckHasMaterial(context));
/// ```
///
/// ## Troubleshooting
///
/// ### The ink splashes aren't visible!
///
/// If there is an opaque graphic, e.g. painted using a [Container], [Image], or
/// [DecoratedBox], between the [Material] widget and the [InkWell] widget, then
/// the splash won't be visible because it will be under the opaque graphic.
/// This is because ink splashes draw on the underlying [Material] itself, as
/// if the ink was spreading inside the material.
///
/// The [Ink] widget can be used as a replacement for [Image], [Container], or
/// [DecoratedBox] to ensure that the image or decoration also paints in the
/// [Material] itself, below the ink.
///
/// If this is not possible for some reason, e.g. because you are using an
/// opaque [CustomPaint] widget, alternatively consider using a second
/// [Material] above the opaque widget but below the [InkWell] (as an
/// ancestor to the ink well). The [MaterialType.transparency] material
/// kind can be used for this purpose.
///
/// ### InkWell isn't clipping properly
///
/// If you want to clip an InkWell or any [Ink] widgets you need to keep in mind
/// that the [Material] that the Ink will be printed on is responsible for clipping.
/// This means you can't wrap the [Ink] widget in a clipping widget directly,
/// since this will leave the [Material] not clipped (and by extension the printed
/// [Ink] widgets as well).
///
/// An easy solution is to deliberately wrap the [Ink] widgets you want to clip
/// in a [Material], and wrap that in a clipping widget instead. See [Ink] for
/// an example.
///
/// ### The ink splashes don't track the size of an animated container
/// If the size of an InkWell's [Material] ancestor changes while the InkWell's
/// splashes are expanding, you may notice that the splashes aren't clipped
/// correctly. This can't be avoided.
///
/// An example of this situation is as follows:
///
/// {@tool dartpad}
/// Tap the container to cause it to grow. Then, tap it again and hold before
/// the widget reaches its maximum size to observe the clipped ink splash.
///
/// ** See code in examples/api/lib/material/ink_well/ink_well.0.dart **
/// {@end-tool}
///
/// An InkWell's splashes will not properly update to conform to changes if the
/// size of its underlying [Material], where the splashes are rendered, changes
/// during animation. You should avoid using InkWells within [Material] widgets
/// that are changing size.
///
/// See also:
///
///  * [GestureDetector], for listening for gestures without ink splashes.
///  * [ElevatedButton] and [TextButton], two kinds of buttons in Material Design.
///  * [InkResponse], a variant of [InkWell] that doesn't force a rectangular
///    shape on the ink reaction.
class InkWellModifier extends InkResponseModifier {
  /// Creates an ink well.
  ///
  /// Must have an ancestor [Material] widget in which to cause ink reactions.
  ///
  /// The [enableFeedback], and [excludeFromSemantics] arguments
  /// must not be null.
  const InkWellModifier({
    super.key,
    super.modifierKey,
    super.child,
    super.onTap,
    super.onDoubleTap,
    super.onLongPress,
    super.onTapDown,
    super.onTapUp,
    super.onTapCancel,
    super.onHighlightChanged,
    super.onHover,
    super.mouseCursor,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.overlayColor,
    super.splashColor,
    super.splashFactory,
    super.radius,
    super.borderRadius,
    super.customBorder,
    bool? enableFeedback = true,
    super.excludeFromSemantics,
    super.focusNode,
    super.canRequestFocus,
    super.onFocusChange,
    super.autofocus,
    super.statesController,
  }) : super(
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          enableFeedback: enableFeedback ?? true,
        );
}
