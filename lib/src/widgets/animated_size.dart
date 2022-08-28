import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class AnimatedSizeModifier extends SingleChildStatelessWidget {
  const AnimatedSizeModifier({
    Key? key,
    this.modifierKey,
    this.child,
    this.alignment = Alignment.center,
    this.curve = Curves.linear,
    required this.duration,
    this.reverseDuration,
    @Deprecated('This field is now ignored. '
        'This feature was deprecated after v2.2.0-10.1.pre.')
        TickerProvider? vsync,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  final Key? modifierKey;
  final Widget? child;
  final AlignmentGeometry alignment;
  final Curve curve;
  final Duration duration;
  final Duration? reverseDuration;
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedSize(
      duration: duration,
      key: modifierKey,
      alignment: alignment,
      clipBehavior: clipBehavior,
      curve: curve,
      reverseDuration: reverseDuration,
      child: child,
    );
  }
}
