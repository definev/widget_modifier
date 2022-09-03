import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class DualTransitionBuilderModifier extends SingleChildStatelessModifier {
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
