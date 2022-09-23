import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class SlideTransitionModifier extends SingleChildStatelessModifier {
  const SlideTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.position,
    this.transformHitTests = true,
    this.textDirection,
  }) : super(key: key, child: child);

  final Animation<Offset> position;
  final TextDirection? textDirection;
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

class ScaleTransitionModifier extends SingleChildStatelessModifier {
  const ScaleTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.scale,
    this.alignment = Alignment.center,
    this.filterQuality,
  }) : super(key: key, child: child);

  final Animation<double> scale;
  final Alignment alignment;
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

class RotationTransitionModifier extends SingleChildStatelessModifier {
  const RotationTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.turns,
    this.alignment = Alignment.center,
    this.filterQuality,
  }) : super(key: key, child: child);

  final Animation<double> turns;
  final Alignment alignment;
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

class SizeTransitionModifier extends SingleChildStatelessModifier {
  const SizeTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.axis = Axis.vertical,
    required this.sizeFactor,
    this.axisAlignment = 0.0,
  }) : super(key: key, child: child);

  final Axis axis;
  final Animation<double> sizeFactor;
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

class FadeTransitionModifier extends SingleChildStatelessModifier {
  const FadeTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(key: key, child: child);

  final Animation<double> opacity;
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

class SliverFadeTransitionModifier extends SingleChildStatelessModifier {
  const SliverFadeTransitionModifier({
    Key? key,
    Widget? sliver,
    super.modifierKey,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  }) : super(key: key, child: sliver);

  final Animation<double> opacity;
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

class PositionedTransitionModifier extends SingleChildStatelessModifier {
  const PositionedTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.rect,
  }) : super(key: key, child: child);

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

class RelativePositionedTransitionModifier extends SingleChildStatelessModifier {
  const RelativePositionedTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.rect,
    required this.size,
  }) : super(key: key, child: child);

  final Animation<Rect?> rect;
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

class DecoratedBoxTransitionModifier extends SingleChildStatelessModifier {
  const DecoratedBoxTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.decoration,
    this.position = DecorationPosition.background,
  }) : super(key: key, child: child);

  final Animation<Decoration> decoration;
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

class AlignTransitionModifier extends SingleChildStatelessModifier {
  const AlignTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.alignment,
    this.widthFactor,
    this.heightFactor,
  }) : super(key: key, child: child);

  final Animation<AlignmentGeometry> alignment;
  final double? widthFactor;
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

class DefaultTextStyleTransitionModifier extends SingleChildStatelessModifier {
  const DefaultTextStyleTransitionModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  }) : super(key: key, child: child);

  final Animation<TextStyle> style;
  final TextAlign? textAlign;
  final bool softWrap;
  final TextOverflow overflow;
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

class AnimatedBuilderModifier extends SingleChildStatelessModifier {
  const AnimatedBuilderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.animation,
    required this.builder,
  }) : super(key: key, child: child);

  final Listenable animation;
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
