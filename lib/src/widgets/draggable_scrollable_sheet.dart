import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DraggableScrollableActuatorModifier extends SingleChildStatelessWidget {
  const DraggableScrollableActuatorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DraggableScrollableActuator(key: modifierKey, child: child!);
  }
}
