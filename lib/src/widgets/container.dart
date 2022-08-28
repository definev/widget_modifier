import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DecoratedBoxModifier extends SingleChildStatelessWidget {
  const DecoratedBoxModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.decoration,
    this.position = DecorationPosition.background,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Decoration decoration;
  final DecorationPosition position;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DecoratedBox(
      key: modifierKey,
      decoration: decoration,
      position: position,
      child: child,
    );
  }
}

class ContainerModifier extends SingleChildStatelessWidget {
  const ContainerModifier({
    Key? key,
    Widget? child,
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
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(
      key: modifierKey,
      alignment: alignment,
      clipBehavior: clipBehavior,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      height: height,
      width: width,
      constraints: constraints,
      margin: margin,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
    );
  }
}
