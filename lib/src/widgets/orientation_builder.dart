import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef OrientationModifierBuilder = Widget Function(
  BuildContext context,
  Orientation orientation,
  Widget? child,
);

class OrientationBuilderModifier extends SingleChildStatelessWidget {
  const OrientationBuilderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.builder,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final OrientationModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OrientationBuilder(
      key: modifierKey,
      builder: (context, orientation) => builder(context, orientation, child),
    );
  }
}
