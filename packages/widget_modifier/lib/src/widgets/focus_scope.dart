import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that manages a [FocusNode] to allow keyboard focus to be given
/// to this widget and its descendants.
///
/// When the focus is gained or lost, [onFocusChange] is called.
///
/// For keyboard events, [onKey] and [onKeyEvent] are called if
/// [FocusNode.hasFocus] is true for this widget's [focusNode], unless a focused
/// descendant's [onKey] or [onKeyEvent] callback returned
/// [KeyEventResult.handled] when called.
///
/// This widget does not provide any visual indication that the focus has
/// changed. Any desired visual changes should be made when [onFocusChange] is
/// called.
///
/// To access the [FocusNode] of the nearest ancestor [Focus] widget and
/// establish a relationship that will rebuild the widget when the focus
/// changes, use the [Focus.of] and [FocusScope.of] static methods.
///
/// To access the focused state of the nearest [Focus] widget, use
/// [FocusNode.hasFocus] from a build method, which also establishes a
/// relationship between the calling widget and the [Focus] widget that will
/// rebuild the calling widget when the focus changes.
///
/// Managing a [FocusNode] means managing its lifecycle, listening for changes
/// in focus, and re-parenting it when needed to keep the focus hierarchy in
/// sync with the widget hierarchy. This widget does all of those things for
/// you. See [FocusNode] for more information about the details of what node
/// management entails if you are not using a [Focus] widget and you need to do
/// it yourself.
///
/// If the [Focus] default constructor is used, then this widget will manage any
/// given [focusNode] by overwriting the appropriate values of the [focusNode]
/// with the values of [FocusNode.onKey], [FocusNode.onKeyEvent],
/// [FocusNode.skipTraversal], [FocusNode.canRequestFocus], and
/// [FocusNode.descendantsAreFocusable] whenever the [Focus] widget is updated.
///
/// If the [Focus.withExternalFocusNode] is used instead, then the values
/// returned by [onKey], [onKeyEvent], [skipTraversal], [canRequestFocus], and
/// [descendantsAreFocusable] will be the values in the external focus node, and
/// the external focus node's values will not be overwritten when the widget is
/// updated.
///
/// To collect a sub-tree of nodes into an exclusive group that restricts focus
/// traversal to the group, use a [FocusScope]. To collect a sub-tree of nodes
/// into a group that has a specific order to its traversal but allows the
/// traversal to escape the group, use a [FocusTraversalGroup].
///
/// To move the focus, use methods on [FocusNode] by getting the [FocusNode]
/// through the [of] method. For instance, to move the focus to the next node in
/// the focus traversal order, call `Focus.of(context).nextFocus()`. To unfocus
/// a widget, call `Focus.of(context).unfocus()`.
///
/// {@tool dartpad}
/// This example shows how to manage focus using the [Focus] and [FocusScope]
/// widgets. See [FocusNode] for a similar example that doesn't use [Focus] or
/// [FocusScope].
///
/// ** See code in examples/api/lib/widgets/focus_scope/focus.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to wrap another widget in a [Focus] widget to make it
/// focusable. It wraps a [Container], and changes the container's color when it
/// is set as the [FocusManager.primaryFocus].
///
/// If you also want to handle mouse hover and/or keyboard actions on a widget,
/// consider using a [FocusableActionDetector], which combines several different
/// widgets to provide those capabilities.
///
/// ** See code in examples/api/lib/widgets/focus_scope/focus.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to focus a newly-created widget immediately after it
/// is created.
///
/// The focus node will not actually be given the focus until after the frame in
/// which it has requested focus is drawn, so it is OK to call
/// [FocusNode.requestFocus] on a node which is not yet in the focus tree.
///
/// ** See code in examples/api/lib/widgets/focus_scope/focus.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [FocusNode], which represents a node in the focus hierarchy and
///    [FocusNode]'s API documentation includes a detailed explanation of its role
///    in the overall focus system.
///  * [FocusScope], a widget that manages a group of focusable widgets using a
///    [FocusScopeNode].
///  * [FocusScopeNode], a node that collects focus nodes into a group for
///    traversal.
///  * [FocusManager], a singleton that manages the primary focus and
///    distributes key events to focused nodes.
///  * [FocusTraversalPolicy], an object used to determine how to move the focus
///    to other nodes.
///  * [FocusTraversalGroup], a widget that groups together and imposes a
///    traversal policy on the [Focus] nodes below it in the widget hierarchy.
class FocusModifier extends SingleChildStatelessModifier {
  /// Creates a widget that manages a [FocusNode].
  ///
  /// The [child] argument is required and must not be null.
  ///
  /// The [autofocus] argument must not be null.
  const FocusModifier({
    super.key,
    super.child,
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
  });

  /// Creates a Focus widget that uses the given [focusNode] as the source of
  /// truth for attributes on the node, rather than the attributes of this widget.
  const factory FocusModifier.withExternalFocusNode({
    Key? key,
    required Widget child,
    required FocusNode focusNode,
    bool autofocus,
    ValueChanged<bool>? onFocusChange,
    bool includeSemantics,
  }) = _FocusWithExternalFocusNode;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro  flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// A handler for keys that are pressed when this object or one of its
  /// children has focus.
  ///
  /// Key events are first given to the [FocusNode] that has primary focus, and
  /// if its [onKeyEvent] method returns [KeyEventResult.ignored], then they are
  /// given to each ancestor node up the focus hierarchy in turn. If an event
  /// reaches the root of the hierarchy, it is discarded.
  ///
  /// This is not the way to get text input in the manner of a text field: it
  /// leaves out support for input method editors, and doesn't support soft
  /// keyboards in general. For text input, consider [TextField],
  /// [EditableText], or [CupertinoTextField] instead, which do support these
  /// things.
  final FocusOnKeyEventCallback? onKeyEvent;

  /// A handler for keys that are pressed when this object or one of its
  /// children has focus.
  ///
  /// This is a legacy API based on [RawKeyEvent] and will be deprecated in the
  /// future. Prefer [onKeyEvent] instead.
  ///
  /// Key events are first given to the [FocusNode] that has primary focus, and
  /// if its [onKey] method return false, then they are given to each ancestor
  /// node up the focus hierarchy in turn. If an event reaches the root of the
  /// hierarchy, it is discarded.
  ///
  /// This is not the way to get text input in the manner of a text field: it
  /// leaves out support for input method editors, and doesn't support soft
  /// keyboards in general. For text input, consider [TextField],
  /// [EditableText], or [CupertinoTextField] instead, which do support these
  /// things.
  final FocusOnKeyCallback? onKey;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool? canRequestFocus;

  /// Sets the [FocusNode.skipTraversal] flag on the focus node so that it won't
  /// be visited by the [FocusTraversalPolicy].
  ///
  /// This is sometimes useful if a [Focus] widget should receive key events as
  /// part of the focus chain, but shouldn't be accessible via focus traversal.
  ///
  /// This is different from [FocusNode.canRequestFocus] because it only implies
  /// that the widget can't be reached via traversal, not that it can't be
  /// focused. It may still be focused explicitly.
  final bool? skipTraversal;

  /// {@macro flutter.widgets.Focus.descendantsAreFocusable}
  final bool? descendantsAreFocusable;

  /// {@macro flutter.widgets.Focus.descendantsAreTraversable}
  final bool? descendantsAreTraversable;

  /// A debug label for this widget.
  ///
  /// Not used for anything except to be printed in the diagnostic output from
  /// [toString] or [toStringDeep].
  ///
  /// To get a string with the entire tree, call [debugDescribeFocusTree]. To
  /// print it to the console call [debugDumpFocusTree].
  ///
  /// Defaults to null.
  final String? debugLabel;

  /// {@macro flutter.widgets.Focus.includeSemantics}
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

/// A [FocusScope] is similar to a [Focus], but also serves as a scope for its
/// descendants, restricting focus traversal to the scoped controls.
///
/// For example a new [FocusScope] is created automatically when a route is
/// pushed, keeping the focus traversal from moving to a control in a previous
/// route.
///
/// If you just want to group widgets together in a group so that they are
/// traversed in a particular order, but the focus can still leave the group,
/// use a [FocusTraversalGroup].
///
/// Like [Focus], [FocusScope] provides an [onFocusChange] as a way to be
/// notified when the focus is given to or removed from this widget.
///
/// The [onKey] argument allows specification of a key event handler that is
/// invoked when this node or one of its children has focus. Keys are handed to
/// the primary focused widget first, and then they propagate through the
/// ancestors of that node, stopping if one of them returns
/// [KeyEventResult.handled] from [onKey], indicating that it has handled the
/// event.
///
/// Managing a [FocusScopeNode] means managing its lifecycle, listening for
/// changes in focus, and re-parenting it when needed to keep the focus
/// hierarchy in sync with the widget hierarchy. This widget does all of those
/// things for you. See [FocusScopeNode] for more information about the details
/// of what node management entails if you are not using a [FocusScope] widget
/// and you need to do it yourself.
///
/// [FocusScopeNode]s remember the last [FocusNode] that was focused within
/// their descendants, and can move that focus to the next/previous node, or a
/// node in a particular direction when the [FocusNode.nextFocus],
/// [FocusNode.previousFocus], or [FocusNode.focusInDirection] are called on a
/// [FocusNode] or [FocusScopeNode].
///
/// To move the focus, use methods on [FocusNode] by getting the [FocusNode]
/// through the [of] method. For instance, to move the focus to the next node in
/// the focus traversal order, call `Focus.of(context).nextFocus()`. To unfocus
/// a widget, call `Focus.of(context).unfocus()`.
///
/// {@tool dartpad}
/// This example demonstrates using a [FocusScope] to restrict focus to a particular
/// portion of the app. In this case, restricting focus to the visible part of a
/// Stack.
///
/// ** See code in examples/api/lib/widgets/focus_scope/focus_scope.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [FocusScopeNode], which represents a scope node in the focus hierarchy.
///  * [FocusNode], which represents a node in the focus hierarchy and has an
///    explanation of the focus system.
///  * [Focus], a widget that manages a [FocusNode] and allows easy access to
///    managing focus without having to manage the node.
///  * [FocusManager], a singleton that manages the focus and distributes key
///    events to focused nodes.
///  * [FocusTraversalPolicy], an object used to determine how to move the focus
///    to other nodes.
///  * [FocusTraversalGroup], a widget used to configure the focus traversal
///    policy for a widget subtree.
class FocusScopeModifier extends FocusModifier {
  /// Creates a widget that manages a [FocusScopeNode].
  ///
  /// The [child] argument is required and must not be null.
  ///
  /// The [autofocus] argument must not be null.
  const FocusScopeModifier({
    super.key,
    FocusScopeNode? node,
    required Widget super.child,
    super.autofocus,
    super.onFocusChange,
    super.canRequestFocus,
    super.skipTraversal,
    super.onKeyEvent,
    super.onKey,
    super.debugLabel,
  }) : super(
          focusNode: node,
        );

  /// Creates a FocusScope widget that uses the given [focusScopeNode] as the
  /// source of truth for attributes on the node, rather than the attributes of
  /// this widget.
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
    super.key,
    required Widget super.child,
    required FocusNode super.focusNode,
    super.autofocus,
    super.onFocusChange,
    super.includeSemantics,
  });
}

class _FocusScopeWithExternalFocusNode extends FocusScopeModifier {
  const _FocusScopeWithExternalFocusNode({
    super.key,
    required super.child,
    required FocusScopeNode focusScopeNode,
    super.autofocus,
    super.onFocusChange,
  }) : super(
          node: focusScopeNode,
        );
}
