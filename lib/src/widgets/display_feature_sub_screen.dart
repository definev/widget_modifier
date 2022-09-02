import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DisplayFeatureSubScreenModifier extends SingleChildStatelessWidget {
  const DisplayFeatureSubScreenModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.anchorPoint,
  });

  final Key? modifierKey;
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
