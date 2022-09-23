import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef SliverLayoutWidgetModifierBuilder = Widget Function(
  BuildContext context,
  SliverConstraints constraints,
  Widget? child,
);

class SliverLayoutBuilderModifier extends SingleChildStatelessModifier {
  const SliverLayoutBuilderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final SliverLayoutWidgetModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverLayoutBuilder(
      key: modifierKey,
      builder: (context, constraints) => builder(context, constraints, child),
    );
  }
}
