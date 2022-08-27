import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class ActionListenerModifier extends SingleChildStatelessWidget {
  const ActionListenerModifier({
    Key? key,
    required this.listener,
    required this.action,
    required this.child,
  }) : super(key: key);

  final ActionListenerCallback listener;

  final Action<Intent> action;

  final Widget child;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ActionListener(listener: listener, action: action, child: child!);
  }
}

class ActionsModifier extends SingleChildStatelessWidget {
  const ActionsModifier({
    Key? key,
    this.dispatcher,
    required this.actions,
    required this.child,
  }) : super(key: key);

  final ActionDispatcher? dispatcher;
  final Map<Type, Action<Intent>> actions;
  final Widget child;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Actions(actions: actions, child: child!);
  }
}
