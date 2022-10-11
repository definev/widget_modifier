import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// An abstract class for building widgets that animate changes to their
/// properties.
///
/// Widgets of this type will not animate when they are first added to the
/// widget tree. Rather, when they are rebuilt with different values, they will
/// respond to those _changes_ by animating the changes over a specified
/// [duration].
///
/// Which properties are animated is left up to the subclass. Subclasses' [State]s
/// must extend [ImplicitlyAnimatedWidgetState] and provide a way to visit the
/// relevant fields to animate.
///
/// ## Relationship to [AnimatedWidget]s
///
/// [ImplicitlyAnimatedWidget]s (and their subclasses) automatically animate
/// changes in their properties whenever they change. For this,
/// they create and manage their own internal [AnimationController]s to power
/// the animation. While these widgets are simple to use and don't require you
/// to manually manage the lifecycle of an [AnimationController], they
/// are also somewhat limited: Besides the target value for the animated
/// property, developers can only choose a [duration] and [curve] for the
/// animation. If you require more control over the animation (e.g. you want
/// to stop it somewhere in the middle), consider using an
/// [AnimatedWidget] or one of its subclasses. These widgets take an [Animation]
/// as an argument to power the animation. This gives the developer full control
/// over the animation at the cost of requiring you to manually manage the
/// underlying [AnimationController].
///
/// ## Common implicitly animated widgets
///
/// A number of implicitly animated widgets ship with the framework. They are
/// usually named `AnimatedFoo`, where `Foo` is the name of the non-animated
/// version of that widget. Commonly used implicitly animated widgets include:
///
///  * [TweenAnimationBuilder], which animates any property expressed by
///    a [Tween] to a specified target value.
///  * [AnimatedAlign], which is an implicitly animated version of [Align].
///  * [AnimatedContainer], which is an implicitly animated version of
///    [Container].
///  * [AnimatedDefaultTextStyle], which is an implicitly animated version of
///    [DefaultTextStyle].
///  * [AnimatedScale], which is an implicitly animated version of [Transform.scale].
///  * [AnimatedRotation], which is an implicitly animated version of [Transform.rotate].
///  * [AnimatedSlide], which implicitly animates the position of a widget relative to its normal position.
///  * [AnimatedOpacity], which is an implicitly animated version of [Opacity].
///  * [AnimatedPadding], which is an implicitly animated version of [Padding].
///  * [AnimatedPhysicalModel], which is an implicitly animated version of
///    [PhysicalModel].
///  * [AnimatedPositioned], which is an implicitly animated version of
///    [Positioned].
///  * [AnimatedPositionedDirectional], which is an implicitly animated version
///    of [PositionedDirectional].
///  * [AnimatedTheme], which is an implicitly animated version of [Theme].
///  * [AnimatedCrossFade], which cross-fades between two given children and
///    animates itself between their sizes.
///  * [AnimatedSize], which automatically transitions its size over a given
///    duration.
///  * [AnimatedSwitcher], which fades from one widget to another.
abstract class SingleChildImplicitlyAnimatedModifier extends SingleChildStatelessModifier {
  /// Initializes fields for subclasses.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const SingleChildImplicitlyAnimatedModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  });

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final VoidCallback? onEnd;
}

/// Animated version of [Container] that gradually changes its values over a period of time.
///
/// The [AnimatedContainer] will automatically animate between the old and
/// new values of properties when they change using the provided curve and
/// duration. Properties that are null are not animated. Its child and
/// descendants are not animated.
///
/// This class is useful for generating simple implicit transitions between
/// different parameters to [Container] with its internal [AnimationController].
/// For more complex animations, you'll likely want to use a subclass of
/// [AnimatedWidget] such as the [DecoratedBoxTransition] or use your own
/// [AnimationController].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=yI-8QHpGIP4}
///
/// {@tool dartpad}
/// The following example (depicted above) transitions an AnimatedContainer
/// between two states. It adjusts the `height`, `width`, `color`, and
/// [alignment] properties when tapped.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_container.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPadding], which is a subset of this widget that only
///    supports animating the [padding].
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
///  * [AnimatedAlign], which automatically transitions its child's
///    position over a given duration whenever the given [AnimatedAlign.alignment] changes.
///  * [AnimatedSwitcher], which switches out a child for a new one with a customizable transition.
///  * [AnimatedCrossFade], which fades between two children and interpolates their sizes.
class AnimatedContainerModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a container that animates its parameters implicitly.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedContainerModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  });

  /// The container width
  /// you can't declare width and [constraints] at the same time
  final double? width;

  /// The container width
  /// you can't declare height and [constraints] at the same time
  final double? height;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  final Color? color;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  final EdgeInsetsGeometry? padding;

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final Decoration? decoration;

  /// The decoration to paint in front of the child.
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  final AlignmentGeometry? transformAlignment;

  /// The clip behavior when [AnimatedContainer.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// Unlike other properties of [AnimatedContainer], changes to this property
  /// apply immediately and have no animation.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedContainer(
      key: modifierKey,
      duration: duration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      color: color,
      decoration: decoration,
      constraints: constraints,
      curve: curve,
      foregroundDecoration: foregroundDecoration,
      height: height,
      width: width,
      margin: margin,
      onEnd: onEnd,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
    );
  }
}

/// Animated version of [Padding] which automatically transitions the
/// indentation over a given duration whenever the given inset changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PY2m0fhGNz4}
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_padding.mp4}
///
/// {@tool dartpad}
/// The following code implements the [AnimatedPadding] widget, using a [curve] of
/// [Curves.easeInOut].
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_padding.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedContainer], which can transition more values at once.
///  * [AnimatedAlign], which automatically transitions its child's
///    position over a given duration whenever the given
///    [AnimatedAlign.alignment] changes.
class AnimatedPaddingModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that insets its child by a value that animates
  /// implicitly.
  ///
  /// The [padding], [curve], and [duration] arguments must not be null.
  const AnimatedPaddingModifier({
    super.key,
    super.child,
    required super.duration,
    super.curve,
    super.onEnd,
    super.modifierKey,
    required this.padding,
  });

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedPadding(
      key: modifierKey,
      padding: padding,
      duration: duration,
      child: child,
    );
  }
}

/// Animated version of [Align] which automatically transitions the child's
/// position over a given duration whenever the given [alignment] changes.
///
/// Here's an illustration of what this can look like, using a [curve] of
/// [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_align.mp4}
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new target [alignment]. If you require
/// more control over the animation (e.g. if you want to stop it mid-animation),
/// consider using an [AlignTransition] instead, which takes a provided
/// [Animation] as argument. While that allows you to fine-tune the animation,
/// it also requires more development overhead as you have to manually manage
/// the lifecycle of the underlying [AnimationController].
///
/// {@tool dartpad}
/// The following code implements the [AnimatedAlign] widget, using a [curve] of
/// [Curves.fastOutSlowIn].
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_align.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedContainer], which can transition more values at once.
///  * [AnimatedPadding], which can animate the padding instead of the
///    alignment.
///  * [AnimatedSlide], which can animate the translation of child by a given offset relative to its size.
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
class AnimatedAlignModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that positions its child by an alignment that animates
  /// implicitly.
  ///
  /// The [alignment], [curve], and [duration] arguments must not be null.
  const AnimatedAlignModifier({
    super.key,
    super.modifierKey,
    super.curve,
    super.child,
    required super.duration,
    super.onEnd,
    required this.alignment,
    this.heightFactor,
    this.widthFactor,
  });

  /// How to align the child.
  ///
  /// The x and y values of the [Alignment] control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// See also:
  ///
  ///  * [Alignment], which has more details and some convenience constants for
  ///    common positions.
  ///  * [AlignmentDirectional], which has a horizontal coordinate orientation
  ///    that depends on the [TextDirection].
  final AlignmentGeometry alignment;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Must be greater than or equal to 0.0, defaults to null.
  final double? heightFactor;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  ///
  /// Must be greater than or equal to 0.0, defaults to null.
  final double? widthFactor;
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedAlign(
      key: modifierKey,
      alignment: alignment,
      duration: duration,
      curve: curve,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      onEnd: onEnd,
      child: child,
    );
  }
}

/// Animated version of [Positioned] which automatically transitions the child's
/// position over a given duration whenever the given position changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=hC3s2YdtWt8}
///
/// Only works if it's the child of a [Stack].
///
/// This widget is a good choice if the _size_ of the child would end up
/// changing as a result of this animation. If the size is intended to remain
/// the same, with only the _position_ changing over time, then consider
/// [SlideTransition] instead. [SlideTransition] only triggers a repaint each
/// frame of the animation, whereas [AnimatedPositioned] will trigger a relayout
/// as well.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_positioned.mp4}
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new target position. If you require
/// more control over the animation (e.g. if you want to stop it mid-animation),
/// consider using a [PositionedTransition] instead, which takes a provided
/// [Animation] as an argument. While that allows you to fine-tune the animation,
/// it also requires more development overhead as you have to manually manage
/// the lifecycle of the underlying [AnimationController].
///
/// {@tool dartpad}
/// The following example transitions an AnimatedPositioned
/// between two states. It adjusts the `height`, `width`, and
/// [Positioned] properties when tapped.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_positioned.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPositionedDirectional], which adapts to the ambient
///    [Directionality] (the same as this widget, but for animating
///    [PositionedDirectional]).
class AnimatedPositionedModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its position implicitly.
  ///
  /// Only two out of the three horizontal values ([left], [right],
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedPositionedModifier({
    super.key,
    super.modifierKey,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  });

  /// Creates a widget that animates the rectangle it occupies implicitly.
  ///
  /// The [curve] and [duration] arguments must not be null.
  AnimatedPositionedModifier.fromRect({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required Rect rect,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null;

  /// The offset of the child's left edge from the left of the stack.
  final double? left;

  /// The offset of the child's top edge from the top of the stack.
  final double? top;

  /// The offset of the child's right edge from the right of the stack.
  final double? right;

  /// The offset of the child's bottom edge from the bottom of the stack.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can
  /// be set. The third must be null.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can
  /// be set. The third must be null.
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedPositioned(
      key: modifierKey,
      duration: duration,
      curve: curve,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      onEnd: onEnd,
      height: height,
      width: width,
      child: child!,
    );
  }
}

/// Animated version of [PositionedDirectional] which automatically transitions
/// the child's position over a given duration whenever the given position
/// changes.
///
/// The ambient [Directionality] is used to determine whether [start] is to the
/// left or to the right.
///
/// Only works if it's the child of a [Stack].
///
/// This widget is a good choice if the _size_ of the child would end up
/// changing as a result of this animation. If the size is intended to remain
/// the same, with only the _position_ changing over time, then consider
/// [SlideTransition] instead. [SlideTransition] only triggers a repaint each
/// frame of the animation, whereas [AnimatedPositionedDirectional] will trigger
/// a relayout as well. ([SlideTransition] is also text-direction-aware.)
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_positioned_directional.mp4}
///
/// See also:
///
///  * [AnimatedPositioned], which specifies the widget's position visually (the
///    same as this widget, but for animating [Positioned]).
class AnimatedPositionedDirectionalModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its position implicitly.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]), and
  /// only two out of the three vertical values ([top], [bottom], [height]), can
  /// be set. In each case, at least one of the three must be null.
  ///
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedPositionedDirectionalModifier({
    super.key,
    super.modifierKey,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
  });

  /// The offset of the child's start edge from the start of the stack.
  final double? start;

  /// The offset of the child's top edge from the top of the stack.
  final double? top;

  /// The offset of the child's end edge from the end of the stack.
  final double? end;

  /// The offset of the child's bottom edge from the bottom of the stack.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can
  /// be set. The third must be null.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can
  /// be set. The third must be null.
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedPositionedDirectional(
      key: modifierKey,
      duration: duration,
      curve: curve,
      top: top,
      bottom: bottom,
      end: end,
      start: start,
      onEnd: onEnd,
      height: height,
      width: width,
      child: child!,
    );
  }
}

/// Animated version of [Transform.scale] which automatically transitions the child's
/// scale over a given duration whenever the given scale changes.
///
/// {@tool snippet}
///
/// This code defines a widget that uses [AnimatedScale] to change the size
/// of [FlutterLogo] gradually to a new scale whenever the button is pressed.
///
/// ```dart
/// class LogoScale extends StatefulWidget {
///   const LogoScale({super.key});
///
///   @override
///   State<LogoScale> createState() => LogoScaleState();
/// }
///
/// class LogoScaleState extends State<LogoScale> {
///   double scale = 1.0;
///
///   void _changeScale() {
///     setState(() => scale = scale == 1.0 ? 3.0 : 1.0);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       mainAxisAlignment: MainAxisAlignment.center,
///       children: <Widget>[
///         ElevatedButton(
///           onPressed: _changeScale,
///           child: const Text('Scale Logo'),
///         ),
///         Padding(
///           padding: const EdgeInsets.all(50),
///           child: AnimatedScale(
///             scale: scale,
///             duration: const Duration(seconds: 2),
///             child: const FlutterLogo(),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedRotation], for animating the rotation of a child.
///  * [AnimatedSize], for animating the resize of a child based on changes
///    in layout.
///  * [AnimatedSlide], for animating the translation of a child by a given offset relative to its size.
///  * [ScaleTransition], an explicitly animated version of this widget, where
///    an [Animation] is provided by the caller instead of being built in.
class AnimatedScaleModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its scale implicitly.
  ///
  /// The [scale] argument must not be null.
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedScaleModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.scale,
    this.alignment = Alignment.center,
    this.filterQuality,
  });

  /// The target scale.
  ///
  /// The scale must not be null.
  final double scale;

  /// The alignment of the origin of the coordinate system in which the scale
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the scale to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// {@macro flutter.widgets.Transform.optional.FilterQuality}
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedScale(
      key: modifierKey,
      duration: duration,
      scale: scale,
      alignment: alignment,
      curve: curve,
      filterQuality: filterQuality,
      onEnd: onEnd,
      child: child,
    );
  }
}

/// Animated version of [Transform.rotate] which automatically transitions the child's
/// rotation over a given duration whenever the given rotation changes.
///
/// {@tool snippet}
///
/// This code defines a widget that uses [AnimatedRotation] to rotate a [FlutterLogo]
/// gradually by an eighth of a turn (45 degrees) with each press of the button.
///
/// ```dart
/// class LogoRotate extends StatefulWidget {
///   const LogoRotate({super.key});
///
///   @override
///   State<LogoRotate> createState() => LogoRotateState();
/// }
///
/// class LogoRotateState extends State<LogoRotate> {
///   double turns = 0.0;
///
///   void _changeRotation() {
///     setState(() => turns += 1.0 / 8.0);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       mainAxisAlignment: MainAxisAlignment.center,
///       children: <Widget>[
///         ElevatedButton(
///           onPressed: _changeRotation,
///           child: const Text('Rotate Logo'),
///         ),
///         Padding(
///           padding: const EdgeInsets.all(50),
///           child: AnimatedRotation(
///             turns: turns,
///             duration: const Duration(seconds: 1),
///             child: const FlutterLogo(),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedScale], for animating the scale of a child.
///  * [RotationTransition], an explicitly animated version of this widget, where
///    an [Animation] is provided by the caller instead of being built in.
class AnimatedRotationModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its rotation implicitly.
  ///
  /// The [turns] argument must not be null.
  /// The [curve] and [duration] arguments must not be null.
  const AnimatedRotationModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.turns,
    this.alignment = Alignment.center,
    this.filterQuality,
  });

  /// The animation that controls the rotation of the child.
  ///
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  final double turns;

  /// The alignment of the origin of the coordinate system in which the rotation
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// {@macro flutter.widgets.Transform.optional.FilterQuality}
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedRotation(
      key: modifierKey,
      turns: turns,
      duration: duration,
      alignment: alignment,
      curve: curve,
      filterQuality: filterQuality,
      onEnd: onEnd,
      child: child,
    );
  }
}

/// Widget which automatically transitions the child's
/// offset relative to its normal position whenever the given offset changes.
///
/// The translation is expressed as an [Offset] scaled to the child's size. For
/// example, an [Offset] with a `dx` of 0.25 will result in a horizontal
/// translation of one quarter the width of the child.
///
/// {@tool dartpad}
/// This code defines a widget that uses [AnimatedSlide] to translate a [FlutterLogo]
/// up or down by the amount of it's height with each press of the corresponding button.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_slide.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
///  * [AnimatedAlign], which automatically transitions its child's
///    position over a given duration whenever the given [AnimatedAlign.alignment] changes.
class AnimatedSlideModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its offset translation implicitly.
  ///
  /// The [offset] and [duration] arguments must not be null.
  const AnimatedSlideModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.offset,
  });

  /// The target offset.
  /// The child will be translated horizontally by `width * dx` and vertically by `height * dy`
  ///
  /// The offset must not be null.
  final Offset offset;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedSlide(
      key: modifierKey,
      curve: curve,
      onEnd: onEnd,
      offset: offset,
      duration: duration,
      child: child,
    );
  }
}

/// Animated version of [Opacity] which automatically transitions the child's
/// opacity over a given duration whenever the given opacity changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=QZAvjqOqiLY}
///
/// Animating an opacity is relatively expensive because it requires painting
/// the child into an intermediate buffer.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_opacity.mp4}
///
/// {@tool snippet}
///
/// ```dart
/// class LogoFade extends StatefulWidget {
///   const LogoFade({super.key});
///
///   @override
///   State<LogoFade> createState() => LogoFadeState();
/// }
///
/// class LogoFadeState extends State<LogoFade> {
///   double opacityLevel = 1.0;
///
///   void _changeOpacity() {
///     setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       mainAxisAlignment: MainAxisAlignment.center,
///       children: <Widget>[
///         AnimatedOpacity(
///           opacity: opacityLevel,
///           duration: const Duration(seconds: 3),
///           child: const FlutterLogo(),
///         ),
///         ElevatedButton(
///           onPressed: _changeOpacity,
///           child: const Text('Fade Logo'),
///         ),
///       ],
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedCrossFade], for fading between two children.
///  * [AnimatedSwitcher], for fading between many children in sequence.
///  * [FadeTransition], an explicitly animated version of this widget, where
///    an [Animation] is provided by the caller instead of being built in.
///  * [SliverAnimatedOpacity], for automatically transitioning a sliver's
///    opacity over a given duration whenever the given opacity changes.
class AnimatedOpacityModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its opacity implicitly.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0,
  /// inclusive. The [curve] and [duration] arguments must not be null.
  const AnimatedOpacityModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  });

  /// The target opacity.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The opacity must not be null.
  final double opacity;

  /// Whether the semantic information of the children is always included.
  ///
  /// Defaults to false.
  ///
  /// When true, regardless of the opacity settings the child semantic
  /// information is exposed as if the widget were fully visible. This is
  /// useful in cases where labels may be hidden during animations that
  /// would otherwise contribute relevant semantics.
  final bool alwaysIncludeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedOpacity(
      key: modifierKey,
      duration: duration,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      curve: curve,
      onEnd: onEnd,
      child: child,
    );
  }
}

/// Animated version of [SliverOpacity] which automatically transitions the
/// sliver child's opacity over a given duration whenever the given opacity
/// changes.
///
/// Animating an opacity is relatively expensive because it requires painting
/// the sliver child into an intermediate buffer.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
///
/// {@tool dartpad}
/// Creates a [CustomScrollView] with a [SliverFixedExtentList] and a
/// [FloatingActionButton]. Pressing the button animates the lists' opacity.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/sliver_animated_opacity.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [SliverFadeTransition], an explicitly animated version of this widget, where
///    an [Animation] is provided by the caller instead of being built in.
///  * [AnimatedOpacity], for automatically transitioning a box child's
///    opacity over a given duration whenever the given opacity changes.
class SliverAnimatedOpacityModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates its opacity implicitly.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0,
  /// inclusive. The [curve] and [duration] arguments must not be null.
  const SliverAnimatedOpacityModifier({
    super.key,
    Widget? sliver,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(
          child: sliver,
        );

  /// The target opacity.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The opacity must not be null.
  final double opacity;

  /// Whether the semantic information of the children is always included.
  ///
  /// Defaults to false.
  ///
  /// When true, regardless of the opacity settings the sliver child's semantic
  /// information is exposed as if the widget were fully visible. This is
  /// useful in cases where labels may be hidden during animations that
  /// would otherwise contribute relevant semantics.
  final bool alwaysIncludeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverAnimatedOpacity(
      opacity: opacity,
      duration: duration,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      curve: curve,
      onEnd: onEnd,
      sliver: child,
    );
  }
}

/// Animated version of [DefaultTextStyle] which automatically transitions the
/// default text style (the text style to apply to descendant [Text] widgets
/// without explicit style) over a given duration whenever the given style
/// changes.
///
/// The [textAlign], [softWrap], [overflow], [maxLines], [textWidthBasis]
/// and [textHeightBehavior] properties are not animated and take effect
/// immediately when changed.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.elasticInOut].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_default_text_style.mp4}
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new default text style. If you require
/// more control over the animation (e.g. if you want to stop it mid-animation),
/// consider using a [DefaultTextStyleTransition] instead, which takes a provided
/// [Animation] as argument. While that allows you to fine-tune the animation,
/// it also requires more development overhead as you have to manually manage
/// the lifecycle of the underlying [AnimationController].
class AnimatedDefaultTextStyleModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates the default text style implicitly.
  ///
  /// The [child], [style], [softWrap], [overflow], [curve], and [duration]
  /// arguments must not be null.
  const AnimatedDefaultTextStyleModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  });

  /// The target text style.
  ///
  /// The text style must not be null.
  ///
  /// When this property is changed, the style will be animated over [duration] time.
  final TextStyle style;

  /// How the text should be aligned horizontally.
  ///
  /// This property takes effect immediately when changed, it is not animated.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// This property takes effect immediately when changed, it is not animated.
  ///
  /// See [DefaultTextStyle.softWrap] for more details.
  final bool softWrap;

  /// How visual overflow should be handled.
  ///
  /// This property takes effect immediately when changed, it is not animated.
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  ///
  /// This property takes effect immediately when changed, it is not animated.
  ///
  /// See [DefaultTextStyle.maxLines] for more details.
  final int? maxLines;

  /// The strategy to use when calculating the width of the Text.
  ///
  /// See [TextWidthBasis] for possible values and their implications.
  final TextWidthBasis textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedDefaultTextStyle(
      key: modifierKey,
      duration: duration,
      style: style,
      curve: curve,
      maxLines: maxLines,
      onEnd: onEnd,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      child: child!,
    );
  }
}

/// Animated version of [PhysicalModel].
///
/// The [borderRadius] and [elevation] are animated.
///
/// The [color] is animated if the [animateColor] property is set; otherwise,
/// the color changes immediately at the start of the animation for the other
/// two properties. This allows the color to be animated independently (e.g.
/// because it is being driven by an [AnimatedTheme]).
///
/// The [shape] is not animated.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_physical_model.mp4}
class AnimatedPhysicalModelModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that animates the properties of a [PhysicalModel].
  ///
  /// The [child], [shape], [borderRadius], [elevation], [color], [shadowColor],
  /// [curve], [clipBehavior], and [duration] arguments must not be null.
  /// Additionally, [elevation] must be non-negative.
  ///
  /// Animating [color] is optional and is controlled by the [animateColor] flag.
  ///
  /// Animating [shadowColor] is optional and is controlled by the [animateShadowColor] flag.
  const AnimatedPhysicalModelModifier({
    super.key,
    super.child,
    super.curve,
    required super.duration,
    super.onEnd,
    super.modifierKey,
    required this.shape,
    this.clipBehavior = Clip.none,
    this.borderRadius = BorderRadius.zero,
    required this.elevation,
    required this.color,
    this.animateColor = true,
    required this.shadowColor,
    this.animateShadowColor = true,
  });

  /// The type of shape.
  ///
  /// This property is not animated.
  final BoxShape shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The target border radius of the rounded corners for a rectangle shape.
  final BorderRadius borderRadius;

  /// The target z-coordinate relative to the parent at which to place this
  /// physical object.
  ///
  /// The value will always be non-negative.
  final double elevation;

  /// The target background color.
  final Color color;

  /// Whether the color should be animated.
  final bool animateColor;

  /// The target shadow color.
  final Color shadowColor;

  /// Whether the shadow color should be animated.
  final bool animateShadowColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedPhysicalModel(
      key: modifierKey,
      shape: shape,
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      duration: duration,
      animateColor: animateColor,
      animateShadowColor: animateShadowColor,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      curve: curve,
      onEnd: onEnd,
      child: child!,
    );
  }
}

/// Animated version of [FractionallySizedBox] which automatically transitions the
/// child's size over a given duration whenever the given [widthFactor] or
/// [heightFactor] changes, as well as the position whenever the given [alignment]
/// changes.
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new target [widthFactor] or
/// [heightFactor].
///
/// {@tool dartpad}
/// The following example transitions an [AnimatedFractionallySizedBox]
/// between two states. It adjusts the [heightFactor], [widthFactor], and
/// [alignment] properties when tapped, using a [curve] of [Curves.fastOutSlowIn]
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_fractionally_sized_box.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which is an implicitly animated version of [Align].
///  * [AnimatedContainer], which can transition more values at once.
///  * [AnimatedSlide], which can animate the translation of child by a given offset relative to its size.
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
class AnimatedFractionallySizedBoxModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates a widget that sizes its child to a fraction of the total available
  /// space that animates implicitly, and positions its child by an alignment
  /// that animates implicitly.
  ///
  /// The [curve] and [duration] argument must not be null
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const AnimatedFractionallySizedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.alignment = Alignment.center,
    this.heightFactor,
    this.widthFactor,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  /// {@macro flutter.widgets.basic.fractionallySizedBox.heightFactor}
  final double? heightFactor;

  /// {@macro flutter.widgets.basic.fractionallySizedBox.widthFactor}
  final double? widthFactor;

  /// {@macro flutter.widgets.basic.fractionallySizedBox.alignment}
  final AlignmentGeometry alignment;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedFractionallySizedBox(
      key: modifierKey,
      duration: duration,
      alignment: alignment,
      curve: curve,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      onEnd: onEnd,
      child: child,
    );
  }
}
