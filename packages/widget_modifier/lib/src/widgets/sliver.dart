import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A sliver widget that makes its sliver child partially transparent.
///
/// This class paints its sliver child into an intermediate buffer and then
/// blends the sliver back into the scene partially transparent.
///
/// For values of opacity other than 0.0 and 1.0, this class is relatively
/// expensive because it requires painting the sliver child into an intermediate
/// buffer. For the value 0.0, the sliver child is simply not painted at all.
/// For the value 1.0, the sliver child is painted immediately without an
/// intermediate buffer.
///
/// {@tool snippet}
///
/// This example shows a [SliverList] when the `_visible` member field is true,
/// and hides it when it is false:
///
/// ```dart
/// bool _visible = true;
/// List<Widget> listItems = const <Widget>[
///   Text('Now you see me,'),
///   Text("Now you don't!"),
/// ];
///
/// SliverOpacity(
///   opacity: _visible ? 1.0 : 0.0,
///   sliver: SliverList(
///     delegate: SliverChildListDelegate(listItems),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// This is more efficient than adding and removing the sliver child widget
/// from the tree on demand.
///
/// See also:
///
///  * [Opacity], which can apply a uniform alpha effect to its child using the
///    RenderBox layout protocol.
///  * [AnimatedOpacity], which uses an animation internally to efficiently
///    animate [Opacity].
class SliverOpacityModifier extends SingleChildStatelessModifier {
  /// Creates a sliver that makes its sliver child partially transparent.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0
  /// (inclusive).
  const SliverOpacityModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
  });

  /// The fraction to scale the sliver child's alpha value.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e. invisible).
  ///
  /// The opacity must not be null.
  ///
  /// Values 1.0 and 0.0 are painted with a fast path. Other values
  /// require painting the sliver child into an intermediate buffer, which is
  /// expensive.
  final double opacity;

  /// Whether the semantic information of the sliver child is always included.
  ///
  /// Defaults to false.
  ///
  /// When true, regardless of the opacity settings, the sliver child semantic
  /// information is exposed as if the widget were fully visible. This is
  /// useful in cases where labels may be hidden during animations that
  /// would otherwise contribute relevant semantics.
  final bool alwaysIncludeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverOpacity(
      key: modifierKey,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      sliver: child,
    );
  }
}

/// A sliver widget that is invisible during hit testing.
///
/// When [ignoring] is true, this widget (and its subtree) is invisible
/// to hit testing. It still consumes space during layout and paints its sliver
/// child as usual. It just cannot be the target of located events, because it
/// returns false from [RenderSliver.hitTest].
///
/// When [ignoringSemantics] is true, the subtree will be invisible to
/// the semantics layer (and thus e.g. accessibility tools). If
/// [ignoringSemantics] is null, it uses the value of [ignoring].
class SliverIgnorePointerModifier extends SingleChildStatelessModifier {
  /// Creates a sliver widget that is invisible to hit testing.
  ///
  /// The [ignoring] argument must not be null. If [ignoringSemantics] is null,
  /// this render object will be ignored for semantics if [ignoring] is true.
  const SliverIgnorePointerModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.ignoring = true,
    this.ignoringSemantics,
  }) : assert(ignoring != null);

  /// Whether this sliver is ignored during hit testing.
  ///
  /// Regardless of whether this sliver is ignored during hit testing, it will
  /// still consume space during layout and be visible during painting.
  final bool ignoring;

  /// Whether the semantics of this sliver is ignored when compiling the
  /// semantics tree.
  ///
  /// If null, defaults to value of [ignoring].
  ///
  /// See [SemanticsNode] for additional information about the semantics tree.
  final bool? ignoringSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverIgnorePointer(
      key: modifierKey,
      ignoring: ignoring,
      ignoringSemantics: ignoringSemantics,
      sliver: child,
    );
  }
}

/// A sliver that lays its sliver child out as if it was in the tree, but
/// without painting anything, without making the sliver child available for hit
/// testing, and without taking any room in the parent.
///
/// Animations continue to run in offstage sliver children, and therefore use
/// battery and CPU time, regardless of whether the animations end up being
/// visible.
///
/// To hide a sliver widget from view while it is
/// not needed, prefer removing the widget from the tree entirely rather than
/// keeping it alive in an [Offstage] subtree.
class SliverOffstageModifier extends SingleChildStatelessModifier {
  /// Creates a sliver that visually hides its sliver child.
  const SliverOffstageModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.offstage = true,
  }) : assert(offstage != null);

  /// Whether the sliver child is hidden from the rest of the tree.
  ///
  /// If true, the sliver child is laid out as if it was in the tree, but
  /// without painting anything, without making the child available for hit
  /// testing, and without taking any room in the parent.
  ///
  /// If false, the sliver child is included in the tree as normal.
  final bool offstage;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverOffstage(
      key: modifierKey,
      offstage: offstage,
      sliver: child,
    );
  }
}
