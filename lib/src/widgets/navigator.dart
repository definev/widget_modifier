import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class HeroControllerScopeModifier extends SingleChildStatelessWidget {
  const HeroControllerScopeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.controller,
  }) : super(key: key, child: child);

  const HeroControllerScopeModifier.none({
    Key? key,
    Widget? child,
    this.modifierKey,
  })  : controller = null,
        super(key: key, child: child);

  final Key? modifierKey;
  final HeroController? controller;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return HeroControllerScope(
      key: modifierKey,
      controller: controller ?? HeroControllerScope.of(context)!,
      child: child!,
    );
  }
}
