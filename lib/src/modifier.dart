import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';

class Modifier extends Nested {
  Modifier({
    required List<SingleChildWidget> modifiers,
    super.key,
    super.child,
  }) : super(children: modifiers);
}

typedef SingleChildModifier = SingleChildWidget;

abstract class SingleChildStatelessModifier extends SingleChildStatelessWidget {
  const SingleChildStatelessModifier({
    super.key,
    super.child,
    this.modifierKey,
  });

  final Key? modifierKey;
}

abstract class SingleChildStatefulModifier extends SingleChildStatefulWidget {
  const SingleChildStatefulModifier({
    super.key,
    super.child,
    this.modifierKey,
  });

  final Key? modifierKey;
}
