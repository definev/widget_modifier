import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// An inherited widget that describes the order in which its child subtree
/// should be traversed.
///
/// {@macro flutter.widgets.FocusOrder.comparable}
///
/// The order for a widget is determined by the [FocusOrder] returned by
/// [FocusTraversalOrder.of] for a particular context.
class FocusTraversalOrderModifier extends SingleChildStatelessModifier {
  /// Creates an inherited widget used to describe the focus order of
  /// the [child] subtree.
  const FocusTraversalOrderModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.order,
  });

  /// The order for the widget descendants of this [FocusTraversalOrder].
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

/// A widget that describes the inherited focus policy for focus traversal for
/// its descendants, grouping them into a separate traversal group.
///
/// A traversal group is treated as one entity when sorted by the traversal
/// algorithm, so it can be used to segregate different parts of the widget tree
/// that need to be sorted using different algorithms and/or sort orders when
/// using an [OrderedTraversalPolicy].
///
/// Within the group, it will use the given [policy] to order the elements. The
/// group itself will be ordered using the parent group's policy.
///
/// By default, traverses in reading order using [ReadingOrderTraversalPolicy].
///
/// To prevent the members of the group from being focused, set the
/// [descendantsAreFocusable] attribute to false.
///
/// {@tool dartpad}
/// This sample shows three rows of buttons, each grouped by a
/// [FocusTraversalGroup], each with different traversal order policies. Use tab
/// traversal to see the order they are traversed in.  The first row follows a
/// numerical order, the second follows a lexical order (ordered to traverse
/// right to left), and the third ignores the numerical order assigned to it and
/// traverses in widget order.
///
/// ** See code in examples/api/lib/widgets/focus_traversal/focus_traversal_group.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [FocusNode], for a description of the focus system.
///  * [WidgetOrderTraversalPolicy], a policy that relies on the widget
///    creation order to describe the order of traversal.
///  * [ReadingOrderTraversalPolicy], a policy that describes the order as the
///    natural "reading order" for the current [Directionality].
///  * [DirectionalFocusTraversalPolicyMixin] a mixin class that implements
///    focus traversal in a direction.
class FocusTraversalGroupModifier extends SingleChildStatelessModifier {
  /// Creates a [FocusTraversalGroup] object.
  ///
  /// The [child] and [descendantsAreFocusable] arguments must not be null.
  FocusTraversalGroupModifier({
    super.key,
    super.child,
    super.modifierKey,
    FocusTraversalPolicy? policy,
    this.descendantsAreFocusable = true,
    this.descendantsAreTraversable = true,
  }) : policy = policy ?? ReadingOrderTraversalPolicy();

  /// The policy used to move the focus from one focus node to another when
  /// traversing them using a keyboard.
  ///
  /// If not specified, traverses in reading order using
  /// [ReadingOrderTraversalPolicy].
  ///
  /// See also:
  ///
  ///  * [FocusTraversalPolicy] for the API used to impose traversal order
  ///    policy.
  ///  * [WidgetOrderTraversalPolicy] for a traversal policy that traverses
  ///    nodes in the order they are added to the widget tree.
  ///  * [ReadingOrderTraversalPolicy] for a traversal policy that traverses
  ///    nodes in the reading order defined in the widget tree, and then top to
  ///    bottom.
  final FocusTraversalPolicy policy;

  /// {@macro flutter.widgets.Focus.descendantsAreFocusable}
  final bool descendantsAreFocusable;

  /// {@macro flutter.widgets.Focus.descendantsAreTraversable}
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

/// A widget that controls whether or not the descendants of this widget are
/// traversable.
///
/// Does not affect the value of [FocusNode.skipTraversal] of the descendants.
///
/// See also:
///
///  * [Focus], a widget for adding and managing a [FocusNode] in the widget tree.
///  * [ExcludeFocus], a widget that excludes its descendants from focusability.
///  * [FocusTraversalGroup], a widget that groups widgets for focus traversal,
///    and can also be used in the same way as this widget by setting its
///    `descendantsAreFocusable` attribute.
class ExcludeFocusTraversalModifier extends SingleChildStatelessModifier {
  /// Const constructor for [ExcludeFocusTraversal] widget.
  ///
  /// The [excluding] argument must not be null.
  ///
  /// The [child] argument is required, and must not be null.
  const ExcludeFocusTraversalModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.excluding = true,
  });

  /// If true, will make this widget's descendants untraversable.
  ///
  /// Defaults to true.
  ///
  /// Does not affect the value of [FocusNode.skipTraversal] on the descendants.
  ///
  /// See also:
  ///
  /// * [Focus.descendantsAreTraversable], the attribute of a [Focus] widget that
  ///   controls this same property for focus widgets.
  /// * [FocusTraversalGroup], a widget used to group together and configure the
  ///   focus traversal policy for a widget subtree that has a
  ///   `descendantsAreFocusable` parameter to conditionally block focus for a
  ///   subtree.
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
