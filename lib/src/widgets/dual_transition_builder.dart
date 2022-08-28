import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DualTransitionBuilderModifier extends SingleChildStatelessWidget {
  const DualTransitionBuilderModifier({
    Key? key,
    Widget? child,
    required this.animation,
    required this.forwardBuilder,
    required this.reverseBuilder,
  }) : super(key: key, child: child);

  final Animation<double> animation;
  final AnimatedTransitionBuilder forwardBuilder;
  final AnimatedTransitionBuilder reverseBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DualTransitionBuilder(
      animation: animation,
      forwardBuilder: forwardBuilder,
      reverseBuilder: reverseBuilder,
    );
  }
}
