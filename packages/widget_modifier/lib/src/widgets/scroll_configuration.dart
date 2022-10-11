import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Controls how [Scrollable] widgets behave in a subtree.
///
/// The scroll configuration determines the [ScrollPhysics] and viewport
/// decorations used by descendants of [child].
class ScrollConfigurationModifier extends SingleChildStatelessModifier {
  /// Creates a widget that controls how [Scrollable] widgets behave in a subtree.
  ///
  /// The [behavior] and [child] arguments must not be null.
  const ScrollConfigurationModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.behavior,
  });

  /// How [Scrollable] widgets that are descendants of [child] should behave.
  final ScrollBehavior behavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScrollConfiguration(
      key: modifierKey,
      behavior: behavior,
      child: child!,
    );
  }
}
