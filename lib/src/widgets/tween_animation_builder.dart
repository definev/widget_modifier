import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class TweenAnimationBuilderModifier<T extends Object?>
    extends SingleChildStatelessWidget {
  const TweenAnimationBuilderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.tween,
    required this.duration,
    this.curve = Curves.linear,
    required this.builder,
    this.onEnd,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Tween<T> tween;
  final ValueWidgetBuilder<T> builder;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TweenAnimationBuilder(
      key: modifierKey,
      tween: tween,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      builder: builder,
      child: child,
    );
  }
}
