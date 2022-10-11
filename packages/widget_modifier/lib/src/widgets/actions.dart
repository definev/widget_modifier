import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A helper widget for making sure that listeners on an action are removed properly.
///
/// Listeners on the [Action] class must have their listener callbacks removed
/// with [Action.removeActionListener] when the listener is disposed of. This widget
/// helps with that, by providing a lifetime for the connection between the
/// [listener] and the [Action], and by handling the adding and removing of
/// the [listener] at the right points in the widget lifecycle.
///
/// If you listen to an [Action] widget in a widget hierarchy, you should use
/// this widget. If you are using an [Action] outside of a widget context, then
/// you must call removeListener yourself.
///
/// {@tool dartpad}
/// This example shows how ActionListener handles adding and removing of
/// the [listener] in the widget lifecycle.
///
/// ** See code in examples/api/lib/widgets/actions/action_listener.0.dart **
/// {@end-tool}
///
class ActionListenerModifier extends SingleChildStatelessModifier {
  /// Create a const [ActionListener].
  ///
  /// The [listener], [action], and [child] arguments must not be null.
  const ActionListenerModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.listener,
    required this.action,
  });

  /// The [ActionListenerCallback] callback to register with the [action].
  ///
  /// Must not be null.
  final ActionListenerCallback listener;

  /// The [Action] that the callback will be registered with.
  ///
  /// Must not be null.
  final Action<Intent> action;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ActionListener(
      key: modifierKey,
      listener: listener,
      action: action,
      child: child!,
    );
  }
}

/// A widget that establishes an [ActionDispatcher] and a map of [Intent] to
/// [Action] to be used by its descendants when invoking an [Action].
///
/// Actions are typically invoked using [Actions.invoke] with the context
/// containing the ambient [Actions] widget.
///
/// {@tool dartpad}
/// This example creates a custom [Action] subclass `ModifyAction` for modifying
/// a model, and another, `SaveAction` for saving it.
///
/// This example demonstrates passing arguments to the [Intent] to be carried to
/// the [Action]. Actions can get data either from their own construction (like
/// the `model` in this example), or from the intent passed to them when invoked
/// (like the increment `amount` in this example).
///
/// This example also demonstrates how to use Intents to limit a widget's
/// dependencies on its surroundings. The `SaveButton` widget defined in this
/// example can invoke actions defined in its ancestor widgets, which can be
/// customized to match the part of the widget tree that it is in. It doesn't
/// need to know about the `SaveAction` class, only the `SaveIntent`, and it
/// only needs to know about a value notifier, not the entire model.
///
/// ** See code in examples/api/lib/widgets/actions/actions.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ActionDispatcher], the object that this widget uses to manage actions.
///  * [Action], a class for containing and defining an invocation of a user
///    action.
///  * [Intent], a class that holds a unique [LocalKey] identifying an action,
///    as well as configuration information for running the [Action].
///  * [Shortcuts], a widget used to bind key combinations to [Intent]s.
class ActionsModifier extends SingleChildStatelessModifier {
  /// Creates an [Actions] widget.
  ///
  /// The [child], [actions], and [dispatcher] arguments must not be null.
  const ActionsModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.dispatcher,
    required this.actions,
  });

  /// The [ActionDispatcher] object that invokes actions.
  ///
  /// This is what is returned from [Actions.of], and used by [Actions.invoke].
  ///
  /// If this [dispatcher] is null, then [Actions.of] and [Actions.invoke] will
  /// look up the tree until they find an Actions widget that has a dispatcher
  /// set. If not such widget is found, then they will return/use a
  /// default-constructed [ActionDispatcher].
  final ActionDispatcher? dispatcher;

  /// {@template flutter.widgets.actions.actions}
  /// A map of [Intent] keys to [Action<Intent>] objects that defines which
  /// actions this widget knows about.
  ///
  /// For performance reasons, it is recommended that a pre-built map is
  /// passed in here (e.g. a final variable from your widget class) instead of
  /// defining it inline in the build function.
  /// {@endtemplate}
  final Map<Type, Action<Intent>> actions;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Actions(
      key: modifierKey,
      actions: actions,
      child: child!,
    );
  }
}

/// A widget that combines the functionality of [Actions], [Shortcuts],
/// [MouseRegion] and a [Focus] widget to create a detector that defines actions
/// and key bindings, and provides callbacks for handling focus and hover
/// highlights.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=R84AGg0lKs8}
///
/// This widget can be used to give a control the required detection modes for
/// focus and hover handling. It is most often used when authoring a new control
/// widget, and the new control should be enabled for keyboard traversal and
/// activation.
///
/// {@tool dartpad}
/// This example shows how keyboard interaction can be added to a custom control
/// that changes color when hovered and focused, and can toggle a light when
/// activated, either by touch or by hitting the `X` key on the keyboard when
/// the "And Me" button has the keyboard focus (be sure to use TAB to move the
/// focus to the "And Me" button before trying it out).
///
/// This example defines its own key binding for the `X` key, but in this case,
/// there is also a default key binding for [ActivateAction] in the default key
/// bindings created by [WidgetsApp] (the parent for [MaterialApp], and
/// [CupertinoApp]), so the `ENTER` key will also activate the buttons.
///
/// ** See code in examples/api/lib/widgets/actions/focusable_action_detector.0.dart **
/// {@end-tool}
///
/// This widget doesn't have any visual representation, it is just a detector that
/// provides focus and hover capabilities.
///
/// It hosts its own [FocusNode] or uses [focusNode], if given.
class FocusableActionDetectorModifier extends SingleChildStatelessModifier {
  /// Create a const [FocusableActionDetector].
  ///
  /// The [enabled], [autofocus], [mouseCursor], and [child] arguments must not be null.
  const FocusableActionDetectorModifier({
    super.key,
    super.child,
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
  });

  /// Is this widget enabled or not.
  ///
  /// If disabled, will not send any notifications needed to update highlight or
  /// focus state, and will not define or respond to any actions or shortcuts.
  ///
  /// When disabled, adds [Focus] to the widget tree, but sets
  /// [Focus.canRequestFocus] to false.
  final bool enabled;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.descendantsAreFocusable}
  final bool descendantsAreFocusable;

  /// {@macro flutter.widgets.Focus.descendantsAreTraversable}
  final bool descendantsAreTraversable;

  /// {@macro flutter.widgets.actions.actions}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.shortcuts.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// A function that will be called when the focus highlight should be shown or
  /// hidden.
  ///
  /// This method is not triggered at the unmount of the widget.
  final ValueChanged<bool>? onShowFocusHighlight;

  /// A function that will be called when the hover highlight should be shown or hidden.
  ///
  /// This method is not triggered at the unmount of the widget.
  final ValueChanged<bool>? onShowHoverHighlight;

  /// A function that will be called when the focus changes.
  ///
  /// Called with true if the [focusNode] has primary focus.
  final ValueChanged<bool>? onFocusChange;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// The [mouseCursor] defaults to [MouseCursor.defer], deferring the choice of
  /// cursor to the next region behind it in hit-test order.
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
