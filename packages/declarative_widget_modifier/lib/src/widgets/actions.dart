import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class ActionListenerModifier extends SingleChildStatelessModifier {
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

class ActionsModifier extends SingleChildStatelessModifier {
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

class FocusableActionDetectorModifier extends SingleChildStatelessModifier {
  const FocusableActionDetectorModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.descendantsAreFocusable = true,
    this.descendantsAreTraversable = true,
    this.shortcuts,
    this.actions,
    this.onShowFocusHighlight,
    this.onShowHoverHighlight,
    this.onFocusChange,
    this.mouseCursor = MouseCursor.defer,
  }) : super(key: key, child: child);

  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool descendantsAreFocusable;
  final bool descendantsAreTraversable;
  final Map<Type, Action<Intent>>? actions;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final ValueChanged<bool>? onShowFocusHighlight;
  final ValueChanged<bool>? onShowHoverHighlight;
  final ValueChanged<bool>? onFocusChange;
  final MouseCursor mouseCursor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FocusableActionDetector(
      key: modifierKey,
      actions: actions,
      autofocus: autofocus,
      descendantsAreFocusable: descendantsAreFocusable,
      descendantsAreTraversable: descendantsAreTraversable,
      enabled: enabled,
      focusNode: focusNode,
      mouseCursor: mouseCursor,
      onFocusChange: onFocusChange,
      onShowFocusHighlight: onShowFocusHighlight,
      onShowHoverHighlight: onShowHoverHighlight,
      shortcuts: shortcuts,
      child: child!,
    );
  }
}
