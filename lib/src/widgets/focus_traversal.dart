import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class FocusTraversalGroupModifier extends SingleChildStatelessModifier {
  FocusTraversalGroupModifier({
    super.key,
    super.child,
    super.modifierKey,
    FocusTraversalPolicy? policy,
    this.descendantsAreFocusable = true,
    this.descendantsAreTraversable = true,
  }) : policy = policy ?? ReadingOrderTraversalPolicy();

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

class FocusTraversalOrderModifier extends SingleChildStatelessModifier {
  const FocusTraversalOrderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.order,
  });

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

class ExcludeFocusTraversalModifier extends SingleChildStatelessModifier {
  const ExcludeFocusTraversalModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.excluding = true,
  });

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
