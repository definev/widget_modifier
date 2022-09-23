import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

typedef SingleChildLayoutWidgetBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints, Widget? child);

class LayoutBuilderModifier extends SingleChildStatelessModifier {
  const LayoutBuilderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final SingleChildLayoutWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LayoutBuilder(
      key: modifierKey,
      builder: (context, constraints) => builder(context, constraints, child),
    );
  }
}
