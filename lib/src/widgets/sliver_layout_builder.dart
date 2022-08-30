import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef SliverLayoutWidgetModifierBuilder = Widget Function(
  BuildContext context,
  SliverConstraints constraints,
  Widget? child,
);

class SliverLayoutBuilderModifier extends SingleChildStatelessWidget {
  const SliverLayoutBuilderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final SliverLayoutWidgetModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverLayoutBuilder(
      key: modifierKey,
      builder: (context, constraints) => builder(context, constraints, child),
    );
  }
}
