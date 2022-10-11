import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Animates the position of a widget relative to its normal position.
///
/// The translation is expressed as an [Offset] scaled to the child's size. For
/// example, an [Offset] with a `dx` of 0.25 will result in a horizontal
/// translation of one quarter the width of the child.
///
/// By default, the offsets are applied in the coordinate system of the canvas
/// (so positive x offsets move the child towards the right). If a
/// [textDirection] is provided, then the offsets are applied in the reading
/// direction, so in right-to-left text, positive x offsets move towards the
/// left, and in left-to-right text, positive x offsets move towards the right.
///
/// Here's an illustration of the [SlideTransition] widget, with its [position]
/// animated by a [CurvedAnimation] set to [Curves.elasticIn]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/slide_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [SlideTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/slide_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AlignTransition], an animated version of an [Align] that animates its
///    [Align.alignment] property.
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
class SlideTransitionModifier extends SingleChildStatelessModifier {
  /// Creates a fractional translation transition.
  ///
  /// The [position] argument must not be null.
  const SlideTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.position,
    this.transformHitTests = true,
    this.textDirection,
  });

  /// The animation that controls the position of the child.
  ///
  /// If the current value of the position animation is `(dx, dy)`, the child
  /// will be translated horizontally by `width * dx` and vertically by
  /// `height * dy`, after applying the [textDirection] if available.
  final Animation<Offset> position;

  /// The direction to use for the x offset described by the [position].
  ///
  /// If [textDirection] is null, the x offset is applied in the coordinate
  /// system of the canvas (so positive x offsets move the child towards the
  /// right).
  ///
  /// If [textDirection] is [TextDirection.rtl], the x offset is applied in the
  /// reading direction such that x offsets move the child towards the left.
  ///
  /// If [textDirection] is [TextDirection.ltr], the x offset is applied in the
  /// reading direction such that x offsets move the child towards the right.
  final TextDirection? textDirection;

  /// Whether hit testing should be affected by the slide animation.
  ///
  /// If false, hit testing will proceed as if the child was not translated at
  /// all. Setting this value to false is useful for fast animations where you
  /// expect the user to commonly interact with the child widget in its final
  /// location and you want the user to benefit from "muscle memory".
  final bool transformHitTests;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SlideTransition(
      key: modifierKey,
      textDirection: textDirection,
      transformHitTests: transformHitTests,
      position: position,
      child: child,
    );
  }
}

/// Animates the scale of a transformed widget.
///
/// Here's an illustration of the [ScaleTransition] widget, with it's [alignment]
/// animated by a [CurvedAnimation] set to [Curves.fastOutSlowIn]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/scale_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [ScaleTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/scale_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
class ScaleTransitionModifier extends SingleChildStatelessModifier {
  /// Creates a scale transition.
  ///
  /// The [scale] argument must not be null. The [alignment] argument defaults
  /// to [Alignment.center].
  const ScaleTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.scale,
    this.alignment = Alignment.center,
    this.filterQuality,
  });

  /// The animation that controls the scale of the child.
  ///
  /// If the current value of the scale animation is v, the child will be
  /// painted v times its normal size.
  final Animation<double> scale;

  /// The alignment of the origin of the coordinate system in which the scale
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the scale to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// When the animation is stopped (either in [AnimationStatus.dismissed] or
  /// [AnimationStatus.completed]), the filter quality argument will be ignored.
  ///
  /// {@macro flutter.widgets.Transform.optional.FilterQuality}
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScaleTransition(
      key: modifierKey,
      scale: scale,
      alignment: alignment,
      filterQuality: filterQuality,
      child: child,
    );
  }
}

/// Animates the rotation of a widget.
///
/// Here's an illustration of the [RotationTransition] widget, with it's [turns]
/// animated by a [CurvedAnimation] set to [Curves.elasticOut]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/rotation_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [RotationTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/rotation_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ScaleTransition], a widget that animates the scale of a transformed
///    widget.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
class RotationTransitionModifier extends SingleChildStatelessModifier {
  /// Creates a rotation transition.
  ///
  /// The [turns] argument must not be null.
  const RotationTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.turns,
    this.alignment = Alignment.center,
    this.filterQuality,
  });

  /// The animation that controls the rotation of the child.
  ///
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  final Animation<double> turns;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to top right corner, use
  /// an alignment of (1.0, -1.0) or use [Alignment.topRight]
  final Alignment alignment;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// When the animation is stopped (either in [AnimationStatus.dismissed] or
  /// [AnimationStatus.completed]), the filter quality argument will be ignored.
  ///
  /// {@macro flutter.widgets.Transform.optional.FilterQuality}
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RotationTransition(
      key: modifierKey,
      turns: turns,
      alignment: alignment,
      filterQuality: filterQuality,
      child: child,
    );
  }
}

/// Animates its own size and clips and aligns its child.
///
/// [SizeTransition] acts as a [ClipRect] that animates either its width or its
/// height, depending upon the value of [axis]. The alignment of the child along
/// the [axis] is specified by the [axisAlignment].
///
/// Like most widgets, [SizeTransition] will conform to the constraints it is
/// given, so be sure to put it in a context where it can change size. For
/// instance, if you place it into a [Container] with a fixed size, then the
/// [SizeTransition] will not be able to change size, and will appear to do
/// nothing.
///
/// Here's an illustration of the [SizeTransition] widget, with it's [sizeFactor]
/// animated by a [CurvedAnimation] set to [Curves.fastOutSlowIn]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/size_transition.mp4}
///
/// {@tool dartpad}
/// This code defines a widget that uses [SizeTransition] to change the size
/// of [FlutterLogo] continually. It is built with a [Scaffold]
/// where the internal widget has space to change its size.
///
/// ** See code in examples/api/lib/widgets/transitions/size_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedCrossFade], for a widget that automatically animates between
///    the sizes of two children, fading between them.
///  * [ScaleTransition], a widget that scales the size of the child instead of
///    clipping it.
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
class SizeTransitionModifier extends SingleChildStatelessModifier {
  /// Creates a size transition.
  ///
  /// The [axis], [sizeFactor], and [axisAlignment] arguments must not be null.
  /// The [axis] argument defaults to [Axis.vertical]. The [axisAlignment]
  /// defaults to 0.0, which centers the child along the main axis during the
  /// transition.
  const SizeTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.axis = Axis.vertical,
    required this.sizeFactor,
    this.axisAlignment = 0.0,
  });

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// The animation that controls the (clipped) size of the child.
  ///
  /// The width or height (depending on the [axis] value) of this widget will be
  /// its intrinsic width or height multiplied by [sizeFactor]'s value at the
  /// current point in the animation.
  ///
  /// If the value of [sizeFactor] is less than one, the child will be clipped
  /// in the appropriate axis.
  final Animation<double> sizeFactor;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizeTransition(
      key: modifierKey,
      axis: axis,
      axisAlignment: axisAlignment,
      sizeFactor: sizeFactor,
      child: child,
    );
  }
}

/// Animates the opacity of a widget.
///
/// For a widget that automatically animates between the sizes of two children,
/// fading between them, see [AnimatedCrossFade].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=rLwWVbv3xDQ}
///
/// Here's an illustration of the [FadeTransition] widget, with it's [opacity]
/// animated by a [CurvedAnimation] set to [Curves.fastOutSlowIn]:
///
/// {@tool dartpad}
/// The following code implements the [FadeTransition] using
/// the Flutter logo:
///
/// ** See code in examples/api/lib/widgets/transitions/fade_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Opacity], which does not animate changes in opacity.
///  * [AnimatedOpacity], which animates changes in opacity without taking an
///    explicit [Animation] argument.
class FadeTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an opacity transition.
  ///
  /// The [opacity] argument must not be null.
  const FadeTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  });

  /// The animation that controls the opacity of the child.
  ///
  /// If the current value of the opacity animation is v, the child will be
  /// painted with an opacity of v. For example, if v is 0.5, the child will be
  /// blended 50% with its background. Similarly, if v is 0.0, the child will be
  /// completely transparent.
  final Animation<double> opacity;

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
    return FadeTransition(
      key: modifierKey,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: child,
    );
  }
}

/// Animates the opacity of a sliver widget.
///
/// {@tool dartpad}
/// Creates a [CustomScrollView] with a [SliverFixedExtentList] that uses a
/// [SliverFadeTransition] to fade the list in and out.
///
/// ** See code in examples/api/lib/widgets/transitions/sliver_fade_transition.0.dart **
/// {@end-tool}
///
/// Here's an illustration of the [FadeTransition] widget, the [RenderBox]
/// equivalent widget, with it's [opacity] animated by a [CurvedAnimation] set
/// to [Curves.fastOutSlowIn]:
///
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/fade_transition.mp4}
///
/// See also:
///
///  * [SliverOpacity], which does not animate changes in opacity.
class SliverFadeTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an opacity transition.
  ///
  /// The [opacity] argument must not be null.
  const SliverFadeTransitionModifier({
    super.key,
    Widget? sliver,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(child: sliver);

  /// The animation that controls the opacity of the sliver child.
  ///
  /// If the current value of the opacity animation is v, the child will be
  /// painted with an opacity of v. For example, if v is 0.5, the child will be
  /// blended 50% with its background. Similarly, if v is 0.0, the child will be
  /// completely transparent.
  final Animation<double> opacity;

  /// Whether the semantic information of the sliver child is always included.
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
    return SliverFadeTransition(
      key: modifierKey,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      sliver: child,
    );
  }
}

/// Animated version of [Positioned] which takes a specific
/// [Animation<RelativeRect>] to transition the child's position from a start
/// position to an end position over the lifetime of the animation.
///
/// Only works if it's the child of a [Stack].
///
/// Here's an illustration of the [PositionedTransition] widget, with it's [rect]
/// animated by a [CurvedAnimation] set to [Curves.elasticInOut]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/positioned_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [PositionedTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/positioned_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPositioned], which transitions a child's position without
///    taking an explicit [Animation] argument.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
///  * [SlideTransition], a widget that animates the position of a widget
///    relative to its normal position.
///  * [AlignTransition], an animated version of an [Align] that animates its
///    [Align.alignment] property.
///  * [ScaleTransition], a widget that animates the scale of a transformed
///    widget.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
class PositionedTransitionModifier extends SingleChildStatelessModifier {
  /// Creates a transition for [Positioned].
  ///
  /// The [rect] argument must not be null.
  const PositionedTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.rect,
  });

  /// The animation that controls the child's size and position.
  final Animation<RelativeRect> rect;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PositionedTransition(
      key: modifierKey,
      rect: rect,
      child: child!,
    );
  }
}

/// Animated version of [Positioned] which transitions the child's position
/// based on the value of [rect] relative to a bounding box with the
/// specified [size].
///
/// Only works if it's the child of a [Stack].
///
/// Here's an illustration of the [RelativePositionedTransition] widget, with it's [rect]
/// animated by a [CurvedAnimation] set to [Curves.elasticInOut]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/relative_positioned_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [RelativePositionedTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/relative_positioned_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [AlignTransition], an animated version of an [Align] that animates its
///    [Align.alignment] property.
///  * [ScaleTransition], a widget that animates the scale of a transformed
///    widget.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
///  * [SlideTransition], a widget that animates the position of a widget
///    relative to its normal position.
class RelativePositionedTransitionModifier extends SingleChildStatelessModifier {
  /// Create an animated version of [Positioned].
  ///
  /// Each frame, the [Positioned] widget will be configured to represent the
  /// current value of the [rect] argument assuming that the stack has the given
  /// [size]. Both [rect] and [size] must not be null.
  const RelativePositionedTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.rect,
    required this.size,
  });

  /// The animation that controls the child's size and position.
  ///
  /// If the animation returns a null [Rect], the rect is assumed to be [Rect.zero].
  ///
  /// See also:
  ///
  ///  * [size], which gets the size of the box that the [Positioned] widget's
  ///    offsets are relative to.
  final Animation<Rect?> rect;

  /// The [Positioned] widget's offsets are relative to a box of this
  /// size whose origin is 0,0.
  final Size size;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RelativePositionedTransition(
      key: modifierKey,
      rect: rect,
      size: size,
      child: child!,
    );
  }
}

/// Animated version of a [DecoratedBox] that animates the different properties
/// of its [Decoration].
///
/// Here's an illustration of the [DecoratedBoxTransition] widget, with it's
/// [decoration] animated by a [CurvedAnimation] set to [Curves.decelerate]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/decorated_box_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [DecoratedBoxTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/decorated_box_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [DecoratedBox], which also draws a [Decoration] but is not animated.
///  * [AnimatedContainer], a more full-featured container that also animates on
///    decoration using an internal animation.
class DecoratedBoxTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an animated [DecoratedBox] whose [Decoration] animation updates
  /// the widget.
  ///
  /// The [decoration] and [position] must not be null.
  ///
  /// See also:
  ///
  ///  * [DecoratedBox.new]
  const DecoratedBoxTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.decoration,
    this.position = DecorationPosition.background,
  });

  /// Animation of the decoration to paint.
  ///
  /// Can be created using a [DecorationTween] interpolating typically between
  /// two [BoxDecoration].
  final Animation<Decoration> decoration;

  /// Whether to paint the box decoration behind or in front of the child.
  final DecorationPosition position;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DecoratedBoxTransition(
      key: modifierKey,
      position: position,
      decoration: decoration,
      child: child!,
    );
  }
}

/// Animated version of an [Align] that animates its [Align.alignment] property.
///
/// Here's an illustration of the [DecoratedBoxTransition] widget, with it's
/// [DecoratedBoxTransition.decoration] animated by a [CurvedAnimation] set to
/// [Curves.decelerate]:
///
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/align_transition.mp4}
///
/// {@tool dartpad}
/// The following code implements the [AlignTransition] as seen in the video
/// above:
///
/// ** See code in examples/api/lib/widgets/transitions/align_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which animates changes to the [alignment] without
///    taking an explicit [Animation] argument.
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
///  * [SlideTransition], a widget that animates the position of a widget
///    relative to its normal position.
class AlignTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an animated [Align] whose [AlignmentGeometry] animation updates
  /// the widget.
  ///
  /// See also:
  ///
  ///  * [Align.new].
  const AlignTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.alignment,
    this.widthFactor,
    this.heightFactor,
  });

  /// The animation that controls the child's alignment.
  final Animation<AlignmentGeometry> alignment;

  /// If non-null, the child's width factor, see [Align.widthFactor].
  final double? widthFactor;

  /// If non-null, the child's height factor, see [Align.heightFactor].
  final double? heightFactor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AlignTransition(
      key: modifierKey,
      alignment: alignment,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: child!,
    );
  }
}

/// Animated version of a [DefaultTextStyle] that animates the different properties
/// of its [TextStyle].
///
/// {@tool dartpad}
/// The following code implements the [DefaultTextStyleTransition] that shows
/// a transition between thick blue font and thin red font.
///
/// ** See code in examples/api/lib/widgets/transitions/default_text_style_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedDefaultTextStyle], which animates changes in text style without
///    taking an explicit [Animation] argument.
///  * [DefaultTextStyle], which also defines a [TextStyle] for its descendants
///    but is not animated.
class DefaultTextStyleTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an animated [DefaultTextStyle] whose [TextStyle] animation updates
  /// the widget.
  const DefaultTextStyleTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  });

  /// The animation that controls the descendants' text style.
  final Animation<TextStyle> style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// See [DefaultTextStyle.softWrap] for more details.
  final bool softWrap;

  /// How visual overflow should be handled.
  ///
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  ///
  /// See [DefaultTextStyle.maxLines] for more details.
  final int? maxLines;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextStyleTransition(
      key: modifierKey,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      child: child!,
    );
  }
}

/// A general-purpose widget for building animations.
///
/// AnimatedBuilder is useful for more complex widgets that wish to include
/// an animation as part of a larger build function. To use AnimatedBuilder,
/// simply construct the widget and pass it a builder function.
///
/// For simple cases without additional state, consider using
/// [AnimatedWidget].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=N-RiyZlv8v8}
///
/// ## Performance optimizations
///
/// If your [builder] function contains a subtree that does not depend on the
/// animation, it's more efficient to build that subtree once instead of
/// rebuilding it on every animation tick.
///
/// If you pass the pre-built subtree as the [child] parameter, the
/// [AnimatedBuilder] will pass it back to your builder function so that you
/// can incorporate it into your build.
///
/// Using this pre-built child is entirely optional, but can improve
/// performance significantly in some cases and is therefore a good practice.
///
/// {@tool dartpad}
/// This code defines a widget that spins a green square continually. It is
/// built with an [AnimatedBuilder] and makes use of the [child] feature to
/// avoid having to rebuild the [Container] each time.
///
/// ** See code in examples/api/lib/widgets/transitions/animated_builder.0.dart **
/// {@end-tool}
///
/// {@template flutter.flutter.animatedbuilder_changenotifier.rebuild}
/// ## Improve rebuilds performance using AnimatedBuilder
///
/// Despite the name, [AnimatedBuilder] is not limited to [Animation]s. Any subtype
/// of [Listenable] (such as [ChangeNotifier] and [ValueNotifier]) can be used with
/// an [AnimatedBuilder] to rebuild only certain parts of a widget when the
/// [Listenable] notifies its listeners. This technique is a performance improvement
/// that allows rebuilding only specific widgets leaving others untouched.
///
/// {@tool dartpad}
/// The following example implements a simple counter that utilizes an
/// [AnimatedBuilder] to limit rebuilds to only the [Text] widget. The current count
/// is stored in a [ValueNotifier], which rebuilds the [AnimatedBuilder]'s contents
/// when its value is changed.
///
/// ** See code in examples/api/lib/foundation/change_notifier/change_notifier.0.dart **
/// {@end-tool}
/// {@endtemplate}
///
/// See also:
///
///  * [TweenAnimationBuilder], which animates a property to a target value
///    without requiring manual management of an [AnimationController].
class AnimatedBuilderModifier extends SingleChildStatelessModifier {
  /// Creates an animated builder.
  ///
  /// The [animation] and [builder] arguments must not be null.
  const AnimatedBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.animation,
    required this.builder,
  });

  /// Animation listenable
  final Listenable animation;

  /// Called every time the animation changes value.
  final TransitionBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedBuilder(
      key: modifierKey,
      animation: animation,
      builder: builder,
      child: child,
    );
  }
}
