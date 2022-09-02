import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

abstract class SingleChildImplicitlyAnimatedWidget
    extends SingleChildStatelessWidget {
  const SingleChildImplicitlyAnimatedWidget({
    Key? key,
    Widget? child,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : super(key: key, child: child);

  final Curve curve;
  final Duration duration;
  final VoidCallback? onEnd;
}

class AnimatedContainerModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedContainerModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
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
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final Color? color;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
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

class AnimatedPaddingModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedPaddingModifier({
    Key? key,
    Widget? child,
    required Duration duration,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.padding,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
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

class AnimatedAlignModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedAlignModifier({
    Key? key,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.alignment,
    this.child,
    this.heightFactor,
    this.widthFactor,
  }) : super(
          key: key,
          onEnd: onEnd,
          curve: curve,
          duration: duration,
          child: child,
        );

  final Key? modifierKey;
  final AlignmentGeometry alignment;
  final Widget? child;
  final double? heightFactor;
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

class AnimatedPositionedModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedPositionedModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  AnimatedPositionedModifier.fromRect({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required Rect rect,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null,
        super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
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

class AnimatedPositionedDirectionalModifier
    extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedPositionedDirectionalModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final double? width;
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

class AnimatedScaleModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedScaleModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.scale,
    this.alignment = Alignment.center,
    this.filterQuality,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final double scale;
  final Alignment alignment;
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

class AnimatedRotationModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedRotationModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.turns,
    this.alignment = Alignment.center,
    this.filterQuality,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final double turns;
  final Alignment alignment;
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

class AnimatedSlideModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedSlideModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.offset,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
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

class AnimatedOpacityModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedOpacityModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final double opacity;
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

class SliverAnimatedOpacityModifier
    extends SingleChildImplicitlyAnimatedWidget {
  const SliverAnimatedOpacityModifier({
    Key? key,
    Widget? sliver,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: sliver,
        );

  final Key? modifierKey;
  final double opacity;
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

class AnimatedDefaultTextStyleModifier
    extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedDefaultTextStyleModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final TextWidthBasis textWidthBasis;
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

class AnimatedPhysicalModelModifier
    extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedPhysicalModelModifier({
    Key? key,
    Widget? child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.modifierKey,
    required this.shape,
    this.clipBehavior = Clip.none,
    this.borderRadius = BorderRadius.zero,
    required this.elevation,
    required this.color,
    this.animateColor = true,
    required this.shadowColor,
    this.animateShadowColor = true,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  final Key? modifierKey;
  final BoxShape shape;
  final Clip clipBehavior;
  final BorderRadius borderRadius;
  final double elevation;
  final Color color;
  final bool animateColor;
  final Color shadowColor;
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

class AnimatedFractionallySizedBoxModifier
    extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedFractionallySizedBoxModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.alignment = Alignment.center,
    this.heightFactor,
    this.widthFactor,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  final Key? modifierKey;
  final double? heightFactor;
  final double? widthFactor;
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
