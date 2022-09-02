import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class FocusTraversalGroupModifier extends SingleChildStatelessWidget {
  FocusTraversalGroupModifier({
    super.key,
    super.child,
    this.modifierKey,
    FocusTraversalPolicy? policy,
    this.descendantsAreFocusable = true,
    this.descendantsAreTraversable = true,
  }) : policy = policy ?? ReadingOrderTraversalPolicy();

  final Key? modifierKey;
  final FocusTraversalPolicy policy;
  final bool descendantsAreFocusable;
  final bool descendantsAreTraversable;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FocusTraversalGroup(
      key: modifierKey,
      descendantsAreFocusable: descendantsAreFocusable,
      descendantsAreTraversable: descendantsAreTraversable,
      policy: policy,
      child: child!,
    );
  }
}

class FocusTraversalOrderModifier extends SingleChildStatelessWidget {
  const FocusTraversalOrderModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.order,
  });

  final Key? modifierKey;
  final FocusOrder order;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FocusTraversalOrder(
      key: modifierKey,
      order: order,
      child: child!,
    );
  }
}

class ExcludeFocusTraversalModifier extends SingleChildStatelessWidget {
  const ExcludeFocusTraversalModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.excluding = true,
  });

  final Key? modifierKey;
  final bool excluding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ExcludeFocusTraversal(
      key: modifierKey,
      excluding: excluding,
      child: child!,
    );
  }
}
