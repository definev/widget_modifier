import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nested/nested.dart';

/// Learn more at [Opacity]
class OpacityModifier extends SingleChildStatelessWidget {
  const OpacityModifier({
    super.key,
    this.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    super.child,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  final Key? modifierKey;
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

/// Learn more at [ShaderMask]
class ShaderMaskModifier extends SingleChildStatelessWidget {
  const ShaderMaskModifier({
    super.key,
    this.modifierKey,
    required this.shaderCallback,
    this.blendMode = BlendMode.modulate,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [BackdropFilter]
class BackdropFilterModifier extends SingleChildStatelessWidget {
  const BackdropFilterModifier({
    super.key,
    this.modifierKey,
    required this.filter,
    super.child,
    this.blendMode = BlendMode.srcOver,
  });

  final Key? modifierKey;
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

/// Learn more at [CustomPaint]
class CustomPaintModifier extends SingleChildStatelessWidget {
  const CustomPaintModifier({
    super.key,
    this.modifierKey,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
    super.child,
  }) : assert(painter != null ||
            foregroundPainter != null ||
            (!isComplex && !willChange));

  final Key? modifierKey;
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

/// Learn more at [ClipRect]
class ClipRectModifier extends SingleChildStatelessWidget {
  const ClipRectModifier({
    super.key,
    this.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.hardEdge,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [ClipRRect]
class ClipRRectModifier extends SingleChildStatelessWidget {
  const ClipRRectModifier({
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  }) : assert(borderRadius != null || clipper != null);

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

/// Learn more at [ClipOval]
class ClipOvalModifier extends SingleChildStatelessWidget {
  const ClipOvalModifier({
    super.key,
    this.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [ClipPath]
class ClipPathModifier extends SingleChildStatelessWidget {
  const ClipPathModifier({
    super.key,
    this.modifierKey,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  });

  static Widget shape({
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

  final Key? modifierKey;
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

/// Learn more at [PhysicalModel]
class PhysicalModelModifier extends SingleChildStatelessWidget {
  const PhysicalModelModifier({
    super.key,
    this.modfierKey,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
    super.child,
  }) : assert(elevation >= 0.0);

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

/// Learn more at [PhysicalShape]
class PhysicalShapeModifier extends SingleChildStatelessWidget {
  const PhysicalShapeModifier({
    super.key,
    this.modifierKey,
    required this.clipper,
    this.clipBehavior = Clip.none,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
    super.child,
  }) : assert(elevation >= 0.0);

  final Key? modifierKey;
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

/// Learn more at [Transform]
class TransformModifier extends SingleChildStatelessWidget {
  const TransformModifier({
    super.key,
    this.modifierKey,
    required this.transform,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  });

  TransformModifier.rotate({
    super.key,
    this.modifierKey,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  }) : transform = _computeRotation(angle);

  TransformModifier.translate({
    super.key,
    this.modifierKey,
    required Offset offset,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
        origin = null,
        alignment = null;

  TransformModifier.scale({
    super.key,
    this.modifierKey,
    double? scale,
    double? scaleX,
    double? scaleY,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  })  : assert(!(scale == null && scaleX == null && scaleY == null),
            "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null"),
        assert(scale == null || (scaleX == null && scaleY == null),
            "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null"),
        transform = Matrix4.diagonal3Values(
            scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0);

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

  final Key? modifierKey;

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

/// Learn more at [CompositedTransformTarget]
class CompositedTransformTargetModifier extends SingleChildStatelessWidget {
  const CompositedTransformTargetModifier({
    super.key,
    required this.link,
    super.child,
  });

  final LayerLink link;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CompositedTransformTarget(
      link: link,
      child: child,
    );
  }
}

/// Learn more at [CompositedTransformFollower]
class CompositedTransformFollowerModifier extends SingleChildStatelessWidget {
  const CompositedTransformFollowerModifier({
    super.key,
    this.modifierKey,
    required this.link,
    this.showWhenUnlinked = true,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [FittedBox]
class FittedBoxModifier extends SingleChildStatelessWidget {
  const FittedBoxModifier({
    super.key,
    this.modifierKey,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [FractionalTranslation]
class FractionalTranslationModifier extends SingleChildStatelessWidget {
  const FractionalTranslationModifier({
    super.key,
    this.modifierKey,
    required this.translation,
    this.transformHitTests = true,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [RotatedBox]
class RotatedBoxModifier extends SingleChildStatelessWidget {
  const RotatedBoxModifier({
    super.key,
    this.modifierKey,
    required this.quarterTurns,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [Padding]
class PaddingModifier extends SingleChildStatelessWidget {
  const PaddingModifier({
    super.key,
    this.modifierKey,
    required this.padding,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [Align]
class AlignModifier extends SingleChildStatelessWidget {
  const AlignModifier({
    super.key,
    this.modifierKey,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    super.child,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0);

  final Key? modifierKey;
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
  const CenterModifier(
      {super.key, super.widthFactor, super.heightFactor, super.child});
}

/// Learn more at [CustomSingleChildLayout]
class CustomSingleChildLayoutModifier extends SingleChildStatelessWidget {
  const CustomSingleChildLayoutModifier({
    super.key,
    this.modifierKey,
    required this.delegate,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [LayoutId]
class LayoutIdModifier extends SingleChildStatelessWidget {
  const LayoutIdModifier({
    super.key,
    this.modifierKey,
    required this.id,
  });

  final Key? modifierKey;
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

/// Learn more at [SizedBox]
class SizedBoxModifier extends SingleChildStatelessWidget {
  const SizedBoxModifier(
      {super.key, this.modifierKey, this.width, this.height, super.child});

  const SizedBoxModifier.expand({super.key, this.modifierKey, super.child})
      : width = double.infinity,
        height = double.infinity;

  const SizedBoxModifier.shrink({super.key, this.modifierKey, super.child})
      : width = 0.0,
        height = 0.0;

  SizedBoxModifier.fromSize(
      {super.key, this.modifierKey, super.child, Size? size})
      : width = size?.width,
        height = size?.height;

  const SizedBoxModifier.square(
      {super.key, this.modifierKey, super.child, double? dimension})
      : width = dimension,
        height = dimension;

  final Key? modifierKey;
  final double? width;
  final double? height;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizedBox(height: height, width: width, child: child);
  }
}

/// Learn more at [ConstrainedBox]
class ConstrainedBoxModifier extends SingleChildStatelessWidget {
  ConstrainedBoxModifier({
    super.key,
    this.modifierKey,
    required this.constraints,
    super.child,
  }) : assert(constraints.debugAssertIsValid());

  final Key? modifierKey;
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

/// Learn more at [ConstraintsTransformBox]
class ConstraintsTransformBoxModifier extends SingleChildStatelessWidget {
  const ConstraintsTransformBoxModifier({
    super.key,
    super.child,
    this.textDirection,
    this.alignment = Alignment.center,
    required this.constraintsTransform,
    this.clipBehavior = Clip.none,
    String debugTransformType = '',
  }) : _debugTransformType = debugTransformType;

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

/// Learn more at [UnconstrainedBox]
class UnconstrainedBoxModifier extends SingleChildStatelessWidget {
  const UnconstrainedBoxModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.textDirection,
    this.alignment = Alignment.center,
    this.constrainedAxis,
    this.clipBehavior = Clip.none,
  });

  final Key? modifierKey;
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

/// Learn more at [FractionallySizedBox]
class FractionallySizedBoxModifier extends SingleChildStatelessWidget {
  const FractionallySizedBoxModifier({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    super.child,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0);

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

/// Learn more at [LimitedBox]
class LimitedBoxModifier extends SingleChildStatelessWidget {
  const LimitedBoxModifier({
    super.key,
    this.modifierKey,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    super.child,
  })  : assert(maxWidth >= 0.0),
        assert(maxHeight >= 0.0);

  final Key? modifierKey;
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

/// Learn more at [OverflowBox]
class OverflowBoxModifier extends SingleChildStatelessWidget {
  const OverflowBoxModifier({
    super.key,
    this.modifierKey,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [SizedOverflowBox]
class SizedOverflowBoxModifier extends SingleChildStatelessWidget {
  const SizedOverflowBoxModifier({
    super.key,
    this.modifierKey,
    required this.size,
    this.alignment = Alignment.center,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [Offstage]
class OffstageModifier extends SingleChildStatelessWidget {
  const OffstageModifier({
    super.key,
    this.modifierKey,
    this.offstage = true,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [AspectRatio]
class AspectRatioModifier extends SingleChildStatelessWidget {
  const AspectRatioModifier({
    super.key,
    this.modifierKey,
    required this.aspectRatio,
    super.child,
  }) : assert(aspectRatio > 0.0);

  final Key? modifierKey;
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

/// Learn more at [IntrinsicWidth]
class IntrinsicWidthModifier extends SingleChildStatelessWidget {
  const IntrinsicWidthModifier({
    super.key,
    this.modifierKey,
    this.stepWidth,
    this.stepHeight,
    super.child,
  })  : assert(stepWidth == null || stepWidth >= 0.0),
        assert(stepHeight == null || stepHeight >= 0.0);

  final Key? modifierKey;
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

/// Learn more at [IntrinsicHeight]
class IntrinsicHeightModifier extends SingleChildStatelessWidget {
  const IntrinsicHeightModifier({super.key, this.modifierKey, super.child});

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IntrinsicHeight(
      key: modifierKey,
      child: child,
    );
  }
}

/// Learn more at [Baseline]
class BaselineModifier extends SingleChildStatelessWidget {
  const BaselineModifier({
    super.key,
    this.modifierKey,
    required this.baseline,
    required this.baselineType,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [SliverToBoxAdapter]
class SliverToBoxAdapterModifier extends SingleChildStatelessWidget {
  const SliverToBoxAdapterModifier({super.key, this.modifierKey, super.child});

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverToBoxAdapter(key: modifierKey, child: child);
  }
}

/// Learn more at [SliverPadding]
class SliverPaddingModifier extends SingleChildStatelessWidget {
  const SliverPaddingModifier({
    super.key,
    this.modifierKey,
    required this.padding,
  });

  final Key? modifierKey;
  final EdgeInsetsGeometry padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverPadding(
      padding: padding,
      sliver: child,
    );
  }
}

/// Learn more at [Positioned]
class PositionedModifier extends SingleChildStatelessWidget {
  const PositionedModifier({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null);

  PositionedModifier.fromRect({
    super.key,
    required Rect rect,
    required super.child,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null;

  PositionedModifier.fromRelativeRect({
    super.key,
    required RelativeRect rect,
    required super.child,
  })  : left = rect.left,
        top = rect.top,
        right = rect.right,
        bottom = rect.bottom,
        width = null,
        height = null;

  const PositionedModifier.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    required super.child,
  })  : width = null,
        height = null;

  factory PositionedModifier.directional({
    Key? key,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
    required Widget child,
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

/// Learn more at [PositionedDirectional]
class PositionedDirectionalModifier extends SingleChildStatelessWidget {
  const PositionedDirectionalModifier({
    super.key,
    this.modifierKey,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
    required this.child,
  });

  final Key? modifierKey;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final double? width;
  final double? height;
  final Widget child;

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

/// Learn more at [Flexible]
class FlexibleModifier extends SingleChildStatelessWidget {
  const FlexibleModifier({
    super.key,
    this.modifierKey,
    this.flex = 1,
    this.fit = FlexFit.loose,
    required super.child,
  });

  final Key? modifierKey;
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

class ExpandedModifier extends Flexible {
  const ExpandedModifier({
    super.key,
    super.flex,
    required super.child,
  }) : super(fit: FlexFit.tight);
}

/// Learn more at [Listener]
class ListenerModifier extends SingleChildStatelessWidget {
  const ListenerModifier({
    super.key,
    this.modifierKey,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerSignal,
    this.behavior = HitTestBehavior.deferToChild,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [MouseRegion]
class MouseRegionModifier extends SingleChildStatelessWidget {
  const MouseRegionModifier({
    super.key,
    this.modifierKey,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [RepaintBoundary]
class RepaintBoundaryModifier extends SingleChildStatelessWidget {
  const RepaintBoundaryModifier({super.key, this.modifierKey, super.child});

  final Key? modifierKey;

  factory RepaintBoundaryModifier.wrap(Widget child, int childIndex) {
    assert(child != null);
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

/// Learn more at [IgnorePointer]
class IgnorePointerModifier extends SingleChildStatelessWidget {
  const IgnorePointerModifier({
    super.key,
    this.modifierKey,
    this.ignoring = true,
    this.ignoringSemantics,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [AbsorbPointer]
class AbsorbPointerModifier extends SingleChildStatelessWidget {
  const AbsorbPointerModifier({
    super.key,
    this.modifierKey,
    this.absorbing = true,
    super.child,
    this.ignoringSemantics,
  });
  final Key? modifierKey;
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

/// Learn more at [MetaData]
class MetaDataModifier extends SingleChildStatelessWidget {
  const MetaDataModifier({
    super.key,
    this.modifierKey,
    this.metaData,
    this.behavior = HitTestBehavior.deferToChild,
    super.child,
  });

  final Key? modifierKey;
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

/// Learn more at [Semantics]
class SemanticsModifier extends SingleChildStatelessWidget {
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
    this.modifierKey,
    this.container = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    required this.properties,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

/// Learn more at [MergeSemantics]
class MergeSemanticsModifier extends SingleChildStatelessWidget {
  const MergeSemanticsModifier({Key? key, Widget? child, this.modifierKey})
      : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MergeSemantics(key: modifierKey, child: child);
  }
}

/// Learn more at [BlockSemantics]
class BlockSemanticsModifier extends SingleChildStatelessWidget {
  const BlockSemanticsModifier(
      {Key? key, this.modifierKey, this.blocking = true, Widget? child})
      : super(key: key, child: child);

  final Key? modifierKey;
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

/// Learn more at [ExcludeSemantics]
class ExcludeSemanticsModifier extends SingleChildStatelessWidget {
  const ExcludeSemanticsModifier({
    Key? key,
    this.modifierKey,
    this.excluding = true,
    Widget? child,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

/// Learn more at [IndexedSemantics]
class IndexedSemanticsModifier extends SingleChildStatelessWidget {
  const IndexedSemanticsModifier({
    Key? key,
    this.modifierKey,
    required this.index,
    Widget? child,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

/// Learn more at [KeyedSubtree]
class KeyedSubtreeModifier extends SingleChildStatelessWidget {
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

/// Learn more at [ColoredBox]
class ColoredBoxModifier extends SingleChildStatelessWidget {
  const ColoredBoxModifier(
      {required this.color, this.modifierKey, Widget? child, Key? key})
      : super(key: key, child: child);

  final Key? modifierKey;
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
