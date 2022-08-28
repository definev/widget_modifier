import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef SingleChildLayoutWidgetBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints, Widget? child);

class LayoutBuilderModifier extends SingleChildStatelessWidget {
  const LayoutBuilderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final SingleChildLayoutWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LayoutBuilder(
      key: modifierKey,
      builder: (context, constraints) => builder(context, constraints, child),
    );
  }
}
