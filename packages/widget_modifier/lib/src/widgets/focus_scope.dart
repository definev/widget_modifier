import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class FocusModifier extends SingleChildStatelessModifier {
  const FocusModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.focusNode,
    this.autofocus = false,
    this.onFocusChange,
    this.includeSemantics = true,
    this.canRequestFocus,
    this.debugLabel,
    this.descendantsAreFocusable,
    this.descendantsAreTraversable,
    this.onKey,
    this.onKeyEvent,
    this.skipTraversal,
  }) : super(key: key, child: child);

  const factory FocusModifier.withExternalFocusNode({
    Key? key,
    required Widget child,
    required FocusNode focusNode,
    bool autofocus,
    ValueChanged<bool>? onFocusChange,
    bool includeSemantics,
  }) = _FocusWithExternalFocusNode;

  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;
  final FocusOnKeyEventCallback? onKeyEvent;
  final FocusOnKeyCallback? onKey;
  final bool? canRequestFocus;
  final bool? skipTraversal;
  final bool? descendantsAreFocusable;
  final bool? descendantsAreTraversable;
  final String? debugLabel;
  final bool includeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Focus(
      key: modifierKey,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      debugLabel: debugLabel,
      descendantsAreFocusable: descendantsAreFocusable,
      descendantsAreTraversable: descendantsAreTraversable,
      focusNode: focusNode,
      includeSemantics: includeSemantics,
      onFocusChange: onFocusChange,
      onKey: onKey,
      onKeyEvent: onKeyEvent,
      skipTraversal: skipTraversal,
      child: child!,
    );
  }
}

class FocusScopeModifier extends FocusModifier {
  const FocusScopeModifier({
    Key? key,
    FocusScopeNode? node,
    required Widget child,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    bool? canRequestFocus,
    bool? skipTraversal,
    FocusOnKeyEventCallback? onKeyEvent,
    FocusOnKeyCallback? onKey,
    String? debugLabel,
  }) : super(
          key: key,
          child: child,
          focusNode: node,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
          canRequestFocus: canRequestFocus,
          skipTraversal: skipTraversal,
          onKeyEvent: onKeyEvent,
          onKey: onKey,
          debugLabel: debugLabel,
        );

  const factory FocusScopeModifier.withExternalFocusNode({
    Key? key,
    required Widget child,
    required FocusScopeNode focusScopeNode,
    bool autofocus,
    ValueChanged<bool>? onFocusChange,
  }) = _FocusScopeWithExternalFocusNode;
}

class _FocusWithExternalFocusNode extends FocusModifier {
  const _FocusWithExternalFocusNode({
    Key? key,
    required Widget child,
    required FocusNode focusNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    bool includeSemantics = true,
  }) : super(
          key: key,
          child: child,
          focusNode: focusNode,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
          includeSemantics: includeSemantics,
        );
}

class _FocusScopeWithExternalFocusNode extends FocusScopeModifier {
  const _FocusScopeWithExternalFocusNode({
    Key? key,
    required Widget child,
    required FocusScopeNode focusScopeNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
  }) : super(
          key: key,
          child: child,
          node: focusScopeNode,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
        );
}
