import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class HeroControllerScopeModifier extends SingleChildStatelessModifier {
  const HeroControllerScopeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.controller,
  }) : super(key: key, child: child);

  const HeroControllerScopeModifier.none({
    Key? key,
    Widget? child,
    super.modifierKey,
  })  : controller = null,
        super(key: key, child: child);

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
