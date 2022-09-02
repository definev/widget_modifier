import 'package:nested/nested.dart';

class Modifier extends Nested {
  Modifier({
    required List<SingleChildWidget> modifiers,
    super.key,
    super.child,
  }) : super(children: modifiers);
}

typedef SingleChildModifier = SingleChildWidget;
