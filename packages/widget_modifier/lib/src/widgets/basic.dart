import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that determines the ambient directionality of text and
/// text-direction-sensitive render objects.
///
/// For example, [Padding] depends on the [Directionality] to resolve
/// [EdgeInsetsDirectional] objects into absolute [EdgeInsets] objects.
class DirectionalityModifier extends SingleChildStatelessModifier {
  /// Creates a widget that determines the directionality of text and
  /// text-direction-sensitive render objects.
  ///
  /// The [textDirection] and [child] arguments must not be null.
  const DirectionalityModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.textDirection,
  });

  /// The text direction for this subtree.
  final TextDirection textDirection;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Directionality(
      key: modifierKey,
      textDirection: textDirection,
      child: child!,
    );
  }
}

/// A widget that makes its child partially transparent.
///
/// This class paints its child into an intermediate buffer and then blends the
/// child back into the scene partially transparent.
///
/// For values of opacity other than 0.0 and 1.0, this class is relatively
/// expensive because it requires painting the child into an intermediate
/// buffer. For the value 0.0, the child is simply not painted at all. For the
/// value 1.0, the child is painted immediately without an intermediate buffer.
///
/// The presence of the intermediate buffer which has a transparent background
/// by default may cause some child widgets to behave differently. For example
/// a [BackdropFilter] child will only be able to apply its filter to the content
/// between this widget and the backdrop child and may require adjusting the
/// [BackdropFilter.blendMode] property to produce the desired results.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=9hltevOHQBw}
///
/// {@tool snippet}
///
/// This example shows some [Text] when the `_visible` member field is true, and
/// hides it when it is false:
///
/// ```dart
/// Opacity(
///   opacity: _visible ? 1.0 : 0.0,
///   child: const Text("Now you see me, now you don't!"),
/// )
/// ```
/// {@end-tool}
///
/// This is more efficient than adding and removing the child widget from the
/// tree on demand.
///
/// ## Performance considerations for opacity animation
///
/// Animating an [Opacity] widget directly causes the widget (and possibly its
/// subtree) to rebuild each frame, which is not very efficient. Consider using
/// an [AnimatedOpacity] or a [FadeTransition] instead.
///
/// ## Transparent image
///
/// If only a single [Image] or [Color] needs to be composited with an opacity
/// between 0.0 and 1.0, it's much faster to directly use them without [Opacity]
/// widgets.
///
/// For example, `Container(color: Color.fromRGBO(255, 0, 0, 0.5))` is much
/// faster than `Opacity(opacity: 0.5, child: Container(color: Colors.red))`.
///
/// {@tool snippet}
///
/// The following example draws an [Image] with 0.5 opacity without using
/// [Opacity]:
///
/// ```dart
/// Image.network(
///   'https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/packages/diagrams/assets/blend_mode_destination.jpeg',
///   color: const Color.fromRGBO(255, 255, 255, 0.5),
///   colorBlendMode: BlendMode.modulate
/// )
/// ```
///
/// {@end-tool}
///
/// Directly drawing an [Image] or [Color] with opacity is faster than using
/// [Opacity] on top of them because [Opacity] could apply the opacity to a
/// group of widgets and therefore a costly offscreen buffer will be used.
/// Drawing content into the offscreen buffer may also trigger render target
/// switches and such switching is particularly slow in older GPUs.
///
/// See also:
///
///  * [Visibility], which can hide a child more efficiently (albeit less
///    subtly, because it is either visible or hidden, rather than allowing
///    fractional opacity values).
///  * [ShaderMask], which can apply more elaborate effects to its child.
///  * [Transform], which applies an arbitrary transform to its child widget at
///    paint time.
///  * [AnimatedOpacity], which uses an animation internally to efficiently
///    animate opacity.
///  * [FadeTransition], which uses a provided animation to efficiently animate
///    opacity.
///  * [Image], which can directly provide a partially transparent image with
///    much less performance hit.
class OpacityModifier extends SingleChildStatelessModifier {
  /// Creates a widget that makes its child partially transparent.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0
  /// (inclusive).
  const OpacityModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  /// The fraction to scale the child's alpha value.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The opacity must not be null.
  ///
  /// Values 1.0 and 0.0 are painted with a fast path. Other values
  /// require painting the child into an intermediate buffer, which is
  /// expensive.
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
    return Opacity(
      key: modifierKey,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: child,
    );
  }
}

/// A widget that applies a mask generated by a [Shader] to its child.
///
/// For example, [ShaderMask] can be used to gradually fade out the edge
/// of a child by using a [ui.Gradient.linear] mask.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=7sUL66pTQ7Q}
///
/// {@tool snippet}
///
/// This example makes the text look like it is on fire:
///
/// ```dart
/// ShaderMask(
///   shaderCallback: (Rect bounds) {
///     return RadialGradient(
///       center: Alignment.topLeft,
///       radius: 1.0,
///       colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
///       tileMode: TileMode.mirror,
///     ).createShader(bounds);
///   },
///   child: const Text('I’m burning the memories'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Opacity], which can apply a uniform alpha effect to its child.
///  * [CustomPaint], which lets you draw directly on the canvas.
///  * [DecoratedBox], for another approach at decorating child widgets.
///  * [BackdropFilter], which applies an image filter to the background.
class ShaderMaskModifier extends SingleChildStatelessModifier {
  /// Creates a widget that applies a mask generated by a [Shader] to its child.
  ///
  /// The [shaderCallback] and [blendMode] arguments must not be null.
  const ShaderMaskModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.shaderCallback,
    this.blendMode = BlendMode.modulate,
  });

  /// Called to create the [dart:ui.Shader] that generates the mask.
  ///
  /// The shader callback is called with the current size of the child so that
  /// it can customize the shader to the size and location of the child.
  ///
  /// Typically this will use a [LinearGradient], [RadialGradient], or
  /// [SweepGradient] to create the [dart:ui.Shader], though the
  /// [dart:ui.ImageShader] class could also be used.
  final ShaderCallback shaderCallback;

  /// The [BlendMode] to use when applying the shader to the child.
  ///
  /// The default, [BlendMode.modulate], is useful for applying an alpha blend
  /// to the child. Other blend modes can be used to create other effects.
  final BlendMode blendMode;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ShaderMask(
      key: modifierKey,
      shaderCallback: shaderCallback,
      blendMode: blendMode,
      child: child,
    );
  }
}

/// A widget that applies a filter to the existing painted content and then
/// paints [child].
///
/// The filter will be applied to all the area within its parent or ancestor
/// widget's clip. If there's no clip, the filter will be applied to the full
/// screen.
///
/// The results of the filter will be blended back into the background using
/// the [blendMode] parameter.
/// {@template flutter.widgets.BackdropFilter.blendMode}
/// The only value for [blendMode] that is supported on all platforms is
/// [BlendMode.srcOver] which works well for most scenes. But that value may
/// produce surprising results when a parent of the [BackdropFilter] uses a
/// temporary buffer, or save layer, as does an [Opacity] widget. In that
/// situation, a value of [BlendMode.src] can produce more pleasing results,
/// but at the cost of incompatibility with some platforms, most notably the
/// html renderer for web applications.
/// {@endtemplate}
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=dYRs7Q1vfYI}
///
/// {@tool snippet}
/// If the [BackdropFilter] needs to be applied to an area that exactly matches
/// its child, wraps the [BackdropFilter] with a clip widget that clips exactly
/// to that child.
///
/// ```dart
/// Stack(
///   fit: StackFit.expand,
///   children: <Widget>[
///     Text('0' * 10000),
///     Center(
///       child: ClipRect(  // <-- clips to the 200x200 [Container] below
///         child: BackdropFilter(
///           filter: ui.ImageFilter.blur(
///             sigmaX: 5.0,
///             sigmaY: 5.0,
///           ),
///           child: Container(
///             alignment: Alignment.center,
///             width: 200.0,
///             height: 200.0,
///             child: const Text('Hello World'),
///           ),
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// This effect is relatively expensive, especially if the filter is non-local,
/// such as a blur.
///
/// If all you want to do is apply an [ImageFilter] to a single widget
/// (as opposed to applying the filter to everything _beneath_ a widget), use
/// [ImageFiltered] instead. For that scenario, [ImageFiltered] is both
/// easier to use and less expensive than [BackdropFilter].
///
/// See also:
///
///  * [ImageFiltered], which applies an [ImageFilter] to its child.
///  * [DecoratedBox], which draws a background under (or over) a widget.
///  * [Opacity], which changes the opacity of the widget itself.
class BackdropFilterModifier extends SingleChildStatelessModifier {
  /// Creates a backdrop filter.
  ///
  /// The [filter] argument must not be null.
  /// The [blendMode] argument will default to [BlendMode.srcOver] and must not be
  /// null if provided.
  const BackdropFilterModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.filter,
    this.blendMode = BlendMode.srcOver,
  });

  /// The image filter to apply to the existing painted content before painting the child.
  ///
  /// For example, consider using [ImageFilter.blur] to create a backdrop
  /// blur effect.
  final ui.ImageFilter filter;

  /// The blend mode to use to apply the filtered background content onto the background
  /// surface.
  ///
  /// {@macro flutter.widgets.BackdropFilter.blendMode}
  final BlendMode blendMode;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BackdropFilter(
      key: modifierKey,
      filter: filter,
      blendMode: blendMode,
      child: child,
    );
  }
}

/// A widget that provides a canvas on which to draw during the paint phase.
///
/// When asked to paint, [CustomPaint] first asks its [painter] to paint on the
/// current canvas, then it paints its child, and then, after painting its
/// child, it asks its [foregroundPainter] to paint. The coordinate system of the
/// canvas matches the coordinate system of the [CustomPaint] object. The
/// painters are expected to paint within a rectangle starting at the origin and
/// encompassing a region of the given size. (If the painters paint outside
/// those bounds, there might be insufficient memory allocated to rasterize the
/// painting commands and the resulting behavior is undefined.) To enforce
/// painting within those bounds, consider wrapping this [CustomPaint] with a
/// [ClipRect] widget.
///
/// Painters are implemented by subclassing [CustomPainter].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=kp14Y4uHpHs}
///
/// Because custom paint calls its painters during paint, you cannot call
/// `setState` or `markNeedsLayout` during the callback (the layout for this
/// frame has already happened).
///
/// Custom painters normally size themselves to their child. If they do not have
/// a child, they attempt to size themselves to the [size], which defaults to
/// [Size.zero]. [size] must not be null.
///
/// [isComplex] and [willChange] are hints to the compositor's raster cache
/// and must not be null.
///
/// {@tool snippet}
///
/// This example shows how the sample custom painter shown at [CustomPainter]
/// could be used in a [CustomPaint] widget to display a background to some
/// text.
///
/// ```dart
/// CustomPaint(
///   painter: Sky(),
///   child: const Center(
///     child: Text(
///       'Once upon a time...',
///       style: TextStyle(
///         fontSize: 40.0,
///         fontWeight: FontWeight.w900,
///         color: Color(0xFFFFFFFF),
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomPainter], the class to extend when creating custom painters.
///  * [Canvas], the class that a custom painter uses to paint.
class CustomPaintModifier extends SingleChildStatelessModifier {
  /// Creates a widget that delegates its painting.
  const CustomPaintModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
  }) : assert(painter != null || foregroundPainter != null || (!isComplex && !willChange));

  /// The painter that paints before the children.
  final CustomPainter? painter;

  /// The painter that paints after the children.
  final CustomPainter? foregroundPainter;

  /// The size that this [CustomPaint] should aim for, given the layout
  /// constraints, if there is no child.
  ///
  /// Defaults to [Size.zero].
  ///
  /// If there's a child, this is ignored, and the size of the child is used
  /// instead.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  ///
  /// The compositor contains a raster cache that holds bitmaps of layers in
  /// order to avoid the cost of repeatedly rendering those layers on each
  /// frame. If this flag is not set, then the compositor will apply its own
  /// heuristics to decide whether the this layer is complex enough to benefit
  /// from caching.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool isComplex;

  /// Whether the raster cache should be told that this painting is likely
  /// to change in the next frame.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool willChange;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CustomPaint(
      key: modifierKey,
      size: size,
      painter: painter,
      foregroundPainter: foregroundPainter,
      isComplex: isComplex,
      willChange: willChange,
      child: child,
    );
  }
}

/// A widget that clips its child using a rectangle.
///
/// By default, [ClipRect] prevents its child from painting outside its
/// bounds, but the size and location of the clip rect can be customized using a
/// custom [clipper].
///
/// [ClipRect] is commonly used with these widgets, which commonly paint outside
/// their bounds:
///
///  * [CustomPaint]
///  * [CustomSingleChildLayout]
///  * [CustomMultiChildLayout]
///  * [Align] and [Center] (e.g., if [Align.widthFactor] or
///    [Align.heightFactor] is less than 1.0).
///  * [OverflowBox]
///  * [SizedOverflowBox]
///
/// {@tool snippet}
///
/// For example, by combining a [ClipRect] with an [Align], one can show just
/// the top half of an [Image]:
///
/// ```dart
/// ClipRect(
///   child: Align(
///     alignment: Alignment.topCenter,
///     heightFactor: 0.5,
///     child: Image.network(userAvatarUrl),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRRect], for a clip with rounded corners.
///  * [ClipOval], for an elliptical clip.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipRectModifier extends SingleChildStatelessModifier {
  /// Creates a rectangular clip.
  ///
  /// If [clipper] is null, the clip will match the layout size and position of
  /// the child.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipRectModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.hardEdge,
  });

  /// If non-null, determines which clip to use.
  final CustomClipper<Rect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ClipRect(
      key: modifierKey,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

/// A widget that clips its child using a rounded rectangle.
///
/// By default, [ClipRRect] uses its own bounds as the base rectangle for the
/// clip, but the size and location of the clip can be customized using a custom
/// [clipper].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=eI43jkQkrvs}
///
/// {@tool dartpad}
/// This example shows various [ClipRRect]s applied to containers.
///
/// ** See code in examples/api/lib/widgets/basic/clip_rrect.0.dart **
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Why doesn't my [ClipRRect] child have rounded corners?
///
/// When a [ClipRRect] is bigger than the child it contains, its rounded corners
/// could be drawn in unexpected positions. Make sure that [ClipRRect] and its child
/// have the same bounds (by shrinking the [ClipRRect] with a [FittedBox] or by
/// growing the child).
///
/// {@tool dartpad}
/// This example shows a [ClipRRect] that adds round corners to an image.
///
/// ** See code in examples/api/lib/widgets/basic/clip_rrect.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRect], for more efficient clips without rounded corners.
///  * [ClipOval], for an elliptical clip.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipRRectModifier extends SingleChildStatelessModifier {
  /// Creates a rounded-rectangular clip.
  ///
  /// The [borderRadius] defaults to [BorderRadius.zero], i.e. a rectangle with
  /// right-angled corners.
  ///
  /// If [clipper] is non-null, then [borderRadius] is ignored.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipRRectModifier({
    super.key,
    super.child,
    this.borderRadius = BorderRadius.zero,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  }) : assert(borderRadius != null || clipper != null);

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This value is ignored if [clipper] is non-null.
  final BorderRadiusGeometry? borderRadius;

  /// If non-null, determines which clip to use.
  final CustomClipper<RRect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: child,
    );
  }
}

/// A widget that clips its child using an oval.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=vzWWDO6whIM}
///
/// By default, inscribes an axis-aligned oval into its layout dimensions and
/// prevents its child from painting outside that oval, but the size and
/// location of the clip oval can be customized using a custom [clipper].
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRect], for more efficient clips without rounded corners.
///  * [ClipRRect], for a clip with rounded corners.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipOvalModifier extends SingleChildStatelessModifier {
  /// Creates an oval-shaped clip.
  ///
  /// If [clipper] is null, the oval will be inscribed into the layout size and
  /// position of the child.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipOvalModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  });

  /// If non-null, determines which clip to use.
  ///
  /// The delegate returns a rectangle that describes the axis-aligned
  /// bounding box of the oval. The oval's axes will themselves also
  /// be axis-aligned.
  ///
  /// If the [clipper] delegate is null, then the oval uses the
  /// widget's bounding box (the layout dimensions of the render
  /// object) instead.
  final CustomClipper<Rect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ClipOval(
      key: modifierKey,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

/// A widget that clips its child using a path.
///
/// Calls a callback on a delegate whenever the widget is to be
/// painted. The callback returns a path and the widget prevents the
/// child from painting outside the path.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oAUebVIb-7s}
///
/// Clipping to a path is expensive. Certain shapes have more
/// optimized widgets:
///
///  * To clip to a rectangle, consider [ClipRect].
///  * To clip to an oval or circle, consider [ClipOval].
///  * To clip to a rounded rectangle, consider [ClipRRect].
///
/// To clip to a particular [ShapeBorder], consider using either the
/// [ClipPath.shape] static method or the [ShapeBorderClipper] custom clipper
/// class.
class ClipPathModifier extends SingleChildStatelessModifier {
  /// Creates a path clip.
  ///
  /// If [clipper] is null, the clip will be a rectangle that matches the layout
  /// size and location of the child. However, rather than use this default,
  /// consider using a [ClipRect], which can achieve the same effect more
  /// efficiently.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipPathModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  });

  /// Creates a shape clip.
  ///
  /// Uses a [ShapeBorderClipper] to configure the [ClipPath] to clip to the
  /// given [ShapeBorder].
  static SingleChildModifier shape({
    Key? key,
    required ShapeBorder shape,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return BuilderModifier(
      key: key,
      builder: (BuildContext context, Widget? child) {
        return ClipPath(
          clipper: ShapeBorderClipper(
            shape: shape,
            textDirection: Directionality.maybeOf(context),
          ),
          clipBehavior: clipBehavior,
          child: child,
        );
      },
    );
  }

  /// If non-null, determines which clip to use.
  ///
  /// The default clip, which is used if this property is null, is the
  /// bounding box rectangle of the widget. [ClipRect] is a more
  /// efficient way of obtaining that effect.
  final CustomClipper<Path>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ClipPath(
      key: modifierKey,
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: child,
    );
  }
}

/// A widget representing a physical layer that clips its children to a shape.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=XgUOSS30OQk}
///
/// Physical layers cast shadows based on an [elevation] which is nominally in
/// logical pixels, coming vertically out of the rendering surface.
///
/// For shapes that cannot be expressed as a rectangle with rounded corners use
/// [PhysicalShape].
///
/// See also:
///
///  * [AnimatedPhysicalModel], which animates property changes smoothly over
///    a given duration.
///  * [DecoratedBox], which can apply more arbitrary shadow effects.
///  * [ClipRect], which applies a clip to its child.
class PhysicalModelModifier extends SingleChildStatelessModifier {
  /// Creates a physical model with a rounded-rectangular clip.
  ///
  /// The [color] is required; physical things have a color.
  ///
  /// The [shape], [elevation], [color], [clipBehavior], and [shadowColor] must
  /// not be null. Additionally, the [elevation] must be non-negative.
  const PhysicalModelModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
  }) : assert(elevation >= 0.0);

  /// The type of shape.
  final BoxShape shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This is ignored if the [shape] is not [BoxShape.rectangle].
  final BorderRadius? borderRadius;

  /// The z-coordinate relative to the parent at which to place this physical
  /// object.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The background color.
  final Color color;

  /// The shadow color.
  final Color shadowColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PhysicalModel(
      key: modifierKey,
      color: color,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      child: child,
    );
  }
}

/// A widget representing a physical layer that clips its children to a path.
///
/// Physical layers cast shadows based on an [elevation] which is nominally in
/// logical pixels, coming vertically out of the rendering surface.
///
/// [PhysicalModel] does the same but only supports shapes that can be expressed
/// as rectangles with rounded corners.
///
/// {@tool dartpad}
/// This example shows how to use a [PhysicalShape] on a centered [SizedBox]
/// to clip it to a rounded rectangle using a [ShapeBorderClipper] and give it
/// an orange color along with a shadow.
///
/// ** See code in examples/api/lib/widgets/basic/physical_shape.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ShapeBorderClipper], which converts a [ShapeBorder] to a [CustomClipper], as
///    needed by this widget.
class PhysicalShapeModifier extends SingleChildStatelessModifier {
  /// Creates a physical model with an arbitrary shape clip.
  ///
  /// The [color] is required; physical things have a color.
  ///
  /// The [clipper], [elevation], [color], [clipBehavior], and [shadowColor]
  /// must not be null. Additionally, the [elevation] must be non-negative.
  const PhysicalShapeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.clipper,
    this.clipBehavior = Clip.none,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
  }) : assert(elevation >= 0.0);

  /// Determines which clip to use.
  ///
  /// If the path in question is expressed as a [ShapeBorder] subclass,
  /// consider using the [ShapeBorderClipper] delegate class to adapt the
  /// shape for use with this widget.
  final CustomClipper<Path> clipper;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The z-coordinate relative to the parent at which to place this physical
  /// object.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The background color.
  final Color color;

  /// When elevation is non zero the color to use for the shadow color.
  final Color shadowColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PhysicalShape(
      key: modifierKey,
      clipper: clipper,
      color: color,
      clipBehavior: clipBehavior,
      elevation: elevation,
      shadowColor: shadowColor,
      child: child,
    );
  }
}

// POSITIONING AND SIZING NODES

/// A widget that applies a transformation before painting its child.
///
/// Unlike [RotatedBox], which applies a rotation prior to layout, this object
/// applies its transformation just prior to painting, which means the
/// transformation is not taken into account when calculating how much space
/// this widget's child (and thus this widget) consumes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=9z_YNlRlWfA}
///
/// {@tool snippet}
///
/// This example rotates and skews an orange box containing text, keeping the
/// top right corner pinned to its original position.
///
/// ```dart
/// Container(
///   color: Colors.black,
///   child: Transform(
///     alignment: Alignment.topRight,
///     transform: Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
///     child: Container(
///       padding: const EdgeInsets.all(8.0),
///       color: const Color(0xFFE8581C),
///       child: const Text('Apartment for rent!'),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [RotatedBox], which rotates the child widget during layout, not just
///    during painting.
///  * [FractionalTranslation], which applies a translation to the child
///    that is relative to the child's size.
///  * [FittedBox], which sizes and positions its child widget to fit the parent
///    according to a given [BoxFit] discipline.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class TransformModifier extends SingleChildStatelessModifier {
  /// Creates a widget that transforms its child.
  ///
  /// The [transform] argument must not be null.
  const TransformModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.transform,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
  });

  /// Creates a widget that transforms its child using a rotation around the
  /// center.
  ///
  /// The `angle` argument must not be null. It gives the rotation in clockwise
  /// radians.
  ///
  /// {@tool snippet}
  ///
  /// This example rotates an orange box containing text around its center by
  /// fifteen degrees.
  ///
  /// ```dart
  /// Transform.rotate(
  ///   angle: -math.pi / 12.0,
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFFE8581C),
  ///     child: const Text('Apartment for rent!'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [RotationTransition], which animates changes in rotation smoothly
  ///    over a given duration.
  TransformModifier.rotate({
    super.key,
    super.child,
    super.modifierKey,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
  }) : transform = _computeRotation(angle);

  /// Creates a widget that transforms its child using a translation.
  ///
  /// The `offset` argument must not be null. It specifies the translation.
  ///
  /// {@tool snippet}
  ///
  /// This example shifts the silver-colored child down by fifteen pixels.
  ///
  /// ```dart
  /// Transform.translate(
  ///   offset: const Offset(0.0, 15.0),
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFF7F7F7F),
  ///     child: const Text('Quarter'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  TransformModifier.translate({
    super.key,
    super.child,
    super.modifierKey,
    required Offset offset,
    this.transformHitTests = true,
    this.filterQuality,
  })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
        origin = null,
        alignment = null;

  /// Creates a widget that scales its child along the 2D plane.
  ///
  /// The `scaleX` argument provides the scalar by which to multiply the `x` axis, and the `scaleY` argument provides the scalar by which to multiply the `y` axis. Either may be omitted, in which case that axis defaults to 1.0.
  ///
  /// For convenience, to scale the child uniformly, instead of providing `scaleX` and `scaleY`, the `scale` parameter may be used.
  ///
  /// At least one of `scale`, `scaleX`, and `scaleY` must be non-null. If `scale` is provided, the other two must be null; similarly, if it is not provided, one of the other two must be provided.
  ///
  /// The [alignment] controls the origin of the scale; by default, this is
  /// the center of the box.
  ///
  /// {@tool snippet}
  ///
  /// This example shrinks an orange box containing text such that each dimension
  /// is half the size it would otherwise be.
  ///
  /// ```dart
  /// Transform.scale(
  ///   scale: 0.5,
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFFE8581C),
  ///     child: const Text('Bad Idea Bears'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [ScaleTransition], which animates changes in scale smoothly
  ///    over a given duration.
  TransformModifier.scale({
    super.key,
    super.child,
    super.modifierKey,
    double? scale,
    double? scaleX,
    double? scaleY,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
  })  : assert(!(scale == null && scaleX == null && scaleY == null),
            "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null"),
        assert(scale == null || (scaleX == null && scaleY == null),
            "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null"),
        transform = Matrix4.diagonal3Values(scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0);

  static Matrix4 _computeRotation(double radians) {
    assert(radians.isFinite, 'Cannot compute the rotation matrix for a non-finite angle: $radians');
    if (radians == 0.0) {
      return Matrix4.identity();
    }
    final double sin = math.sin(radians);
    if (sin == 1.0) {
      return _createZRotation(1.0, 0.0);
    }
    if (sin == -1.0) {
      return _createZRotation(-1.0, 0.0);
    }
    final double cos = math.cos(radians);
    if (cos == -1.0) {
      return _createZRotation(0.0, -1.0);
    }
    return _createZRotation(sin, cos);
  }

  static Matrix4 _createZRotation(double sin, double cos) {
    final Matrix4 result = Matrix4.zero();
    result.storage[0] = cos;
    result.storage[1] = sin;
    result.storage[4] = -sin;
    result.storage[5] = cos;
    result.storage[10] = 1.0;
    result.storage[15] = 1.0;
    return result;
  }

  /// The matrix to transform the child by during painting.
  final Matrix4 transform;

  /// The origin of the coordinate system (relative to the upper left corner of
  /// this render object) in which to apply the matrix.
  ///
  /// Setting an origin is equivalent to conjugating the transform matrix by a
  /// translation. This property is provided just for convenience.
  final Offset? origin;

  /// The alignment of the origin, relative to the size of the box.
  ///
  /// This is equivalent to setting an origin based on the size of the box.
  /// If it is specified at the same time as the [origin], both are applied.
  ///
  /// An [AlignmentDirectional.centerStart] value is the same as an [Alignment]
  /// whose [Alignment.x] value is `-1.0` if [Directionality.of] returns
  /// [TextDirection.ltr], and `1.0` if [Directionality.of] returns
  /// [TextDirection.rtl].	 Similarly [AlignmentDirectional.centerEnd] is the
  /// same as an [Alignment] whose [Alignment.x] value is `1.0` if
  /// [Directionality.of] returns	 [TextDirection.ltr], and `-1.0` if
  /// [Directionality.of] returns [TextDirection.rtl].
  final AlignmentGeometry? alignment;

  /// Whether to apply the transformation when performing hit tests.
  final bool transformHitTests;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// {@template flutter.widgets.Transform.optional.FilterQuality}
  /// The transform will be applied by re-rendering the child if [filterQuality] is null,
  /// otherwise it controls the quality of an [ImageFilter.matrix] applied to a bitmap
  /// rendering of the child.
  /// {@endtemplate}
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Transform(
      key: modifierKey,
      transform: transform,
      alignment: alignment,
      filterQuality: filterQuality,
      origin: origin,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// A widget that can be targeted by a [CompositedTransformFollower].
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// updates the [link] object so that any [CompositedTransformFollower] widgets
/// that are subsequently composited in the same frame and were given the same
/// [LayerLink] can position themselves at the same screen location.
///
/// A single [CompositedTransformTarget] can be followed by multiple
/// [CompositedTransformFollower] widgets.
///
/// The [CompositedTransformTarget] must come earlier in the paint order than
/// any linked [CompositedTransformFollower]s.
///
/// See also:
///
///  * [CompositedTransformFollower], the widget that can target this one.
///  * [LeaderLayer], the layer that implements this widget's logic.
class CompositedTransformTargetModifier extends SingleChildStatelessModifier {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null, and must not be currently being used
  /// by any other [CompositedTransformTarget] object that is in the tree.
  const CompositedTransformTargetModifier({
    super.key,
    super.child,
    required this.link,
  });

  /// The link object that connects this [CompositedTransformTarget] with one or
  /// more [CompositedTransformFollower]s.
  ///
  /// This property must not be null. The object must not be associated with
  /// another [CompositedTransformTarget] that is also being painted.
  final LayerLink link;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CompositedTransformTarget(
      link: link,
      child: child,
    );
  }
}

/// A widget that follows a [CompositedTransformTarget].
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// applies a transformation that brings [targetAnchor] of the linked
/// [CompositedTransformTarget] and [followerAnchor] of this widget together.
/// The two anchor points will have the same global coordinates, unless [offset]
/// is not [Offset.zero], in which case [followerAnchor] will be offset by
/// [offset] in the linked [CompositedTransformTarget]'s coordinate space.
///
/// The [LayerLink] object used as the [link] must be the same object as that
/// provided to the matching [CompositedTransformTarget].
///
/// The [CompositedTransformTarget] must come earlier in the paint order than
/// this [CompositedTransformFollower].
///
/// Hit testing on descendants of this widget will only work if the target
/// position is within the box that this widget's parent considers to be
/// hittable. If the parent covers the screen, this is trivially achievable, so
/// this widget is usually used as the root of an [OverlayEntry] in an app-wide
/// [Overlay] (e.g. as created by the [MaterialApp] widget's [Navigator]).
///
/// See also:
///
///  * [CompositedTransformTarget], the widget that this widget can target.
///  * [FollowerLayer], the layer that implements this widget's logic.
///  * [Transform], which applies an arbitrary transform to a child.
class CompositedTransformFollowerModifier extends SingleChildStatelessModifier {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null. If it was also provided to a
  /// [CompositedTransformTarget], that widget must come earlier in the paint
  /// order.
  ///
  /// The [showWhenUnlinked] and [offset] properties must also not be null.
  const CompositedTransformFollowerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.link,
    this.showWhenUnlinked = true,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
  });

  /// The link object that connects this [CompositedTransformFollower] with a
  /// [CompositedTransformTarget].
  ///
  /// This property must not be null.
  final LayerLink link;

  /// Whether to show the widget's contents when there is no corresponding
  /// [CompositedTransformTarget] with the same [link].
  ///
  /// When the widget is linked, the child is positioned such that it has the
  /// same global position as the linked [CompositedTransformTarget].
  ///
  /// When the widget is not linked, then: if [showWhenUnlinked] is true, the
  /// child is visible and not repositioned; if it is false, then child is
  /// hidden.
  final bool showWhenUnlinked;

  /// The anchor point on the linked [CompositedTransformTarget] that
  /// [followerAnchor] will line up with.
  ///
  /// {@template flutter.widgets.CompositedTransformFollower.targetAnchor}
  /// For example, when [targetAnchor] and [followerAnchor] are both
  /// [Alignment.topLeft], this widget will be top left aligned with the linked
  /// [CompositedTransformTarget]. When [targetAnchor] is
  /// [Alignment.bottomLeft] and [followerAnchor] is [Alignment.topLeft], this
  /// widget will be left aligned with the linked [CompositedTransformTarget],
  /// and its top edge will line up with the [CompositedTransformTarget]'s
  /// bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment targetAnchor;

  /// The anchor point on this widget that will line up with [followerAnchor] on
  /// the linked [CompositedTransformTarget].
  ///
  /// {@macro flutter.widgets.CompositedTransformFollower.targetAnchor}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment followerAnchor;

  /// The additional offset to apply to the [targetAnchor] of the linked
  /// [CompositedTransformTarget] to obtain this widget's [followerAnchor]
  /// position.
  final Offset offset;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CompositedTransformFollower(
      key: modifierKey,
      link: link,
      followerAnchor: followerAnchor,
      offset: offset,
      showWhenUnlinked: showWhenUnlinked,
      targetAnchor: targetAnchor,
      child: child,
    );
  }
}

/// Scales and positions its child within itself according to [fit].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=T4Uehk3_wlY}
///
/// {@tool dartpad}
/// In this example, the image is stretched to fill the entire [Container], which would
/// not happen normally without using FittedBox.
///
/// ** See code in examples/api/lib/widgets/basic/fitted_box.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Transform], which applies an arbitrary transform to its child widget at
///    paint time.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FittedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that scales and positions its child within itself according to [fit].
  ///
  /// The [fit] and [alignment] arguments must not be null.
  const FittedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
  });

  /// How to inscribe the child into the space allocated during layout.
  final BoxFit fit;

  /// How to align the child within its parent's bounds.
  ///
  /// An alignment of (-1.0, -1.0) aligns the child to the top-left corner of its
  /// parent's bounds. An alignment of (1.0, 0.0) aligns the child to the middle
  /// of the right edge of its parent's bounds.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FittedBox(
      key: modifierKey,
      alignment: alignment,
      clipBehavior: clipBehavior,
      fit: fit,
      child: child,
    );
  }
}

/// Applies a translation transformation before painting its child.
///
/// The translation is expressed as a [Offset] scaled to the child's size. For
/// example, an [Offset] with a `dx` of 0.25 will result in a horizontal
/// translation of one quarter the width of the child.
///
/// Hit tests will only be detected inside the bounds of the
/// [FractionalTranslation], even if the contents are offset such that
/// they overflow.
///
/// See also:
///
///  * [Transform], which applies an arbitrary transform to its child widget at
///    paint time.
///  * [Transform.translate], which applies an absolute offset translation
///    transformation instead of an offset scaled to the child.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FractionalTranslationModifier extends SingleChildStatelessModifier {
  /// Creates a widget that translates its child's painting.
  ///
  /// The [translation] argument must not be null.
  const FractionalTranslationModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.translation,
    this.transformHitTests = true,
  });

  /// The translation to apply to the child, scaled to the child's size.
  ///
  /// For example, an [Offset] with a `dx` of 0.25 will result in a horizontal
  /// translation of one quarter the width of the child.
  final Offset translation;

  /// Whether to apply the translation when performing hit tests.
  final bool transformHitTests;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FractionalTranslation(
      key: modifierKey,
      translation: translation,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// A widget that rotates its child by a integral number of quarter turns.
///
/// Unlike [Transform], which applies a transform just prior to painting,
/// this object applies its rotation prior to layout, which means the entire
/// rotated box consumes only as much space as required by the rotated child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=BFE6_UglLfQ}
///
/// {@tool snippet}
///
/// This snippet rotates the child (some [Text]) so that it renders from bottom
/// to top, like an axis label on a graph:
///
/// ```dart
/// const RotatedBox(
///   quarterTurns: 3,
///   child: Text('Hello World!'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Transform], which is a paint effect that allows you to apply an
///    arbitrary transform to a child.
///  * [Transform.rotate], which applies a rotation paint effect.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class RotatedBoxModifier extends SingleChildStatelessModifier {
  /// A widget that rotates its child.
  ///
  /// The [quarterTurns] argument must not be null.
  const RotatedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.quarterTurns,
  });

  /// The number of clockwise quarter turns the child should be rotated.
  final int quarterTurns;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RotatedBox(
      key: modifierKey,
      quarterTurns: quarterTurns,
      child: child,
    );
  }
}

/// A widget that insets its child by the given padding.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oD5RtLhhubg}
///
/// When passing layout constraints to its child, padding shrinks the
/// constraints by the given padding, causing the child to layout at a smaller
/// size. Padding then sizes itself to its child's size, inflated by the
/// padding, effectively creating empty space around the child.
///
/// {@tool snippet}
///
/// This snippet creates "Hello World!" [Text] inside a [Card] that is indented
/// by sixteen pixels in each direction.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/padding.png)
///
/// ```dart
/// const Card(
///   child: Padding(
///     padding: EdgeInsets.all(16.0),
///     child: Text('Hello World!'),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Design discussion
///
/// ### Why use a [Padding] widget rather than a [Container] with a [Container.padding] property?
///
/// There isn't really any difference between the two. If you supply a
/// [Container.padding] argument, [Container] simply builds a [Padding] widget
/// for you.
///
/// [Container] doesn't implement its properties directly. Instead, [Container]
/// combines a number of simpler widgets together into a convenient package. For
/// example, the [Container.padding] property causes the container to build a
/// [Padding] widget and the [Container.decoration] property causes the
/// container to build a [DecoratedBox] widget. If you find [Container]
/// convenient, feel free to use it. If not, feel free to build these simpler
/// widgets in whatever combination meets your needs.
///
/// In fact, the majority of widgets in Flutter are simply combinations of other
/// simpler widgets. Composition, rather than inheritance, is the primary
/// mechanism for building up widgets.
///
/// See also:
///
///  * [AnimatedPadding], which animates changes in [padding] over a given
///    duration.
///  * [EdgeInsets], the class that is used to describe the padding dimensions.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class PaddingModifier extends SingleChildStatelessModifier {
  /// Creates a widget that insets its child.
  ///
  /// The [padding] argument must not be null.
  const PaddingModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.padding,
  });

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Padding(
      key: modifierKey,
      padding: padding,
      child: child,
    );
  }
}

/// A widget that aligns its child within itself and optionally sizes itself
/// based on the child's size.
///
/// For example, to align a box at the bottom right, you would pass this box a
/// tight constraint that is bigger than the child's natural size,
/// with an alignment of [Alignment.bottomRight].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=g2E7yl3MwMk}
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// ## How it works
///
/// The [alignment] property describes a point in the `child`'s coordinate system
/// and a different point in the coordinate system of this widget. The [Align]
/// widget positions the `child` such that both points are lined up on top of
/// each other.
///
/// {@tool snippet}
/// The [Align] widget in this example uses one of the defined constants from
/// [Alignment], [Alignment.topRight]. This places the [FlutterLogo] in the top
/// right corner of the parent blue [Container].
///
/// ![A blue square container with the Flutter logo in the top right corner.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_constant.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment.topRight,
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// The [Alignment] used in the following example defines a single point:
///
///   * (0.2 * width of [FlutterLogo]/2 + width of [FlutterLogo]/2, 0.6 * height
///   of [FlutterLogo]/2 + height of [FlutterLogo]/2) = (36.0, 48.0).
///
/// The [Alignment] class uses a coordinate system with an origin in the center
/// of the [Container], as shown with the [Icon] above. [Align] will place the
/// [FlutterLogo] at (36.0, 48.0) according to this coordinate system.
///
/// ![A blue square container with the Flutter logo positioned according to the
/// Alignment specified above. A point is marked at the center of the container
/// for the origin of the Alignment coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_alignment.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// The [FractionalOffset] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo], 0.6 * height of [FlutterLogo]) = (12.0, 36.0)
///     in the coordinate system of the blue container.
///   * (0.2 * width of [Align], 0.6 * height of [Align]) = (24.0, 72.0) in the
///     coordinate system of the [Align] widget.
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (24.0, 72.0) - (12.0, 36.0) = (12.0, 36.0) from the top left of
/// the [Align] widget.
///
/// The [FractionalOffset] class uses a coordinate system with an origin in the top-left
/// corner of the [Container] in difference to the center-oriented system used in
/// the example above with [Alignment].
///
/// ![A blue square container with the Flutter logo positioned according to the
/// FractionalOffset specified above. A point is marked at the top left corner
/// of the container for the origin of the FractionalOffset coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_fractional_offset.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: FractionalOffset(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which animates changes in [alignment] smoothly over a
///    given duration.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [Center], which is the same as [Align] but with the [alignment] always
///    set to [Alignment.center].
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class AlignModifier extends SingleChildStatelessModifier {
  /// Creates an alignment widget.
  ///
  /// The alignment defaults to [Alignment.center].
  const AlignModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0);

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

  /// If non-null, sets its width to the child's width multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? widthFactor;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? heightFactor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Align(
      key: modifierKey,
      alignment: alignment,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: child,
    );
  }
}

/// A widget that centers its child within itself.
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// See also:
///
///  * [Align], which lets you arbitrarily position a child within itself,
///    rather than just centering it.
///  * [Row], a widget that displays its children in a horizontal array.
///  * [Column], a widget that displays its children in a vertical array.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class CenterModifier extends AlignModifier {
  /// Creates a widget that centers its child.
  const CenterModifier({
    super.key,
    Key? modifiedKey,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(
          modifierKey: modifiedKey,
          alignment: Alignment.center,
        );
}

/// A widget that defers the layout of its single child to a delegate.
///
/// The delegate can determine the layout constraints for the child and can
/// decide where to position the child. The delegate can also determine the size
/// of the parent, but the size of the parent cannot depend on the size of the
/// child.
///
/// See also:
///
///  * [SingleChildLayoutDelegate], which controls the layout of the child.
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its own
///    size and positions the child according to an [Alignment] value.
///  * [CustomMultiChildLayout], which uses a delegate to position multiple
///    children.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class CustomSingleChildLayoutModifier extends SingleChildStatelessModifier {
  /// Creates a custom single child layout.
  ///
  /// The [delegate] argument must not be null.
  const CustomSingleChildLayoutModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.delegate,
  });

  /// The delegate that controls the layout of the child.
  final SingleChildLayoutDelegate delegate;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CustomSingleChildLayout(
      key: modifierKey,
      delegate: delegate,
      child: child,
    );
  }
}

/// Metadata for identifying children in a [CustomMultiChildLayout].
///
/// The [MultiChildLayoutDelegate.hasChild],
/// [MultiChildLayoutDelegate.layoutChild], and
/// [MultiChildLayoutDelegate.positionChild] methods use these identifiers.
class LayoutIdModifier extends SingleChildStatelessModifier {
  /// Marks a child with a layout identifier.
  ///
  /// Both the child and the id arguments must not be null.
  const LayoutIdModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.id,
  });

  /// An object representing the identity of this child.
  ///
  /// The [id] needs to be unique among the children that the
  /// [CustomMultiChildLayout] manages.
  final Object id;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return LayoutId(
      key: modifierKey,
      id: id,
      child: child!,
    );
  }
}

/// A box with a specified size.
///
/// If given a child, this widget forces it to have a specific width and/or height.
/// These values will be ignored if this widget's parent does not permit them.
/// For example, this happens if the parent is the screen (forces the child to
/// be the same size as the parent), or another [SizedBox] (forces its child to
/// have a specific width and/or height). This can be remedied by wrapping the
/// child [SizedBox] in a widget that does permit it to be any size up to the
/// size of the parent, such as [Center] or [Align].
///
/// If either the width or height is null, this widget will try to size itself to
/// match the child's size in that dimension. If the child's size depends on the
/// size of its parent, the height and width must be provided.
///
/// If not given a child, [SizedBox] will try to size itself as close to the
/// specified height and width as possible given the parent's constraints. If
/// [height] or [width] is null or unspecified, it will be treated as zero.
///
/// The [SizedBox.expand] constructor can be used to make a [SizedBox] that
/// sizes itself to fit the parent. It is equivalent to setting [width] and
/// [height] to [double.infinity].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EHPu_DzRfqA}
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) have the
/// exact size 200x300, parental constraints permitting:
///
/// ```dart
/// const SizedBox(
///   width: 200.0,
///   height: 300.0,
///   child: Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ConstrainedBox], a more generic version of this class that takes
///    arbitrary [BoxConstraints] instead of an explicit width and height.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [FractionallySizedBox], a widget that sizes its child to a fraction of
///    the total available space.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * [FittedBox], which sizes and positions its child widget to fit the parent
///    according to a given [BoxFit] discipline.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///  * [Understanding constraints](https://flutter.dev/docs/development/ui/layout/constraints),
///    an in-depth article about layout in Flutter.
class SizedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a fixed size box. The [width] and [height] parameters can be null
  /// to indicate that the size of the box should not be constrained in
  /// the corresponding dimension.
  const SizedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.width,
    this.height,
  });

  /// Creates a box that will become as large as its parent allows.
  const SizedBoxModifier.expand({
    super.key,
    super.child,
    super.modifierKey,
  })  : width = double.infinity,
        height = double.infinity;

  /// Creates a box that will become as small as its parent allows.
  const SizedBoxModifier.shrink({
    super.key,
    super.child,
    super.modifierKey,
  })  : width = 0.0,
        height = 0.0;

  /// Creates a box with the specified size.
  SizedBoxModifier.fromSize({super.key, super.child, super.modifierKey, Size? size})
      : width = size?.width,
        height = size?.height;

  /// Creates a box whose [width] and [height] are equal.
  const SizedBoxModifier.square({super.key, super.child, super.modifierKey, double? dimension})
      : width = dimension,
        height = dimension;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizedBox(height: height, width: width, child: child);
  }
}

/// A widget that imposes additional constraints on its child.
///
/// For example, if you wanted [child] to have a minimum height of 50.0 logical
/// pixels, you could use `const BoxConstraints(minHeight: 50.0)` as the
/// [constraints].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=o2KveVr7adg}
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) fill the
/// parent, by applying [BoxConstraints.expand] constraints:
///
/// ```dart
/// ConstrainedBox(
///   constraints: const BoxConstraints.expand(),
///   child: const Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// The same behavior can be obtained using the [SizedBox.expand] widget.
///
/// See also:
///
///  * [BoxConstraints], the class that describes constraints.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class ConstrainedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that imposes additional constraints on its child.
  ///
  /// The [constraints] argument must not be null.
  ConstrainedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.constraints,
  }) : assert(constraints.debugAssertIsValid());

  /// The additional constraints to impose on the child.
  final BoxConstraints constraints;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ConstrainedBox(
      key: modifierKey,
      constraints: constraints,
      child: child,
    );
  }
}

/// A container widget that applies an arbitrary transform to its constraints,
/// and sizes its child using the resulting [BoxConstraints], treating any
/// overflow as error.
///
/// This container sizes its child using a [BoxConstraints] created by applying
/// [constraintsTransform] to its own constraints. This container will then
/// attempt to adopt the same size, within the limits of its own constraints. If
/// it ends up with a different size, it will align the child based on
/// [alignment]. If the container cannot expand enough to accommodate the entire
/// child, the child will be clipped if [clipBehavior] is not [Clip.none].
///
/// In debug mode, if the child overflows the container, a warning will be
/// printed on the console, and black and yellow striped areas will appear where
/// the overflow occurs.
///
/// When [child] is null, this widget becomes as small as possible and never
/// overflows
///
/// This widget can be used to ensure some of [child]'s natural dimensions are
/// honored, and get an early warning otherwise during development. For
/// instance, if [child] requires a minimum height to fully display its content,
/// [constraintsTransform] can be set to [maxHeightUnconstrained], so that if
/// the parent [RenderObject] fails to provide enough vertical space, a warning
/// will be displayed in debug mode, while still allowing [child] to grow
/// vertically:
///
/// {@tool snippet}
/// In the following snippet, the [Card] is guaranteed to be at least as tall as
/// its "natural" height. Unlike [UnconstrainedBox], it will become taller if
/// its "natural" height is smaller than 40 px. If the [Container] isn't high
/// enough to show the full content of the [Card], in debug mode a warning will
/// be given.
///
/// ```dart
/// Container(
///   constraints: const BoxConstraints(minHeight: 40, maxHeight: 100),
///   alignment: Alignment.center,
///   child: const ConstraintsTransformBox(
///     constraintsTransform: ConstraintsTransformBox.maxHeightUnconstrained,
///     child: Card(child: Text('Hello World!')),
///   )
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ConstrainedBox], which renders a box which imposes constraints
///    on its child.
///  * [OverflowBox], a widget that imposes additional constraints on its child,
///    and allows the child to overflow itself.
///  * [UnconstrainedBox] which allows its children to render themselves
///    unconstrained, expands to fit them, and considers overflow to be an error.
class ConstraintsTransformBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that uses a function to transform the constraints it
  /// passes to its child. If the child overflows the parent's constraints, a
  /// warning will be given in debug mode.
  ///
  /// The `debugTransformType` argument adds a debug label to this widget.
  ///
  /// The `alignment`, `clipBehavior` and `constraintsTransform` arguments must
  /// not be null.
  const ConstraintsTransformBoxModifier({
    super.key,
    super.child,
    this.textDirection,
    this.alignment = Alignment.center,
    required this.constraintsTransform,
    this.clipBehavior = Clip.none,
    String debugTransformType = '',
  }) : _debugTransformType = debugTransformType;

  /// The text direction to use when interpreting the [alignment] if it is an
  /// [AlignmentDirectional].
  ///
  /// Defaults to null, in which case [Directionality.maybeOf] is used to determine
  /// the text direction.
  final TextDirection? textDirection;

  /// The alignment to use when laying out the child, if it has a different size
  /// than this widget.
  ///
  /// If this is an [AlignmentDirectional], then [textDirection] must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [Alignment] for non-[Directionality]-aware alignments.
  ///  * [AlignmentDirectional] for [Directionality]-aware alignments.
  final AlignmentGeometry alignment;

  /// {@template flutter.widgets.constraintsTransform}
  /// The function used to transform the incoming [BoxConstraints], to size
  /// [child].
  ///
  /// The function must return a [BoxConstraints] that is
  /// [BoxConstraints.isNormalized].
  ///
  /// See [ConstraintsTransformBox] for predefined common
  /// [BoxConstraintsTransform]s.
  /// {@endtemplate}
  final BoxConstraintsTransform constraintsTransform;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  final String _debugTransformType;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ConstraintsTransformBox(
      constraintsTransform: constraintsTransform,
      alignment: alignment,
      clipBehavior: clipBehavior,
      debugTransformType: _debugTransformType,
      textDirection: textDirection,
      child: child,
    );
  }
}

/// A widget that imposes no constraints on its child, allowing it to render
/// at its "natural" size.
///
/// This allows a child to render at the size it would render if it were alone
/// on an infinite canvas with no constraints. This container will then attempt
/// to adopt the same size, within the limits of its own constraints. If it ends
/// up with a different size, it will align the child based on [alignment].
/// If the box cannot expand enough to accommodate the entire child, the
/// child will be clipped.
///
/// In debug mode, if the child overflows the container, a warning will be
/// printed on the console, and black and yellow striped areas will appear where
/// the overflow occurs.
///
/// See also:
///
///  * [ConstrainedBox], for a box which imposes constraints on its child.
///  * [Align], which loosens the constraints given to the child rather than
///    removing them entirely.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * [OverflowBox], a widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow
///    the parent.
///  * [ConstraintsTransformBox], a widget that sizes its child using a
///    transformed [BoxConstraints], and shows a warning if the child overflows
///    in debug mode.
class UnconstrainedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that imposes no constraints on its child, allowing it to
  /// render at its "natural" size. If the child overflows the parents
  /// constraints, a warning will be given in debug mode.
  const UnconstrainedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.textDirection,
    this.alignment = Alignment.center,
    this.constrainedAxis,
    this.clipBehavior = Clip.none,
  });

  /// The text direction to use when interpreting the [alignment] if it is an
  /// [AlignmentDirectional].
  final TextDirection? textDirection;

  /// The alignment to use when laying out the child.
  ///
  /// If this is an [AlignmentDirectional], then [textDirection] must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [Alignment] for non-[Directionality]-aware alignments.
  ///  * [AlignmentDirectional] for [Directionality]-aware alignments.
  final AlignmentGeometry alignment;

  /// The axis to retain constraints on, if any.
  ///
  /// If not set, or set to null (the default), neither axis will retain its
  /// constraints. If set to [Axis.vertical], then vertical constraints will
  /// be retained, and if set to [Axis.horizontal], then horizontal constraints
  /// will be retained.
  final Axis? constrainedAxis;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return UnconstrainedBox(
      key: modifierKey,
      alignment: alignment,
      clipBehavior: clipBehavior,
      textDirection: textDirection,
      constrainedAxis: constrainedAxis,
      child: child,
    );
  }
}

/// A widget that sizes its child to a fraction of the total available space.
/// For more details about the layout algorithm, see
/// [RenderFractionallySizedOverflowBox].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PEsY654EGZ0}
///
/// {@tool dartpad}
/// This sample shows a [FractionallySizedBox] whose one child is 50% of
/// the box's size per the width and height factor parameters, and centered
/// within that box by the alignment parameter.
///
/// ** See code in examples/api/lib/widgets/basic/fractionally_sized_box.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [OverflowBox], a widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FractionallySizedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that sizes its child to a fraction of the total available space.
  ///
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const FractionallySizedBoxModifier({
    super.key,
    super.child,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0);

  /// {@template flutter.widgets.basic.fractionallySizedBox.widthFactor}
  /// If non-null, the fraction of the incoming width given to the child.
  ///
  /// If non-null, the child is given a tight width constraint that is the max
  /// incoming width constraint multiplied by this factor.
  ///
  /// If null, the incoming width constraints are passed to the child
  /// unmodified.
  /// {@endtemplate}
  final double? widthFactor;

  /// {@template flutter.widgets.basic.fractionallySizedBox.heightFactor}
  /// If non-null, the fraction of the incoming height given to the child.
  ///
  /// If non-null, the child is given a tight height constraint that is the max
  /// incoming height constraint multiplied by this factor.
  ///
  /// If null, the incoming height constraints are passed to the child
  /// unmodified.
  /// {@endtemplate}
  final double? heightFactor;

  /// {@template flutter.widgets.basic.fractionallySizedBox.alignment}
  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  /// {@endtemplate}
  final AlignmentGeometry alignment;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FractionallySizedBox(
      alignment: alignment,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: child,
    );
  }
}

/// A box that limits its size only when it's unconstrained.
///
/// If this widget's maximum width is unconstrained then its child's width is
/// limited to [maxWidth]. Similarly, if this widget's maximum height is
/// unconstrained then its child's height is limited to [maxHeight].
///
/// This has the effect of giving the child a natural dimension in unbounded
/// environments. For example, by providing a [maxHeight] to a widget that
/// normally tries to be as big as possible, the widget will normally size
/// itself to fit its parent, but when placed in a vertical list, it will take
/// on the given height.
///
/// This is useful when composing widgets that normally try to match their
/// parents' size, so that they behave reasonably in lists (which are
/// unbounded).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=uVki2CIzBTs}
///
/// See also:
///
///  * [ConstrainedBox], which applies its constraints in all cases, not just
///    when the incoming constraints are unbounded.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class LimitedBoxModifier extends SingleChildStatelessModifier {
  /// Creates a box that limits its size only when it's unconstrained.
  ///
  /// The [maxWidth] and [maxHeight] arguments must not be null and must not be
  /// negative.
  const LimitedBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  })  : assert(maxWidth >= 0.0),
        assert(maxHeight >= 0.0);

  /// The maximum width limit to apply in the absence of a
  /// [BoxConstraints.maxWidth] constraint.
  final double maxWidth;

  /// The maximum height limit to apply in the absence of a
  /// [BoxConstraints.maxHeight] constraint.
  final double maxHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LimitedBox(
      key: modifierKey,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      child: child,
    );
  }
}

/// A widget that imposes different constraints on its child than it gets
/// from its parent, possibly allowing the child to overflow the parent.
///
/// See also:
///
///  * [RenderConstrainedOverflowBox] for details about how [OverflowBox] is
///    rendered.
///  * [SizedOverflowBox], a widget that is a specific size but passes its
///    original constraints through to its child, which may then overflow.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], a box with a specified size.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class OverflowBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that lets its child overflow itself.
  const OverflowBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The minimum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minWidth;

  /// The maximum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxWidth;

  /// The minimum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minHeight;

  /// The maximum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OverflowBox(
      key: modifierKey,
      alignment: alignment,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      minHeight: minHeight,
      minWidth: minWidth,
      child: child,
    );
  }
}

/// A widget that is a specific size but passes its original constraints
/// through to its child, which may then overflow.
///
/// See also:
///
///  * [OverflowBox], A widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class SizedOverflowBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget of a given size that lets its child overflow.
  ///
  /// The [size] argument must not be null.
  const SizedOverflowBoxModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.size,
    this.alignment = Alignment.center,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The size this widget should attempt to be.
  final Size size;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizedOverflowBoxModifier(
      key: modifierKey,
      size: size,
      alignment: alignment,
      child: child,
    );
  }
}

/// A widget that lays the child out as if it was in the tree, but without
/// painting anything, without making the child available for hit testing, and
/// without taking any room in the parent.
///
/// Offstage children are still active: they can receive focus and have keyboard
/// input directed to them.
///
/// Animations continue to run in offstage children, and therefore use battery
/// and CPU time, regardless of whether the animations end up being visible.
///
/// [Offstage] can be used to measure the dimensions of a widget without
/// bringing it on screen (yet). To hide a widget from view while it is not
/// needed, prefer removing the widget from the tree entirely rather than
/// keeping it alive in an [Offstage] subtree.
///
/// {@tool dartpad}
/// This example shows a [FlutterLogo] widget when the `_offstage` member field
/// is false, and hides it without any room in the parent when it is true. When
/// offstage, this app displays a button to get the logo size, which will be
/// displayed in a [SnackBar].
///
/// ** See code in examples/api/lib/widgets/basic/offstage.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Visibility], which can hide a child more efficiently (albeit less
///    subtly).
///  * [TickerMode], which can be used to disable animations in a subtree.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class OffstageModifier extends SingleChildStatelessModifier {
  /// Creates a widget that visually hides its child.
  const OffstageModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.offstage = true,
  });

  /// Whether the child is hidden from the rest of the tree.
  ///
  /// If true, the child is laid out as if it was in the tree, but without
  /// painting anything, without making the child available for hit testing, and
  /// without taking any room in the parent.
  ///
  /// Offstage children are still active: they can receive focus and have keyboard
  /// input directed to them.
  ///
  /// Animations continue to run in offstage children, and therefore use battery
  /// and CPU time, regardless of whether the animations end up being visible.
  ///
  /// If false, the child is included in the tree as normal.
  final bool offstage;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Offstage(
      key: modifierKey,
      offstage: offstage,
      child: child,
    );
  }
}

/// A widget that attempts to size the child to a specific aspect ratio.
///
/// The widget first tries the largest width permitted by the layout
/// constraints. The height of the widget is determined by applying the
/// given aspect ratio to the width, expressed as a ratio of width to height.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=XcnP3_mO_Ms}
///
/// For example, a 16:9 width:height aspect ratio would have a value of
/// 16.0/9.0. If the maximum width is infinite, the initial width is determined
/// by applying the aspect ratio to the maximum height.
///
/// {@tool dartpad}
/// This examples shows how AspectRatio sets width when its parent's width
/// constraint is infinite. Since its parent's allowed height is a fixed value,
/// the actual width is determined via the given AspectRatio.
///
/// Since the height is fixed at 100.0 in this example and the aspect ratio is
/// set to 16 / 9, the width should then be 100.0 / 9 * 16.
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.0.dart **
/// {@end-tool}
///
/// Now consider a second example, this time with an aspect ratio of 2.0 and
/// layout constraints that require the width to be between 0.0 and 100.0 and
/// the height to be between 0.0 and 100.0. We'll select a width of 100.0 (the
/// biggest allowed) and a height of 50.0 (to match the aspect ratio).
///
/// {@tool dartpad}
///
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.1.dart **
/// {@end-tool}
///
/// In that same situation, if the aspect ratio is 0.5, we'll also select a
/// width of 100.0 (still the biggest allowed) and we'll attempt to use a height
/// of 200.0. Unfortunately, that violates the constraints because the child can
/// be at most 100.0 pixels tall. The widget will then take that value
/// and apply the aspect ratio again to obtain a width of 50.0. That width is
/// permitted by the constraints and the child receives a width of 50.0 and a
/// height of 100.0. If the width were not permitted, the widget would
/// continue iterating through the constraints. If the widget does not
/// find a feasible size after consulting each constraint, the widget
/// will eventually select a size for the child that meets the layout
/// constraints but fails to meet the aspect ratio constraints.
///
/// {@tool dartpad}
///
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself and optionally
///    sizes itself based on the child's size.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class AspectRatioModifier extends SingleChildStatelessModifier {
  /// Creates a widget with a specific aspect ratio.
  ///
  /// The [aspectRatio] argument must be a finite number greater than zero.
  const AspectRatioModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.aspectRatio,
  }) : assert(aspectRatio > 0.0);

  /// The aspect ratio to attempt to use.
  ///
  /// The aspect ratio is expressed as a ratio of width to height. For example,
  /// a 16:9 width:height aspect ratio would have a value of 16.0/9.0.
  final double aspectRatio;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AspectRatio(
      key: modifierKey,
      aspectRatio: aspectRatio,
      child: child,
    );
  }
}

/// A widget that sizes its child to the child's maximum intrinsic width.
///
/// This class is useful, for example, when unlimited width is available and
/// you would like a child that would otherwise attempt to expand infinitely to
/// instead size itself to a more reasonable width.
///
/// The constraints that this widget passes to its child will adhere to the
/// parent's constraints, so if the constraints are not large enough to satisfy
/// the child's maximum intrinsic width, then the child will get less width
/// than it otherwise would. Likewise, if the minimum width constraint is
/// larger than the child's maximum intrinsic width, the child will be given
/// more width than it otherwise would.
///
/// If [stepWidth] is non-null, the child's width will be snapped to a multiple
/// of the [stepWidth]. Similarly, if [stepHeight] is non-null, the child's
/// height will be snapped to a multiple of the [stepHeight].
///
/// This class is relatively expensive, because it adds a speculative layout
/// pass before the final layout phase. Avoid using it where possible. In the
/// worst case, this widget can result in a layout that is O(N²) in the depth of
/// the tree.
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself. This can be used
///    to loosen the constraints passed to the [RenderIntrinsicWidth],
///    allowing the [RenderIntrinsicWidth]'s child to be smaller than that of
///    its parent.
///  * [Row], which when used with [CrossAxisAlignment.stretch] can be used
///    to loosen just the width constraints that are passed to the
///    [RenderIntrinsicWidth], allowing the [RenderIntrinsicWidth]'s child's
///    width to be smaller than that of its parent.
///  * [The catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IntrinsicWidthModifier extends SingleChildStatelessModifier {
  /// Creates a widget that sizes its child to the child's intrinsic width.
  ///
  /// This class is relatively expensive. Avoid using it where possible.
  const IntrinsicWidthModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.stepWidth,
    this.stepHeight,
  })  : assert(stepWidth == null || stepWidth >= 0.0),
        assert(stepHeight == null || stepHeight >= 0.0);

  /// If non-null, force the child's width to be a multiple of this value.
  ///
  /// If null or 0.0 the child's width will be the same as its maximum
  /// intrinsic width.
  ///
  /// This value must not be negative.
  ///
  /// See also:
  ///
  ///  * [RenderBox.getMaxIntrinsicWidth], which defines a widget's max
  ///    intrinsic width  in general.
  final double? stepWidth;

  /// If non-null, force the child's height to be a multiple of this value.
  ///
  /// If null or 0.0 the child's height will not be constrained.
  ///
  /// This value must not be negative.
  final double? stepHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IntrinsicWidth(
      key: modifierKey,
      stepHeight: stepHeight,
      stepWidth: stepWidth,
      child: child,
    );
  }
}

/// A widget that sizes its child to the child's intrinsic height.
///
/// This class is useful, for example, when unlimited height is available and
/// you would like a child that would otherwise attempt to expand infinitely to
/// instead size itself to a more reasonable height.
///
/// The constraints that this widget passes to its child will adhere to the
/// parent's constraints, so if the constraints are not large enough to satisfy
/// the child's maximum intrinsic height, then the child will get less height
/// than it otherwise would. Likewise, if the minimum height constraint is
/// larger than the child's maximum intrinsic height, the child will be given
/// more height than it otherwise would.
///
/// This class is relatively expensive, because it adds a speculative layout
/// pass before the final layout phase. Avoid using it where possible. In the
/// worst case, this widget can result in a layout that is O(N²) in the depth of
/// the tree.
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself. This can be used
///    to loosen the constraints passed to the [RenderIntrinsicHeight],
///    allowing the [RenderIntrinsicHeight]'s child to be smaller than that of
///    its parent.
///  * [Column], which when used with [CrossAxisAlignment.stretch] can be used
///    to loosen just the height constraints that are passed to the
///    [RenderIntrinsicHeight], allowing the [RenderIntrinsicHeight]'s child's
///    height to be smaller than that of its parent.
///  * [The catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IntrinsicHeightModifier extends SingleChildStatelessModifier {
  /// Creates a widget that sizes its child to the child's intrinsic height.
  ///
  /// This class is relatively expensive. Avoid using it where possible.
  const IntrinsicHeightModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IntrinsicHeight(
      key: modifierKey,
      child: child,
    );
  }
}

/// A widget that positions its child according to the child's baseline.
///
/// This widget shifts the child down such that the child's baseline (or the
/// bottom of the child, if the child has no baseline) is [baseline]
/// logical pixels below the top of this box, then sizes this box to
/// contain the child. If [baseline] is less than the distance from
/// the top of the child to the baseline of the child, then the child
/// is top-aligned instead.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=8ZaFk0yvNlI}
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself and optionally
///    sizes itself based on the child's size.
///  * [Center], a widget that centers its child within itself.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class BaselineModifier extends SingleChildStatelessModifier {
  /// Creates a widget that positions its child according to the child's baseline.
  ///
  /// The [baseline] and [baselineType] arguments must not be null.
  const BaselineModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.baseline,
    required this.baselineType,
  });

  /// The number of logical pixels from the top of this box at which to position
  /// the child's baseline.
  final double baseline;

  /// The type of baseline to use for positioning the child.
  final TextBaseline baselineType;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Baseline(
      key: modifierKey,
      baseline: baseline,
      baselineType: baselineType,
      child: child,
    );
  }
}

// SLIVERS

/// A sliver that contains a single box widget.
///
/// Slivers are special-purpose widgets that can be combined using a
/// [CustomScrollView] to create custom scroll effects. A [SliverToBoxAdapter]
/// is a basic sliver that creates a bridge back to one of the usual box-based
/// widgets.
///
/// Rather than using multiple [SliverToBoxAdapter] widgets to display multiple
/// box widgets in a [CustomScrollView], consider using [SliverList],
/// [SliverFixedExtentList], [SliverPrototypeExtentList], or [SliverGrid],
/// which are more efficient because they instantiate only those children that
/// are actually visible through the scroll view's viewport.
///
/// See also:
///
///  * [CustomScrollView], which displays a scrollable list of slivers.
///  * [SliverList], which displays multiple box widgets in a linear array.
///  * [SliverFixedExtentList], which displays multiple box widgets with the
///    same main-axis extent in a linear array.
///  * [SliverPrototypeExtentList], which displays multiple box widgets with the
///    same main-axis extent as a prototype item, in a linear array.
///  * [SliverGrid], which displays multiple box widgets in arbitrary positions.
class SliverToBoxAdapterModifier extends SingleChildStatelessModifier {
  /// Creates a sliver that contains a single box widget.
  const SliverToBoxAdapterModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverToBoxAdapter(key: modifierKey, child: child);
  }
}

/// A sliver that applies padding on each side of another sliver.
///
/// Slivers are special-purpose widgets that can be combined using a
/// [CustomScrollView] to create custom scroll effects. A [SliverPadding]
/// is a basic sliver that insets another sliver by applying padding on each
/// side.
///
/// {@macro flutter.rendering.RenderSliverEdgeInsetsPadding}
///
/// See also:
///
///  * [CustomScrollView], which displays a scrollable list of slivers.
class SliverPaddingModifier extends SingleChildStatelessModifier {
  /// Creates a sliver that applies padding on each side of another sliver.
  ///
  /// The [padding] argument must not be null.
  const SliverPaddingModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.padding,
  });

  /// The amount of space by which to inset the child sliver.
  final EdgeInsetsGeometry padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverPadding(
      padding: padding,
      sliver: child,
    );
  }
}

// LAYOUT NODES

/// A widget that controls where a child of a [Stack] is positioned.
///
/// A [Positioned] widget must be a descendant of a [Stack], and the path from
/// the [Positioned] widget to its enclosing [Stack] must contain only
/// [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like
/// [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EgtPleVwxBQ}
///
/// If a widget is wrapped in a [Positioned], then it is a _positioned_ widget
/// in its [Stack]. If the [top] property is non-null, the top edge of this child
/// will be positioned [top] layout units from the top of the stack widget. The
/// [right], [bottom], and [left] properties work analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [right] and [left] properties to non-null values will
/// force the child to have a particular width. Alternatively the [width] and
/// [height] properties can be used to give the dimensions, with one
/// corresponding position property (e.g. [top] and [height]).
///
/// If all three values on a particular axis are null, then the
/// [Stack.alignment] property is used to position the child.
///
/// If all six values are null, the child is a non-positioned child. The [Stack]
/// uses only the non-positioned children to size itself.
///
/// See also:
///
///  * [AnimatedPositioned], which automatically transitions the child's
///    position over a given duration whenever the given position changes.
///  * [PositionedTransition], which takes a provided [Animation] to transition
///    changes in the child's position over a given duration.
///  * [PositionedDirectional], which adapts to the ambient [Directionality].
class PositionedModifier extends SingleChildStatelessModifier {
  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values ([left], [right],
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// See also:
  ///
  ///  * [Positioned.directional], which specifies the widget's horizontal
  ///    position using `start` and `end` rather than `left` and `right`.
  ///  * [PositionedDirectional], which is similar to [Positioned.directional]
  ///    but adapts to the ambient [Directionality].
  const PositionedModifier({
    super.key,
    super.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null);

  /// Creates a Positioned object with the values from the given [Rect].
  ///
  /// This sets the [left], [top], [width], and [height] properties
  /// from the given [Rect]. The [right] and [bottom] properties are
  /// set to null.
  PositionedModifier.fromRect({
    super.key,
    super.child,
    required Rect rect,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null;

  /// Creates a Positioned object with the values from the given [RelativeRect].
  ///
  /// This sets the [left], [top], [right], and [bottom] properties from the
  /// given [RelativeRect]. The [height] and [width] properties are set to null.
  PositionedModifier.fromRelativeRect({
    super.key,
    super.child,
    required RelativeRect rect,
  })  : left = rect.left,
        top = rect.top,
        right = rect.right,
        bottom = rect.bottom,
        width = null,
        height = null;

  /// Creates a Positioned object with [left], [top], [right], and [bottom] set
  /// to 0.0 unless a value for them is passed.
  const PositionedModifier.fill({
    super.key,
    super.child,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  })  : width = null,
        height = null;

  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values (`start`, `end`,
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// If `textDirection` is [TextDirection.rtl], then the `start` argument is
  /// used for the [right] property and the `end` argument is used for the
  /// [left] property. Otherwise, if `textDirection` is [TextDirection.ltr],
  /// then the `start` argument is used for the [left] property and the `end`
  /// argument is used for the [right] property.
  ///
  /// The `textDirection` argument must not be null.
  ///
  /// See also:
  ///
  ///  * [PositionedDirectional], which adapts to the ambient [Directionality].
  factory PositionedModifier.directional({
    Key? key,
    Widget? child,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
  }) {
    double? left;
    double? right;
    switch (textDirection) {
      case TextDirection.rtl:
        left = end;
        right = start;
        break;
      case TextDirection.ltr:
        left = start;
        right = end;
        break;
    }
    return PositionedModifier(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }

  /// The distance that the child's left edge is inset from the left of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? left;

  /// The distance that the child's top edge is inset from the top of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? top;

  /// The distance that the child's right edge is inset from the right of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? right;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return Positioned(
      key: modifierKey,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child!,
    );
  }
}

/// A widget that controls where a child of a [Stack] is positioned without
/// committing to a specific [TextDirection].
///
/// The ambient [Directionality] is used to determine whether [start] is to the
/// left or to the right.
///
/// A [PositionedDirectional] widget must be a descendant of a [Stack], and the
/// path from the [PositionedDirectional] widget to its enclosing [Stack] must
/// contain only [StatelessWidget]s or [StatefulWidget]s (not other kinds of
/// widgets, like [RenderObjectWidget]s).
///
/// If a widget is wrapped in a [PositionedDirectional], then it is a
/// _positioned_ widget in its [Stack]. If the [top] property is non-null, the
/// top edge of this child/ will be positioned [top] layout units from the top
/// of the stack widget. The [start], [bottom], and [end] properties work
/// analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [start] and [end] properties to non-null values will
/// force the child to have a particular width. Alternatively the [width] and
/// [height] properties can be used to give the dimensions, with one
/// corresponding position property (e.g. [top] and [height]).
///
/// See also:
///
///  * [Positioned], which specifies the widget's position visually.
///  * [Positioned.directional], which also specifies the widget's horizontal
///    position using [start] and [end] but has an explicit [TextDirection].
///  * [AnimatedPositionedDirectional], which automatically transitions
///    the child's position over a given duration whenever the given position
///    changes.
class PositionedDirectionalModifier extends SingleChildStatelessModifier {
  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values (`start`, `end`,
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// See also:
  ///
  ///  * [Positioned.directional], which also specifies the widget's horizontal
  ///    position using [start] and [end] but has an explicit [TextDirection].
  const PositionedDirectionalModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
  });

  /// The distance that the child's leading edge is inset from the leading edge
  /// of the stack.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? start;

  /// The distance that the child's top edge is inset from the top of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? top;

  /// The distance that the child's trailing edge is inset from the trailing
  /// edge of the stack.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? end;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);

    return Positioned.directional(
      textDirection: Directionality.of(context),
      start: start,
      top: top,
      end: end,
      bottom: bottom,
      width: width,
      height: height,
      child: child!,
    );
  }
}

/// A widget that controls how a child of a [Row], [Column], or [Flex] flexes.
///
/// Using a [Flexible] widget gives a child of a [Row], [Column], or [Flex]
/// the flexibility to expand to fill the available space in the main axis
/// (e.g., horizontally for a [Row] or vertically for a [Column]), but, unlike
/// [Expanded], [Flexible] does not require the child to fill the available
/// space.
///
/// A [Flexible] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Flexible] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=CI7x0mAZiY0}
///
/// See also:
///
///  * [Expanded], which forces the child to expand to fill the available space.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FlexibleModifier extends SingleChildStatelessModifier {
  /// Creates a widget that controls how a child of a [Row], [Column], or [Flex]
  /// flexes.
  const FlexibleModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.flex = 1,
    this.fit = FlexFit.loose,
  });

  /// The flex factor to use for this child.
  ///
  /// If null or zero, the child is inflexible and determines its own size. If
  /// non-zero, the amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space (after placing the inflexible
  /// children) according to the flex factors of the flexible children.
  final int flex;

  /// How a flexible child is inscribed into the available space.
  ///
  /// If [flex] is non-zero, the [fit] determines whether the child fills the
  /// space the parent makes available during layout. If the fit is
  /// [FlexFit.tight], the child is required to fill the available space. If the
  /// fit is [FlexFit.loose], the child can be at most as large as the available
  /// space (but is allowed to be smaller).
  final FlexFit fit;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Flexible(
      key: modifierKey,
      fit: fit,
      flex: flex,
      child: child!,
    );
  }
}

/// A widget that expands a child of a [Row], [Column], or [Flex]
/// so that the child fills the available space.
///
/// Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]
/// expand to fill the available space along the main axis (e.g., horizontally for
/// a [Row] or vertically for a [Column]). If multiple children are expanded,
/// the available space is divided among them according to the [flex] factor.
///
/// An [Expanded] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Expanded] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=_rnZaagadyo}
///
/// {@tool dartpad}
/// This example shows how to use an [Expanded] widget in a [Column] so that
/// its middle child, a [Container] here, expands to fill the space.
///
/// ![This results in two thin blue boxes with a larger amber box in between.](https://flutter.github.io/assets-for-api-docs/assets/widgets/expanded_column.png)
///
/// ** See code in examples/api/lib/widgets/basic/expanded.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to use an [Expanded] widget in a [Row] with multiple
/// children expanded, utilizing the [flex] factor to prioritize available space.
///
/// ![This results in a wide amber box, followed by a thin blue box, with a medium width amber box at the end.](https://flutter.github.io/assets-for-api-docs/assets/widgets/expanded_row.png)
///
/// ** See code in examples/api/lib/widgets/basic/expanded.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Flexible], which does not force the child to fill the available space.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class ExpandedModifier extends FlexibleModifier {
  /// Creates a widget that expands a child of a [Row], [Column], or [Flex]
  /// so that the child fills the available space along the flex widget's
  /// main axis.
  const ExpandedModifier({
    super.key,
    super.child,
    int? flex,
  }) : super(fit: FlexFit.tight, flex: flex ?? 1);
}

// EVENT HANDLING

/// A widget that calls callbacks in response to common pointer events.
///
/// It listens to events that can construct gestures, such as when the
/// pointer is pressed, moved, then released or canceled.
///
/// It does not listen to events that are exclusive to mouse, such as when the
/// mouse enters, exits or hovers a region without pressing any buttons. For
/// these events, use [MouseRegion].
///
/// Rather than listening for raw pointer events, consider listening for
/// higher-level gestures using [GestureDetector].
///
/// ## Layout behavior
///
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// If it has a child, this widget defers to the child for sizing behavior. If
/// it does not have a child, it grows to fit the parent instead.
///
/// {@tool dartpad}
/// This example makes a [Container] react to being touched, showing a count of
/// the number of pointer downs and ups.
///
/// ** See code in examples/api/lib/widgets/basic/listener.0.dart **
/// {@end-tool}
class ListenerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that forwards point events to callbacks.
  ///
  /// The [behavior] argument defaults to [HitTestBehavior.deferToChild].
  const ListenerModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerSignal,
    this.onPointerPanZoomEnd,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.behavior = HitTestBehavior.deferToChild,
  });

  /// Called when a pointer comes into contact with the screen (for touch
  /// pointers), or has its button pressed (for mouse pointers) at this widget's
  /// location.
  final PointerDownEventListener? onPointerDown;

  /// Called when a pointer that triggered an [onPointerDown] changes position.
  final PointerMoveEventListener? onPointerMove;

  /// Called when a pointer that triggered an [onPointerDown] is no longer in
  /// contact with the screen.
  final PointerUpEventListener? onPointerUp;

  /// Called when a pointer that has not triggered an [onPointerDown] changes
  /// position.
  ///
  /// This is only fired for pointers which report their location when not down
  /// (e.g. mouse pointers, but not most touch pointers).
  final PointerHoverEventListener? onPointerHover;

  /// Called when the input from a pointer that triggered an [onPointerDown] is
  /// no longer directed towards this receiver.
  final PointerCancelEventListener? onPointerCancel;

  /// Called when a pan/zoom begins such as from a trackpad gesture.
  final PointerPanZoomStartEventListener? onPointerPanZoomStart;

  /// Called when a pan/zoom is updated.
  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;

  /// Called when a pan/zoom finishes.
  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;

  /// Called when a pointer signal occurs over this object.
  ///
  /// See also:
  ///
  ///  * [PointerSignalEvent], which goes into more detail on pointer signal
  ///    events.
  final PointerSignalEventListener? onPointerSignal;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Listener(
      key: modifierKey,
      behavior: behavior,
      onPointerCancel: onPointerCancel,
      onPointerDown: onPointerDown,
      onPointerHover: onPointerHover,
      onPointerMove: onPointerMove,
      onPointerSignal: onPointerSignal,
      onPointerUp: onPointerUp,
      child: child,
    );
  }
}

/// A widget that tracks the movement of mice.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=1oF3pI5umck}
///
/// [MouseRegion] is used
/// when it is needed to compare the list of objects that a mouse pointer is
/// hovering over between this frame and the last frame. This means entering
/// events, exiting events, and mouse cursors.
///
/// To listen to general pointer events, use [Listener], or more preferably,
/// [GestureDetector].
///
/// ## Layout behavior
///
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// If it has a child, this widget defers to the child for sizing behavior. If
/// it does not have a child, it grows to fit the parent instead.
///
/// {@tool dartpad}
/// This example makes a [Container] react to being entered by a mouse
/// pointer, showing a count of the number of entries and exits.
///
/// ** See code in examples/api/lib/widgets/basic/mouse_region.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Listener], a similar widget that tracks pointer events when the pointer
///    has buttons pressed.
class MouseRegionModifier extends SingleChildStatelessModifier {
  /// Creates a widget that forwards mouse events to callbacks.
  ///
  /// By default, all callbacks are empty, [cursor] is [MouseCursor.defer], and
  /// [opaque] is true. The [cursor] must not be null.
  const MouseRegionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
  });

  /// Triggered when a mouse pointer has entered this widget.
  ///
  /// This callback is triggered when the pointer, with or without buttons
  /// pressed, has started to be contained by the region of this widget. More
  /// specifically, the callback is triggered by the following cases:
  ///
  ///  * This widget has appeared under a pointer.
  ///  * This widget has moved to under a pointer.
  ///  * A new pointer has been added to somewhere within this widget.
  ///  * An existing pointer has moved into this widget.
  ///
  /// This callback is not always matched by an [onExit]. If the [MouseRegion]
  /// is unmounted while being hovered by a pointer, the [onExit] of the widget
  /// callback will never called. For more details, see [onExit].
  ///
  /// {@template flutter.widgets.MouseRegion.onEnter.triggerTime}
  /// The time that this callback is triggered is always between frames: either
  /// during the post-frame callbacks, or during the callback of a pointer
  /// event.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [onExit], which is triggered when a mouse pointer exits the region.
  ///  * [MouseTrackerAnnotation.onEnter], which is how this callback is
  ///    internally implemented.
  final PointerEnterEventListener? onEnter;

  /// Triggered when a pointer moves into a position within this widget without
  /// buttons pressed.
  ///
  /// Usually this is only fired for pointers which report their location when
  /// not down (e.g. mouse pointers). Certain devices also fire this event on
  /// single taps in accessibility mode.
  ///
  /// This callback is not triggered by the movement of the widget.
  ///
  /// The time that this callback is triggered is during the callback of a
  /// pointer event, which is always between frames.
  ///
  /// See also:
  ///
  ///  * [Listener.onPointerHover], which does the same job. Prefer using
  ///    [Listener.onPointerHover], since hover events are similar to other regular
  ///    events.
  final PointerHoverEventListener? onHover;

  /// Triggered when a mouse pointer has exited this widget when the widget is
  /// still mounted.
  ///
  /// This callback is triggered when the pointer, with or without buttons
  /// pressed, has stopped being contained by the region of this widget, except
  /// when the exit is caused by the disappearance of this widget. More
  /// specifically, this callback is triggered by the following cases:
  ///
  ///  * A pointer that is hovering this widget has moved away.
  ///  * A pointer that is hovering this widget has been removed.
  ///  * This widget, which is being hovered by a pointer, has moved away.
  ///
  /// And is __not__ triggered by the following case:
  ///
  ///  * This widget, which is being hovered by a pointer, has disappeared.
  ///
  /// This means that a [MouseRegion.onExit] might not be matched by a
  /// [MouseRegion.onEnter].
  ///
  /// This restriction aims to prevent a common misuse: if [State.setState] is
  /// called during [MouseRegion.onExit] without checking whether the widget is
  /// still mounted, an exception will occur. This is because the callback is
  /// triggered during the post-frame phase, at which point the widget has been
  /// unmounted. Since [State.setState] is exclusive to widgets, the restriction
  /// is specific to [MouseRegion], and does not apply to its lower-level
  /// counterparts, [RenderMouseRegion] and [MouseTrackerAnnotation].
  ///
  /// There are a few ways to mitigate this restriction:
  ///
  ///  * If the hover state is completely contained within a widget that
  ///    unconditionally creates this [MouseRegion], then this will not be a
  ///    concern, since after the [MouseRegion] is unmounted the state is no
  ///    longer used.
  ///  * Otherwise, the outer widget very likely has access to the variable that
  ///    controls whether this [MouseRegion] is present. If so, call [onExit] at
  ///    the event that turns the condition from true to false.
  ///  * In cases where the solutions above won't work, you can always
  ///    override [State.dispose] and call [onExit], or create your own widget
  ///    using [RenderMouseRegion].
  ///
  /// {@tool dartpad}
  /// The following example shows a blue rectangular that turns yellow when
  /// hovered. Since the hover state is completely contained within a widget
  /// that unconditionally creates the `MouseRegion`, you can ignore the
  /// aforementioned restriction.
  ///
  /// ** See code in examples/api/lib/widgets/basic/mouse_region.on_exit.0.dart **
  /// {@end-tool}
  ///
  /// {@tool dartpad}
  /// The following example shows a widget that hides its content one second
  /// after being hovered, and also exposes the enter and exit callbacks.
  /// Because the widget conditionally creates the `MouseRegion`, and leaks the
  /// hover state, it needs to take the restriction into consideration. In this
  /// case, since it has access to the event that triggers the disappearance of
  /// the `MouseRegion`, it simply trigger the exit callback during that event
  /// as well.
  ///
  /// ** See code in examples/api/lib/widgets/basic/mouse_region.on_exit.1.dart **
  /// {@end-tool}
  ///
  /// {@macro flutter.widgets.MouseRegion.onEnter.triggerTime}
  ///
  /// See also:
  ///
  ///  * [onEnter], which is triggered when a mouse pointer enters the region.
  ///  * [RenderMouseRegion] and [MouseTrackerAnnotation.onExit], which are how
  ///    this callback is internally implemented, but without the restriction.
  final PointerExitEventListener? onExit;

  /// The mouse cursor for mouse pointers that are hovering over the region.
  ///
  /// When a mouse enters the region, its cursor will be changed to the [cursor].
  /// When the mouse leaves the region, the cursor will be decided by the region
  /// found at the new location.
  ///
  /// The [cursor] defaults to [MouseCursor.defer], deferring the choice of
  /// cursor to the next region behind it in hit-test order.
  final MouseCursor cursor;

  /// Whether this widget should prevent other [MouseRegion]s visually behind it
  /// from detecting the pointer.
  ///
  /// This changes the list of regions that a pointer hovers, thus affecting how
  /// their [onHover], [onEnter], [onExit], and [cursor] behave.
  ///
  /// If [opaque] is true, this widget will absorb the mouse pointer and
  /// prevent this widget's siblings (or any other widgets that are not
  /// ancestors or descendants of this widget) from detecting the mouse
  /// pointer even when the pointer is within their areas.
  ///
  /// If [opaque] is false, this object will not affect how [MouseRegion]s
  /// behind it behave, which will detect the mouse pointer as long as the
  /// pointer is within their areas.
  ///
  /// This defaults to true.
  final bool opaque;

  /// How to behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.opaque] if null.
  final HitTestBehavior? hitTestBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MouseRegion(
      key: modifierKey,
      cursor: cursor,
      hitTestBehavior: hitTestBehavior,
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      opaque: opaque,
      child: child,
    );
  }
}

/// A widget that creates a separate display list for its child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=cVAGLDuc2xE}
///
/// This widget creates a separate display list for its child, which
/// can improve performance if the subtree repaints at different times than
/// the surrounding parts of the tree.
///
/// This is useful since [RenderObject.paint] may be triggered even if its
/// associated [Widget] instances did not change or rebuild. A [RenderObject]
/// will repaint whenever any [RenderObject] that shares the same [Layer] is
/// marked as being dirty and needing paint (see [RenderObject.markNeedsPaint]),
/// such as when an ancestor scrolls or when an ancestor or descendant animates.
///
/// Containing [RenderObject.paint] to parts of the render subtree that are
/// actually visually changing using [RepaintBoundary] explicitly or implicitly
/// is therefore critical to minimizing redundant work and improving the app's
/// performance.
///
/// When a [RenderObject] is flagged as needing to paint via
/// [RenderObject.markNeedsPaint], the nearest ancestor [RenderObject] with
/// [RenderObject.isRepaintBoundary], up to possibly the root of the application,
/// is requested to repaint. That nearest ancestor's [RenderObject.paint] method
/// will cause _all_ of its descendant [RenderObject]s to repaint in the same
/// layer.
///
/// [RepaintBoundary] is therefore used, both while propagating the
/// `markNeedsPaint` flag up the render tree and while traversing down the
/// render tree via [PaintingContext.paintChild], to strategically contain
/// repaints to the render subtree that visually changed for performance. This
/// is done because the [RepaintBoundary] widget creates a [RenderObject] that
/// always has a [Layer], decoupling ancestor render objects from the descendant
/// render objects.
///
/// [RepaintBoundary] has the further side-effect of possibly hinting to the
/// engine that it should further optimize animation performance if the render
/// subtree behind the [RepaintBoundary] is sufficiently complex and is static
/// while the surrounding tree changes frequently. In those cases, the engine
/// may choose to pay a one time cost of rasterizing and caching the pixel
/// values of the subtree for faster future GPU re-rendering speed.
///
/// Several framework widgets insert [RepaintBoundary] widgets to mark natural
/// separation points in applications. For instance, contents in Material Design
/// drawers typically don't change while the drawer opens and closes, so
/// repaints are automatically contained to regions inside or outside the drawer
/// when using the [Drawer] widget during transitions.
///
/// See also:
///
///  * [debugRepaintRainbowEnabled], a debugging flag to help visually monitor
///    render tree repaints in a running app.
///  * [debugProfilePaintsEnabled], a debugging flag to show render tree
///    repaints in the observatory's timeline view.
class RepaintBoundaryModifier extends SingleChildStatelessModifier {
  /// Creates a widget that isolates repaints.
  const RepaintBoundaryModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  /// Wraps the given child in a [RepaintBoundary].
  ///
  /// The key for the [RepaintBoundary] is derived either from the child's key
  /// (if the child has a non-null key) or from the given `childIndex`.
  @override
  factory RepaintBoundaryModifier.wrap(Widget child, int childIndex) {
    final Key key = child.key != null ? ValueKey<Key>(child.key!) : ValueKey<int>(childIndex);
    return RepaintBoundaryModifier(modifierKey: key, child: child);
  }

  /// Wraps each of the given children in [RepaintBoundary]s.
  ///
  /// The key for each [RepaintBoundary] is derived either from the wrapped
  /// child's key (if the wrapped child has a non-null key) or from the wrapped
  /// child's index in the list.
  static List<RepaintBoundaryModifier> wrapAll(List<Widget> widgets) => <RepaintBoundaryModifier>[
        for (int i = 0; i < widgets.length; ++i) RepaintBoundaryModifier.wrap(widgets[i], i),
      ];

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RepaintBoundary(
      key: modifierKey,
      child: child,
    );
  }
}

/// A widget that is invisible during hit testing.
///
/// When [ignoring] is true, this widget (and its subtree) is invisible
/// to hit testing. It still consumes space during layout and paints its child
/// as usual. It just cannot be the target of located events, because it returns
/// false from [RenderBox.hitTest].
///
/// When [ignoringSemantics] is true, the subtree will be invisible to
/// the semantics layer (and thus e.g. accessibility tools). If
/// [ignoringSemantics] is null, it uses the value of [ignoring].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=qV9pqHWxYgI}
///
/// {@tool dartpad}
/// The following sample has an [IgnorePointer] widget wrapping the `Column`
/// which contains a button.
/// When [ignoring] is set to `true` anything inside the `Column` can
/// not be tapped. When [ignoring] is set to `false` anything
/// inside the `Column` can be tapped.
///
/// ** See code in examples/api/lib/widgets/basic/ignore_pointer.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AbsorbPointer], which also prevents its children from receiving pointer
///    events but is itself visible to hit testing.
class IgnorePointerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that is invisible to hit testing.
  ///
  /// The [ignoring] argument must not be null. If [ignoringSemantics] is null,
  /// this render object will be ignored for semantics if [ignoring] is true.
  const IgnorePointerModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.ignoring = true,
    this.ignoringSemantics,
  });

  /// Whether this widget is ignored during hit testing.
  ///
  /// Regardless of whether this widget is ignored during hit testing, it will
  /// still consume space during layout and be visible during painting.
  final bool ignoring;

  /// Whether the semantics of this widget is ignored when compiling the semantics tree.
  ///
  /// If null, defaults to value of [ignoring].
  ///
  /// See [SemanticsNode] for additional information about the semantics tree.
  final bool? ignoringSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IgnorePointer(
      key: modifierKey,
      ignoring: ignoring,
      ignoringSemantics: ignoringSemantics,
      child: child,
    );
  }
}

/// A widget that absorbs pointers during hit testing.
///
/// When [absorbing] is true, this widget prevents its subtree from receiving
/// pointer events by terminating hit testing at itself. It still consumes space
/// during layout and paints its child as usual. It just prevents its children
/// from being the target of located events, because it returns true from
/// [RenderBox.hitTest].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=65HoWqBboI8}
///
/// {@tool dartpad}
/// The following sample has an [AbsorbPointer] widget wrapping the button on
/// top of the stack, which absorbs pointer events, preventing its child button
/// __and__ the button below it in the stack from receiving the pointer events.
///
/// ** See code in examples/api/lib/widgets/basic/absorb_pointer.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [IgnorePointer], which also prevents its children from receiving pointer
///    events but is itself invisible to hit testing.
class AbsorbPointerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that absorbs pointers during hit testing.
  ///
  /// The [absorbing] argument must not be null.
  const AbsorbPointerModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.absorbing = true,
    this.ignoringSemantics,
  });

  /// Whether this widget absorbs pointers during hit testing.
  ///
  /// Regardless of whether this render object absorbs pointers during hit
  /// testing, it will still consume space during layout and be visible during
  /// painting.
  final bool absorbing;

  /// Whether the semantics of this render object is ignored when compiling the
  /// semantics tree.
  ///
  /// If null, defaults to the value of [absorbing].
  ///
  /// See [SemanticsNode] for additional information about the semantics tree.
  final bool? ignoringSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AbsorbPointer(
      key: modifierKey,
      absorbing: absorbing,
      ignoringSemantics: ignoringSemantics,
      child: child,
    );
  }
}

/// Holds opaque meta data in the render tree.
///
/// Useful for decorating the render tree with information that will be consumed
/// later. For example, you could store information in the render tree that will
/// be used when the user interacts with the render tree but has no visual
/// impact prior to the interaction.
class MetaDataModifier extends SingleChildStatelessModifier {
  /// Creates a widget that hold opaque meta data.
  ///
  /// The [behavior] argument defaults to [HitTestBehavior.deferToChild].
  const MetaDataModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.metaData,
    this.behavior = HitTestBehavior.deferToChild,
  });

  /// Opaque meta data ignored by the render tree.
  final dynamic metaData;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MetaData(
      key: modifierKey,
      behavior: behavior,
      metaData: metaData,
      child: child,
    );
  }
}

// UTILITY NODES

/// A widget that annotates the widget tree with a description of the meaning of
/// the widgets.
///
/// Used by accessibility tools, search engines, and other semantic analysis
/// software to determine the meaning of the application.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=NvtMt_DtFrQ}
///
/// See also:
///
///  * [MergeSemantics], which marks a subtree as being a single node for
///    accessibility purposes.
///  * [ExcludeSemantics], which excludes a subtree from the semantics tree
///    (which might be useful if it is, e.g., totally decorative and not
///    important to the user).
///  * [RenderObject.describeSemanticsConfiguration], the rendering library API
///    through which the [Semantics] widget is actually implemented.
///  * [SemanticsNode], the object used by the rendering library to represent
///    semantics in the semantics tree.
///  * [SemanticsDebugger], an overlay to help visualize the semantics tree. Can
///    be enabled using [WidgetsApp.showSemanticsDebugger] or
///    [MaterialApp.showSemanticsDebugger].
@immutable
class SemanticsModifier extends SingleChildStatelessModifier {
  /// Creates a semantic annotation.
  ///
  /// The [container] argument must not be null. To create a `const` instance
  /// of [Semantics], use the [Semantics.fromProperties] constructor.
  ///
  /// See also:
  ///
  ///  * [SemanticsSortKey] for a class that determines accessibility traversal
  ///    order.
  SemanticsModifier({
    Key? key,
    Key? modifierKey,
    Widget? child,
    bool container = false,
    bool explicitChildNodes = false,
    bool excludeSemantics = false,
    bool? enabled,
    bool? checked,
    bool? selected,
    bool? toggled,
    bool? button,
    bool? slider,
    bool? keyboardKey,
    bool? link,
    bool? header,
    bool? textField,
    bool? readOnly,
    bool? focusable,
    bool? focused,
    bool? inMutuallyExclusiveGroup,
    bool? obscured,
    bool? multiline,
    bool? scopesRoute,
    bool? namesRoute,
    bool? hidden,
    bool? image,
    bool? liveRegion,
    int? maxValueLength,
    int? currentValueLength,
    String? label,
    AttributedString? attributedLabel,
    String? value,
    AttributedString? attributedValue,
    String? increasedValue,
    AttributedString? attributedIncreasedValue,
    String? decreasedValue,
    AttributedString? attributedDecreasedValue,
    String? hint,
    AttributedString? attributedHint,
    String? onTapHint,
    String? onLongPressHint,
    TextDirection? textDirection,
    SemanticsSortKey? sortKey,
    SemanticsTag? tagForChildren,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onScrollLeft,
    VoidCallback? onScrollRight,
    VoidCallback? onScrollUp,
    VoidCallback? onScrollDown,
    VoidCallback? onIncrease,
    VoidCallback? onDecrease,
    VoidCallback? onCopy,
    VoidCallback? onCut,
    VoidCallback? onPaste,
    VoidCallback? onDismiss,
    MoveCursorHandler? onMoveCursorForwardByCharacter,
    MoveCursorHandler? onMoveCursorBackwardByCharacter,
    SetSelectionHandler? onSetSelection,
    SetTextHandler? onSetText,
    VoidCallback? onDidGainAccessibilityFocus,
    VoidCallback? onDidLoseAccessibilityFocus,
    Map<CustomSemanticsAction, VoidCallback>? customSemanticsActions,
  }) : this.fromProperties(
          key: key,
          modifierKey: modifierKey,
          child: child,
          container: container,
          explicitChildNodes: explicitChildNodes,
          excludeSemantics: excludeSemantics,
          properties: SemanticsProperties(
            enabled: enabled,
            checked: checked,
            toggled: toggled,
            selected: selected,
            button: button,
            slider: slider,
            keyboardKey: keyboardKey,
            link: link,
            header: header,
            textField: textField,
            readOnly: readOnly,
            focusable: focusable,
            focused: focused,
            inMutuallyExclusiveGroup: inMutuallyExclusiveGroup,
            obscured: obscured,
            multiline: multiline,
            scopesRoute: scopesRoute,
            namesRoute: namesRoute,
            hidden: hidden,
            image: image,
            liveRegion: liveRegion,
            maxValueLength: maxValueLength,
            currentValueLength: currentValueLength,
            label: label,
            attributedLabel: attributedLabel,
            value: value,
            attributedValue: attributedValue,
            increasedValue: increasedValue,
            attributedIncreasedValue: attributedIncreasedValue,
            decreasedValue: decreasedValue,
            attributedDecreasedValue: attributedDecreasedValue,
            hint: hint,
            attributedHint: attributedHint,
            textDirection: textDirection,
            sortKey: sortKey,
            tagForChildren: tagForChildren,
            onTap: onTap,
            onLongPress: onLongPress,
            onScrollLeft: onScrollLeft,
            onScrollRight: onScrollRight,
            onScrollUp: onScrollUp,
            onScrollDown: onScrollDown,
            onIncrease: onIncrease,
            onDecrease: onDecrease,
            onCopy: onCopy,
            onCut: onCut,
            onPaste: onPaste,
            onMoveCursorForwardByCharacter: onMoveCursorForwardByCharacter,
            onMoveCursorBackwardByCharacter: onMoveCursorBackwardByCharacter,
            onDidGainAccessibilityFocus: onDidGainAccessibilityFocus,
            onDidLoseAccessibilityFocus: onDidLoseAccessibilityFocus,
            onDismiss: onDismiss,
            onSetSelection: onSetSelection,
            onSetText: onSetText,
            customSemanticsActions: customSemanticsActions,
            hintOverrides: onTapHint != null || onLongPressHint != null
                ? SemanticsHintOverrides(
                    onTapHint: onTapHint,
                    onLongPressHint: onLongPressHint,
                  )
                : null,
          ),
        );

  /// Creates a semantic annotation using [SemanticsProperties].
  ///
  /// The [container] and [properties] arguments must not be null.
  const SemanticsModifier.fromProperties({
    super.key,
    super.child,
    super.modifierKey,
    this.container = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    required this.properties,
  });

  /// Contains properties used by assistive technologies to make the application
  /// more accessible.
  final SemanticsProperties properties;

  /// If [container] is true, this widget will introduce a new
  /// node in the semantics tree. Otherwise, the semantics will be
  /// merged with the semantics of any ancestors (if the ancestor allows that).
  ///
  /// Whether descendants of this widget can add their semantic information to the
  /// [SemanticsNode] introduced by this configuration is controlled by
  /// [explicitChildNodes].
  final bool container;

  /// Whether descendants of this widget are allowed to add semantic information
  /// to the [SemanticsNode] annotated by this widget.
  ///
  /// When set to false descendants are allowed to annotate [SemanticsNode]s of
  /// their parent with the semantic information they want to contribute to the
  /// semantic tree.
  /// When set to true the only way for descendants to contribute semantic
  /// information to the semantic tree is to introduce new explicit
  /// [SemanticsNode]s to the tree.
  ///
  /// If the semantics properties of this node include
  /// [SemanticsProperties.scopesRoute] set to true, then [explicitChildNodes]
  /// must be true also.
  ///
  /// This setting is often used in combination with [SemanticsConfiguration.isSemanticBoundary]
  /// to create semantic boundaries that are either writable or not for children.
  final bool explicitChildNodes;

  /// Whether to replace all child semantics with this node.
  ///
  /// Defaults to false.
  ///
  /// When this flag is set to true, all child semantics nodes are ignored.
  /// This can be used as a convenience for cases where a child is wrapped in
  /// an [ExcludeSemantics] widget and then another [Semantics] widget.
  final bool excludeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Semantics.fromProperties(
      key: modifierKey,
      properties: properties,
      container: container,
      excludeSemantics: excludeSemantics,
      explicitChildNodes: explicitChildNodes,
      child: child,
    );
  }
}

/// A widget that merges the semantics of its descendants.
///
/// Causes all the semantics of the subtree rooted at this node to be
/// merged into one node in the semantics tree. For example, if you
/// have a widget with a Text node next to a checkbox widget, this
/// could be used to merge the label from the Text node with the
/// "checked" semantic state of the checkbox into a single node that
/// had both the label and the checked state. Otherwise, the label
/// would be presented as a separate feature than the checkbox, and
/// the user would not be able to be sure that they were related.
///
/// {@tool snippet}
/// This snippet shows how to use [MergeSemantics] to merge the semantics of
/// a [Checkbox] and [Text] widget.
///
/// ```dart
/// MergeSemantics(
///   child: Row(
///     children: <Widget>[
///       Checkbox(
///         value: true,
///         onChanged: (bool? value) {},
///       ),
///       const Text('Settings'),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// Be aware that if two nodes in the subtree have conflicting
/// semantics, the result may be nonsensical. For example, a subtree
/// with a checked checkbox and an unchecked checkbox will be
/// presented as checked. All the labels will be merged into a single
/// string (with newlines separating each label from the other). If
/// multiple nodes in the merged subtree can handle semantic gestures,
/// the first one in tree order will be the one to receive the
/// callbacks.
class MergeSemanticsModifier extends SingleChildStatelessModifier {
  /// Creates a widget that merges the semantics of its descendants.
  const MergeSemanticsModifier({super.key, super.child, super.modifierKey});

  @override
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MergeSemantics(key: modifierKey, child: child);
  }
}

/// A widget that drops the semantics of all widget that were painted before it
/// in the same semantic container.
///
/// This is useful to hide widgets from accessibility tools that are painted
/// behind a certain widget, e.g. an alert should usually disallow interaction
/// with any widget located "behind" the alert (even when they are still
/// partially visible). Similarly, an open [Drawer] blocks interactions with
/// any widget outside the drawer.
///
/// See also:
///
///  * [ExcludeSemantics] which drops all semantics of its descendants.
class BlockSemanticsModifier extends SingleChildStatelessModifier {
  /// Creates a widget that excludes the semantics of all widgets painted before
  /// it in the same semantic container.
  const BlockSemanticsModifier({super.key, super.modifierKey, this.blocking = true, super.child});

  /// Whether this widget is blocking semantics of all widget that were painted
  /// before it in the same semantic container.
  final bool blocking;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlockSemantics(
      key: modifierKey,
      blocking: blocking,
      child: child,
    );
  }
}

/// A widget that drops all the semantics of its descendants.
///
/// When [excluding] is true, this widget (and its subtree) is excluded from
/// the semantics tree.
///
/// This can be used to hide descendant widgets that would otherwise be
/// reported but that would only be confusing. For example, the
/// material library's [Chip] widget hides the avatar since it is
/// redundant with the chip label.
///
/// See also:
///
///  * [BlockSemantics] which drops semantics of widgets earlier in the tree.
class ExcludeSemanticsModifier extends SingleChildStatelessModifier {
  /// Creates a widget that drops all the semantics of its descendants.
  const ExcludeSemanticsModifier({
    super.key,
    super.modifierKey,
    this.excluding = true,
    super.child,
  });

  /// Whether this widget is excluded in the semantics tree.
  final bool excluding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ExcludeSemantics(
      key: modifierKey,
      excluding: excluding,
      child: child,
    );
  }
}

/// A widget that annotates the child semantics with an index.
///
/// Semantic indexes are used by TalkBack/Voiceover to make announcements about
/// the current scroll state. Certain widgets like the [ListView] will
/// automatically provide a child index for building semantics. A user may wish
/// to manually provide semantic indexes if not all child of the scrollable
/// contribute semantics.
///
/// {@tool snippet}
///
/// The example below handles spacers in a scrollable that don't contribute
/// semantics. The automatic indexes would give the spaces a semantic index,
/// causing scroll announcements to erroneously state that there are four items
/// visible.
///
/// ```dart
/// ListView(
///   addSemanticIndexes: false,
///   semanticChildCount: 2,
///   children: const <Widget>[
///     IndexedSemantics(index: 0, child: Text('First')),
///     Spacer(),
///     IndexedSemantics(index: 1, child: Text('Second')),
///     Spacer(),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomScrollView], for an explanation of index semantics.
class IndexedSemanticsModifier extends SingleChildStatelessModifier {
  /// Creates a widget that annotated the first child semantics node with an index.
  ///
  /// [index] must not be null.
  const IndexedSemanticsModifier({
    super.key,
    super.modifierKey,
    required this.index,
    super.child,
  });

  /// The index used to annotate the first child semantics node.
  final int index;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IndexedSemantics(
      key: modifierKey,
      index: index,
      child: child,
    );
  }
}

/// A widget that builds its child.
///
/// Useful for attaching a key to an existing widget.
class KeyedSubtreeModifier extends SingleChildStatelessModifier {
  /// Creates a widget that builds its child.
  const KeyedSubtreeModifier({
    super.key,
    super.modifierKey,
    super.child,
  });

  /// Creates a KeyedSubtree for child with a key that's based on the child's existing key or childIndex.
  factory KeyedSubtreeModifier.wrap(Widget child, int childIndex) {
    final Key key = child.key != null ? ValueKey<Key>(child.key!) : ValueKey<int>(childIndex);
    return KeyedSubtreeModifier(key: key, child: child);
  }

  /// Wrap each item in a KeyedSubtree whose key is based on the item's existing key or
  /// the sum of its list index and `baseIndex`.
  static List<Widget> ensureUniqueKeysForList(List<Widget> items, {int baseIndex = 0}) {
    if (items.isEmpty) {
      return items;
    }

    final List<Widget> itemsWithUniqueKeys = <Widget>[];
    int itemIndex = baseIndex;
    for (final Widget item in items) {
      itemsWithUniqueKeys.add(KeyedSubtreeModifier.wrap(item, itemIndex));
      itemIndex += 1;
    }

    assert(!debugItemsHaveDuplicateKeys(itemsWithUniqueKeys));
    return itemsWithUniqueKeys;
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}

/// Single child widget builder
typedef SingleChildWidgetBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

/// A stateless utility widget whose [build] method uses its
/// [builder] callback to create the widget's child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=xXNOkIuSYuA}
///
/// This widget is a simple inline alternative to defining a [StatelessWidget]
/// subclass. For example a widget defined and used like this:
///
/// ```dart
/// class Foo extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) => Text('foo');
/// }
///
/// Center(child: Foo())
/// ```
///
/// Could equally well be defined and used like this, without
/// defining a new widget class:
///
/// ```dart
/// Center(
///   child: Builder(
///     builder: (BuildContext context) => Text('foo');
///   ),
/// )
/// ```
///
/// The difference between either of the previous examples and simply
/// creating a child directly, without an intervening widget, is the
/// extra [BuildContext] element that the additional widget adds. This
/// is particularly noticeable when the tree contains an inherited
/// widget that is referred to by a method like [Scaffold.of],
/// which visits the child widget's BuildContext ancestors.
///
/// In the following example the button's `onPressed` callback is unable
/// to find the enclosing [ScaffoldState] with [Scaffold.of]:
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: TextButton(
///         onPressed: () {
///           // Fails because Scaffold.of() doesn't find anything
///           // above this widget's context.
///           print(Scaffold.of(context).hasAppBar);
///         },
///         child: Text('hasAppBar'),
///       )
///     ),
///   );
/// }
/// ```
///
/// A [Builder] widget introduces an additional [BuildContext] element
/// and so the [Scaffold.of] method succeeds.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Builder(
///       builder: (BuildContext context) {
///         return Center(
///           child: TextButton(
///             onPressed: () {
///               print(Scaffold.of(context).hasAppBar);
///             },
///             child: Text('hasAppBar'),
///           ),
///         );
///       },
///     ),
///   );
/// }
/// ```
///
/// See also:
///
///  * [StatefulBuilder], A stateful utility widget whose [build] method uses its
///    [builder] callback to create the widget's child.
class BuilderModifier extends SingleChildStatelessModifier {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const BuilderModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.builder,
  });

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final SingleChildWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => builder(context, child);
}

/// Signature for the builder callback used by [StatefulBuilder].
///
/// Call `setState` to schedule the [StatefulBuilder] to rebuild.
typedef SingleChildStatefulWidgetBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
  Widget? child,
);

/// A platonic widget that both has state and calls a closure to obtain its child widget.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=syvT63CosNE}
///
/// The [StateSetter] function passed to the [builder] is used to invoke a
/// rebuild instead of a typical [State]'s [State.setState].
///
/// Since the [builder] is re-invoked when the [StateSetter] is called, any
/// variables that represents state should be kept outside the [builder] function.
///
/// {@tool snippet}
///
/// This example shows using an inline StatefulBuilder that rebuilds and that
/// also has state.
///
/// ```dart
/// await showDialog<void>(
///   context: context,
///   builder: (BuildContext context) {
///     int? selectedRadio = 0;
///     return AlertDialog(
///       content: StatefulBuilder(
///         builder: (BuildContext context, StateSetter setState) {
///           return Column(
///             mainAxisSize: MainAxisSize.min,
///             children: List<Widget>.generate(4, (int index) {
///               return Radio<int>(
///                 value: index,
///                 groupValue: selectedRadio,
///                 onChanged: (int? value) {
///                   setState(() => selectedRadio = value);
///                 },
///               );
///             }),
///           );
///         },
///       ),
///     );
///   },
/// );
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Builder], the platonic stateless widget.
class StatefulBuilderModifier extends SingleChildStatefulModifier {
  /// Creates a widget that both has state and delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const StatefulBuilderModifier({
    super.key,
    super.modifierKey,
    required this.builder,
  });

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final SingleChildStatefulWidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _StatefulBuilderModifierState();
}

class _StatefulBuilderModifierState extends State<StatefulBuilderModifier>
    with SingleChildStateMixin<StatefulBuilderModifier> {
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return widget.builder(context, setState, child);
  }
}

/// A widget that paints its area with a specified [Color] and then draws its
/// child on top of that color.
class ColoredBoxModifier extends SingleChildStatelessModifier {
  /// Creates a widget that paints its area with the specified [Color].
  ///
  /// The [color] parameter must not be null.
  const ColoredBoxModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.color,
  });

  /// The color to paint the background area with.
  final Color color;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ColoredBox(
      key: modifierKey,
      color: color,
      child: child,
    );
  }
}
