import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that creates key bindings to specific actions for its
/// descendants.
///
/// This widget establishes a [ShortcutManager] to be used by its descendants
/// when invoking an [Action] via a keyboard key combination that maps to an
/// [Intent].
///
/// See the article on [Using Actions and
/// Shortcuts](https://docs.flutter.dev/development/ui/advanced/actions_and_shortcuts)
/// for a detailed explanation.
///
/// {@tool dartpad}
/// Here, we will use the [Shortcuts] and [Actions] widgets to add and subtract
/// from a counter. When the child widget has keyboard focus, and a user presses
/// the keys that have been defined in [Shortcuts], the action that is bound
/// to the appropriate [Intent] for the key is invoked.
///
/// It also shows the use of a [CallbackAction] to avoid creating a new [Action]
/// subclass.
///
/// ** See code in examples/api/lib/widgets/shortcuts/shortcuts.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This slightly more complicated, but more flexible, example creates a custom
/// [Action] subclass to increment and decrement within a widget (a [Column])
/// that has keyboard focus. When the user presses the up and down arrow keys,
/// the counter will increment and decrement a data model using the custom
/// actions.
///
/// One thing that this demonstrates is passing arguments to the [Intent] to be
/// carried to the [Action]. This shows how actions can get data either from
/// their own construction (like the `model` in this example), or from the
/// intent passed to them when invoked (like the increment `amount` in this
/// example).
///
/// ** See code in examples/api/lib/widgets/shortcuts/shortcuts.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CallbackShortcuts], a less complicated (but less flexible) way of
///    defining key bindings that just invoke callbacks.
///  * [Intent], a class for containing a description of a user action to be
///    invoked.
///  * [Action], a class for defining an invocation of a user action.
///  * [CallbackAction], a class for creating an action from a callback.
class ShortcutsModifier extends SingleChildStatelessModifier {
  /// Creates a const [Shortcuts] widget that owns the map of shortcuts and
  /// creates its own manager.
  ///
  /// When using this constructor, [manager] will return null.
  ///
  /// The [child] and [shortcuts] arguments are required.
  ///
  /// See also:
  ///
  ///  * [Shortcuts.manager], a constructor that uses a [ShortcutManager] to
  ///    manage the shortcuts list instead.
  const ShortcutsModifier({
    super.key,
    super.modifierKey,
    super.child,
    required Map<ShortcutActivator, Intent> shortcuts,
    this.debugLabel,
  })  : _shortcuts = shortcuts,
        manager = null,
        assert(shortcuts != null);

  /// Creates a const [Shortcuts] widget that uses the [manager] to
  /// manage the map of shortcuts.
  ///
  /// If this constructor is used, [shortcuts] will return the contents of
  /// [ShortcutManager.shortcuts].
  ///
  /// The [child] and [manager] arguments are required.
  const ShortcutsModifier.manager({
    super.key,
    super.modifierKey,
    super.child,
    required ShortcutManager this.manager,
    this.debugLabel,
  })  : _shortcuts = const <ShortcutActivator, Intent>{},
        assert(manager != null);

  /// The [ShortcutManager] that will manage the mapping between key
  /// combinations and [Action]s.
  ///
  /// If this widget was created with [Shortcuts.manager], then
  /// [ShortcutManager.shortcuts] will be used as the source for shortcuts. If
  /// the unnamed constructor is used, this manager will be null, and a
  /// default-constructed [ShortcutManager] will be used.
  final ShortcutManager? manager;

  /// {@template flutter.widgets.shortcuts.shortcuts}
  /// The map of shortcuts that describes the mapping between a key sequence
  /// defined by a [ShortcutActivator] and the [Intent] that will be emitted
  /// when that key sequence is pressed.
  /// {@endtemplate}
  Map<ShortcutActivator, Intent> get shortcuts {
    return manager == null ? _shortcuts : manager!.shortcuts;
  }

  final Map<ShortcutActivator, Intent> _shortcuts;

  /// The debug label that is printed for this node when logged.
  ///
  /// If this label is set, then it will be displayed instead of the shortcut
  /// map when logged.
  ///
  /// This allows simplifying the diagnostic output to avoid cluttering it
  /// unnecessarily with large default shortcut maps.
  final String? debugLabel;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Shortcuts(
      key: modifierKey,
      debugLabel: debugLabel,
      shortcuts: shortcuts,
      child: child!,
    );
  }
}
