import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

typedef OrientationModifierBuilder = Widget Function(
  BuildContext context,
  Orientation orientation,
  Widget? child,
);

class OrientationBuilderModifier extends SingleChildStatelessModifier {
  const OrientationBuilderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final OrientationModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OrientationBuilder(
      key: modifierKey,
      builder: (context, orientation) => builder(context, orientation, child),
    );
  }
}
