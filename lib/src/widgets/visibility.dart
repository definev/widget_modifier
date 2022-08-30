import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class VisibilityModifier extends SingleChildStatelessWidget {
  const VisibilityModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.replacement = const SizedBox.shrink(),
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
  }) : super(key: key);

  final Key? modifierKey;
  final Widget replacement;
  final bool visible;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Visibility(
      key: modifierKey,
      maintainAnimation: maintainAnimation,
      maintainInteractivity: maintainInteractivity,
      maintainSemantics: maintainSemantics,
      maintainSize: maintainSize,
      maintainState: maintainState,
      replacement: replacement,
      visible: visible,
      child: child!,
    );
  }
}

class SliverVisibilityModifier extends SingleChildStatelessWidget {
  const SliverVisibilityModifier({
    Key? key,
    Widget? sliver,
    this.modifierKey,
    this.replacementSliver = const SliverToBoxAdapter(),
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
  }) : super(key: key, child: sliver);

  final Key? modifierKey;
  final Widget replacementSliver;
  final bool visible;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverVisibility(
      key: modifierKey,
      maintainAnimation: maintainAnimation,
      maintainInteractivity: maintainInteractivity,
      maintainSemantics: maintainSemantics,
      maintainSize: maintainSize,
      maintainState: maintainState,
      replacementSliver: replacementSliver,
      visible: visible,
      sliver: child!,
    );
  }
}
