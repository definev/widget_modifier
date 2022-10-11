import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// An inherited widget to host a hero controller.
///
/// The hosted hero controller will be picked up by the navigator in the
/// [child] subtree. Once a navigator picks up this controller, the navigator
/// will bar any navigator below its subtree from receiving this controller.
///
/// The hero controller inside the [HeroControllerScope] can only subscribe to
/// one navigator at a time. An assertion will be thrown if the hero controller
/// subscribes to more than one navigators. This can happen when there are
/// multiple navigators under the same [HeroControllerScope] in parallel.
class HeroControllerScopeModifier extends SingleChildStatelessModifier {
  /// Creates a widget to host the input [controller].
  const HeroControllerScopeModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.controller,
  });

  /// Creates a widget to prevent the subtree from receiving the hero controller
  /// above.
  const HeroControllerScopeModifier.none({
    super.key,
    super.child,
    super.modifierKey,
  }) : controller = null;

  /// The hero controller that is hosted inside this widget.
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
