import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class DisplayFeatureSubScreenModifier extends SingleChildStatelessModifier {
  const DisplayFeatureSubScreenModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.anchorPoint,
  });

  final Offset? anchorPoint;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DisplayFeatureSubScreen(
      key: modifierKey,
      anchorPoint: anchorPoint,
      child: child!,
    );
  }
}
