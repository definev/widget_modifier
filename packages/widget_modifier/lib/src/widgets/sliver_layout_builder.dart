import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// The signature of the [SliverLayoutBuilder] builder function.
typedef SliverLayoutWidgetModifierBuilder = Widget Function(
  BuildContext context,
  SliverConstraints constraints,
  Widget? child,
);

/// Builds a sliver widget tree that can depend on its own [SliverConstraints].
///
/// Similar to the [LayoutBuilder] widget except its builder should return a sliver
/// widget, and [SliverLayoutBuilder] is itself a sliver. The framework calls the
/// [builder] function at layout time and provides the current [SliverConstraints].
/// The [SliverLayoutBuilder]'s final [SliverGeometry] will match the [SliverGeometry]
/// of its child.
///
/// {@macro flutter.widgets.ConstrainedLayoutBuilder}
///
/// See also:
///
///  * [LayoutBuilder], the non-sliver version of this widget.
class SliverLayoutBuilderModifier extends SingleChildStatelessModifier {
  /// Creates a sliver widget that defers its building until layout.
  ///
  /// The [builder] argument must not be null.
  const SliverLayoutBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.builder,
  });

  /// Called at layout time to construct the widget tree.
  ///
  /// The builder must return a non-null sliver widget.
  final SliverLayoutWidgetModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverLayoutBuilder(
      key: modifierKey,
      builder: (BuildContext context, SliverConstraints constraints) => builder(context, constraints, child),
    );
  }
}
