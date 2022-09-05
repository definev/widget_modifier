import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nested/nested.dart';

class DirectionalityModifier extends SingleChildStatelessModifier {
  const DirectionalityModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.textDirection,
  });

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

class OpacityModifier extends SingleChildStatelessModifier {
  const OpacityModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  })  : assert(opacity >= 0.0 && opacity <= 1.0),
        super(key: key, child: child);

  final double opacity;
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

class ShaderMaskModifier extends SingleChildStatelessModifier {
  const ShaderMaskModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.shaderCallback,
    this.blendMode = BlendMode.modulate,
  }) : super(key: key, child: child);

  final ShaderCallback shaderCallback;
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

class BackdropFilterModifier extends SingleChildStatelessModifier {
  const BackdropFilterModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.filter,
    this.blendMode = BlendMode.srcOver,
  }) : super(key: key, child: child);

  final ui.ImageFilter filter;
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

class CustomPaintModifier extends SingleChildStatelessModifier {
  const CustomPaintModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
  })  : assert(painter != null ||
            foregroundPainter != null ||
            (!isComplex && !willChange)),
        super(key: key, child: child);

  final CustomPainter? painter;
  final CustomPainter? foregroundPainter;
  final Size size;
  final bool isComplex;
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

class ClipRectModifier extends SingleChildStatelessModifier {
  const ClipRectModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key, child: child);

  final CustomClipper<Rect>? clipper;
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

class ClipRRectModifier extends SingleChildStatelessModifier {
  const ClipRRectModifier({
    Key? key,
    Widget? child,
    this.borderRadius = BorderRadius.zero,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  })  : assert(borderRadius != null || clipper != null),
        super(key: key, child: child);

  final BorderRadius? borderRadius;
  final CustomClipper<RRect>? clipper;
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

class ClipOvalModifier extends SingleChildStatelessModifier {
  const ClipOvalModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  }) : super(key: key, child: child);

  final CustomClipper<Rect>? clipper;
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

class ClipPathModifier extends SingleChildStatelessModifier {
  const ClipPathModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  }) : super(key: key, child: child);

  static SingleChildModifier shape({
    Key? key,
    required ShapeBorder shape,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return SingleChildBuilder(
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

  final CustomClipper<Path>? clipper;
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

class PhysicalModelModifier extends SingleChildStatelessModifier {
  const PhysicalModelModifier({
    Key? key,
    Widget? child,
    this.modfierKey,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
  })  : assert(elevation >= 0.0),
        super(key: key, child: child);

  final Key? modfierKey;
  final BoxShape shape;
  final Clip clipBehavior;
  final BorderRadius? borderRadius;
  final double elevation;
  final Color color;
  final Color shadowColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PhysicalModel(
      key: modfierKey,
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

class PhysicalShapeModifier extends SingleChildStatelessModifier {
  const PhysicalShapeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.clipper,
    this.clipBehavior = Clip.none,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
  })  : assert(elevation >= 0.0),
        super(key: key, child: child);

  final CustomClipper<Path> clipper;
  final Clip clipBehavior;
  final double elevation;
  final Color color;
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

class TransformModifier extends SingleChildStatelessModifier {
  const TransformModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.transform,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
  }) : super(key: key, child: child);

  TransformModifier.rotate({
    Key? key,
    Widget? child,
    super.modifierKey,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
  })  : transform = _computeRotation(angle),
        super(key: key, child: child);

  TransformModifier.translate({
    Key? key,
    Widget? child,
    super.modifierKey,
    required Offset offset,
    this.transformHitTests = true,
    this.filterQuality,
  })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
        origin = null,
        alignment = null,
        super(key: key, child: child);

  TransformModifier.scale({
    Key? key,
    Widget? child,
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
        transform = Matrix4.diagonal3Values(
            scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0),
        super(key: key, child: child);

  static Matrix4 _computeRotation(double radians) {
    assert(radians.isFinite,
        'Cannot compute the rotation matrix for a non-finite angle: $radians');
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

  final Matrix4 transform;
  final Offset? origin;
  final AlignmentGeometry? alignment;
  final bool transformHitTests;
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

class CompositedTransformTargetModifier extends SingleChildStatelessModifier {
  const CompositedTransformTargetModifier({
    Key? key,
    Widget? child,
    required this.link,
  }) : super(key: key, child: child);

  final LayerLink link;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CompositedTransformTarget(
      link: link,
      child: child,
    );
  }
}

class CompositedTransformFollowerModifier extends SingleChildStatelessModifier {
  const CompositedTransformFollowerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.link,
    this.showWhenUnlinked = true,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
  }) : super(key: key, child: child);

  final LayerLink link;
  final bool showWhenUnlinked;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
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

class FittedBoxModifier extends SingleChildStatelessModifier {
  const FittedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
  }) : super(key: key, child: child);

  final BoxFit fit;
  final AlignmentGeometry alignment;
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

class FractionalTranslationModifier extends SingleChildStatelessModifier {
  const FractionalTranslationModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.translation,
    this.transformHitTests = true,
  }) : super(key: key, child: child);

  final Offset translation;
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

class RotatedBoxModifier extends SingleChildStatelessModifier {
  const RotatedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.quarterTurns,
  }) : super(key: key, child: child);

  final int quarterTurns;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RotatedBox(
      key: key,
      quarterTurns: quarterTurns,
      child: child,
    );
  }
}

class PaddingModifier extends SingleChildStatelessModifier {
  const PaddingModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.padding,
  }) : super(key: key, child: child);

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

class AlignModifier extends SingleChildStatelessModifier {
  const AlignModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0),
        super(key: key, child: child);

  final AlignmentGeometry alignment;
  final double? widthFactor;
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

class CenterModifier extends AlignModifier {
  const CenterModifier({
    Key? key,
    Key? modifiedKey,
    double? widthFactor,
    double? heightFactor,
    Widget? child,
  }) : super(
          key: key,
          modifierKey: modifiedKey,
          alignment: Alignment.center,
          child: child,
          heightFactor: heightFactor,
          widthFactor: widthFactor,
        );
}

class CustomSingleChildLayoutModifier extends SingleChildStatelessModifier {
  const CustomSingleChildLayoutModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.delegate,
  }) : super(key: key, child: child);

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

class LayoutIdModifier extends SingleChildStatelessModifier {
  const LayoutIdModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.id,
  }) : super(key: key, child: child);

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

class SizedBoxModifier extends SingleChildStatelessModifier {
  const SizedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.width,
    this.height,
  }) : super(
          key: key,
          child: child,
        );

  const SizedBoxModifier.expand({
    Key? key,
    Widget? child,
    super.modifierKey,
  })  : width = double.infinity,
        height = double.infinity,
        super(key: key, child: child);

  const SizedBoxModifier.shrink({
    Key? key,
    Widget? child,
    super.modifierKey,
  })  : width = 0.0,
        height = 0.0,
        super(key: key, child: child);

  SizedBoxModifier.fromSize(
      {Key? key, Widget? child, super.modifierKey, Size? size})
      : width = size?.width,
        height = size?.height,
        super(key: key, child: child);

  const SizedBoxModifier.square(
      {Key? key, Widget? child, super.modifierKey, double? dimension})
      : width = dimension,
        height = dimension,
        super(key: key, child: child);

  final double? width;
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizedBox(height: height, width: width, child: child);
  }
}

class ConstrainedBoxModifier extends SingleChildStatelessModifier {
  ConstrainedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.constraints,
  })  : assert(constraints.debugAssertIsValid()),
        super(key: key, child: child);

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

class ConstraintsTransformBoxModifier extends SingleChildStatelessModifier {
  const ConstraintsTransformBoxModifier({
    Key? key,
    Widget? child,
    this.textDirection,
    this.alignment = Alignment.center,
    required this.constraintsTransform,
    this.clipBehavior = Clip.none,
    String debugTransformType = '',
  })  : _debugTransformType = debugTransformType,
        super(key: key, child: child);

  final TextDirection? textDirection;

  final AlignmentGeometry alignment;

  final BoxConstraintsTransform constraintsTransform;

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

class UnconstrainedBoxModifier extends SingleChildStatelessModifier {
  const UnconstrainedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.textDirection,
    this.alignment = Alignment.center,
    this.constrainedAxis,
    this.clipBehavior = Clip.none,
  }) : super(key: key, child: child);

  final TextDirection? textDirection;
  final AlignmentGeometry alignment;
  final Axis? constrainedAxis;
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

class FractionallySizedBoxModifier extends SingleChildStatelessModifier {
  const FractionallySizedBoxModifier({
    Key? key,
    Widget? child,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0),
        super(key: key, child: child);

  final double? widthFactor;
  final double? heightFactor;
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

class LimitedBoxModifier extends SingleChildStatelessModifier {
  const LimitedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  })  : assert(maxWidth >= 0.0),
        assert(maxHeight >= 0.0),
        super(key: key, child: child);

  final double maxWidth;
  final double maxHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LimitedBox(
      key: key,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      child: child,
    );
  }
}

class OverflowBoxModifier extends SingleChildStatelessModifier {
  const OverflowBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
  }) : super(key: key, child: child);

  final AlignmentGeometry alignment;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
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

class SizedOverflowBoxModifier extends SingleChildStatelessModifier {
  const SizedOverflowBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.size,
    this.alignment = Alignment.center,
  }) : super(key: key, child: child);

  final AlignmentGeometry alignment;
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

class OffstageModifier extends SingleChildStatelessModifier {
  const OffstageModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.offstage = true,
  }) : super(key: key, child: child);

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

class AspectRatioModifier extends SingleChildStatelessModifier {
  const AspectRatioModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.aspectRatio,
  })  : assert(aspectRatio > 0.0),
        super(key: key, child: child);

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

class IntrinsicWidthModifier extends SingleChildStatelessModifier {
  const IntrinsicWidthModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.stepWidth,
    this.stepHeight,
  })  : assert(stepWidth == null || stepWidth >= 0.0),
        assert(stepHeight == null || stepHeight >= 0.0),
        super(key: key, child: child);

  final double? stepWidth;
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

class IntrinsicHeightModifier extends SingleChildStatelessModifier {
  const IntrinsicHeightModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IntrinsicHeight(
      key: modifierKey,
      child: child,
    );
  }
}

class BaselineModifier extends SingleChildStatelessModifier {
  const BaselineModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.baseline,
    required this.baselineType,
  }) : super(key: key, child: child);

  final double baseline;
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

class SliverToBoxAdapterModifier extends SingleChildStatelessModifier {
  const SliverToBoxAdapterModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverToBoxAdapter(key: modifierKey, child: child);
  }
}

class SliverPaddingModifier extends SingleChildStatelessModifier {
  const SliverPaddingModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.padding,
  }) : super(key: key, child: child);

  final EdgeInsetsGeometry padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverPadding(
      padding: padding,
      sliver: child,
    );
  }
}

class PositionedModifier extends SingleChildStatelessModifier {
  const PositionedModifier({
    Key? key,
    Widget? child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null),
        super(key: key, child: child);

  PositionedModifier.fromRect({
    Key? key,
    Widget? child,
    required Rect rect,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null,
        super(key: key, child: child);

  PositionedModifier.fromRelativeRect({
    Key? key,
    Widget? child,
    required RelativeRect rect,
  })  : left = rect.left,
        top = rect.top,
        right = rect.right,
        bottom = rect.bottom,
        width = null,
        height = null,
        super(key: key, child: child);

  const PositionedModifier.fill({
    Key? key,
    Widget? child,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  })  : width = null,
        height = null,
        super(key: key, child: child);

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

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return Positioned(
      key: key,
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

class PositionedDirectionalModifier extends SingleChildStatelessModifier {
  const PositionedDirectionalModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
  }) : super(key: key, child: child);

  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final double? width;
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

class FlexibleModifier extends SingleChildStatelessModifier {
  const FlexibleModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.flex = 1,
    this.fit = FlexFit.loose,
  }) : super(key: key, child: child);

  final int flex;
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

class ExpandedModifier extends FlexibleModifier {
  const ExpandedModifier({
    Key? key,
    Widget? child,
    int? flex,
  }) : super(fit: FlexFit.tight, key: key, child: child, flex: flex ?? 1);
}

class ListenerModifier extends SingleChildStatelessModifier {
  const ListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerSignal,
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;
  final PointerMoveEventListener? onPointerMove;
  final PointerUpEventListener? onPointerUp;
  final PointerHoverEventListener? onPointerHover;
  final PointerCancelEventListener? onPointerCancel;
  final PointerSignalEventListener? onPointerSignal;

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

class MouseRegionModifier extends SingleChildStatelessModifier {
  const MouseRegionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
  }) : super(key: key, child: child);

  final PointerEnterEventListener? onEnter;
  final PointerHoverEventListener? onHover;
  final PointerExitEventListener? onExit;
  final MouseCursor cursor;
  final bool opaque;
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

class RepaintBoundaryModifier extends SingleChildStatelessModifier {
  const RepaintBoundaryModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  factory RepaintBoundaryModifier.wrap(Widget child, int childIndex) {
    final Key key = child.key != null
        ? ValueKey<Key>(child.key!)
        : ValueKey<int>(childIndex);
    return RepaintBoundaryModifier(key: key, child: child);
  }

  static List<RepaintBoundaryModifier> wrapAll(List<Widget> widgets) =>
      <RepaintBoundaryModifier>[
        for (int i = 0; i < widgets.length; ++i)
          RepaintBoundaryModifier.wrap(widgets[i], i),
      ];

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RepaintBoundary(
      key: modifierKey,
      child: child,
    );
  }
}

class IgnorePointerModifier extends SingleChildStatelessModifier {
  const IgnorePointerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.ignoring = true,
    this.ignoringSemantics,
  }) : super(key: key, child: child);

  final bool ignoring;
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

class AbsorbPointerModifier extends SingleChildStatelessModifier {
  const AbsorbPointerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.absorbing = true,
    this.ignoringSemantics,
  }) : super(key: key, child: child);

  final bool absorbing;
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

class MetaDataModifier extends SingleChildStatelessModifier {
  const MetaDataModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.metaData,
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(key: key, child: child);

  final dynamic metaData;
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

class SemanticsModifier extends SingleChildStatelessModifier {
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

  const SemanticsModifier.fromProperties({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.container = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    required this.properties,
  }) : super(key: key, child: child);

  final SemanticsProperties properties;
  final bool container;
  final bool explicitChildNodes;
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

class MergeSemanticsModifier extends SingleChildStatelessModifier {
  const MergeSemanticsModifier({Key? key, Widget? child, super.modifierKey})
      : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MergeSemantics(key: modifierKey, child: child);
  }
}

class BlockSemanticsModifier extends SingleChildStatelessModifier {
  const BlockSemanticsModifier(
      {Key? key, super.modifierKey, this.blocking = true, Widget? child})
      : super(key: key, child: child);

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

class ExcludeSemanticsModifier extends SingleChildStatelessModifier {
  const ExcludeSemanticsModifier({
    Key? key,
    super.modifierKey,
    this.excluding = true,
    Widget? child,
  }) : super(key: key, child: child);

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

class IndexedSemanticsModifier extends SingleChildStatelessModifier {
  const IndexedSemanticsModifier({
    Key? key,
    super.modifierKey,
    required this.index,
    Widget? child,
  }) : super(key: key, child: child);

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

class KeyedSubtreeModifier extends SingleChildStatelessModifier {
  const KeyedSubtreeModifier({
    Key? key,
    required this.child,
  }) : super(key: key);

  factory KeyedSubtreeModifier.wrap(Widget child, int childIndex) {
    final Key key = child.key != null
        ? ValueKey<Key>(child.key!)
        : ValueKey<int>(childIndex);
    return KeyedSubtreeModifier(key: key, child: child);
  }

  final Widget child;

  static List<Widget> ensureUniqueKeysForList(List<Widget> items,
      {int baseIndex = 0}) {
    if (items.isEmpty) return items;

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

typedef SingleChildWidgetBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

class BuilderModifier extends SingleChildStatelessModifier {
  const BuilderModifier({super.key, required this.builder});

  final SingleChildWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      builder(context, child);
}

typedef SingleChildStatefulWidgetBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
  Widget? child,
);

class StatefulBuilderModifier extends SingleChildStatefulModifier {
  const StatefulBuilderModifier({
    super.key,
    super.modifierKey,
    required this.builder,
  });

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

class ColoredBoxModifier extends SingleChildStatelessModifier {
  const ColoredBoxModifier(
      {required this.color, super.modifierKey, Widget? child, Key? key})
      : super(key: key, child: child);

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
