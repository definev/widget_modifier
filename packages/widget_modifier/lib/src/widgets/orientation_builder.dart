import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Signature for a function that builds a widget given an [Orientation].
///
/// Used by [OrientationBuilder.builder].
typedef OrientationModifierBuilder = Widget Function(
  BuildContext context,
  Orientation orientation,
  Widget? child,
);


/// Builds a widget tree that can depend on the parent widget's orientation
/// (distinct from the device orientation).
///
/// See also:
///
///  * [LayoutBuilder], which exposes the complete constraints, not just the
///    orientation.
///  * [CustomSingleChildLayout], which positions its child during layout.
///  * [CustomMultiChildLayout], with which you can define the precise layout
///    of a list of children during the layout phase.
///  * [MediaQueryData.orientation], which exposes whether the device is in
///    landscape or portrait mode.
class OrientationBuilderModifier extends SingleChildStatelessModifier {
  /// Creates an orientation builder.
  ///
  /// The [builder] argument must not be null.
  const OrientationBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.builder,
  });

  /// Builds the widgets below this widget given this widget's orientation.
  ///
  /// A widget's orientation is simply a factor of its width relative to its
  /// height. For example, a [Column] widget will have a landscape orientation
  /// if its width exceeds its height, even though it displays its children in
  /// a vertical array.
  final OrientationModifierBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OrientationBuilder(
      key: modifierKey,
      builder: (BuildContext context, Orientation orientation) => builder(context, orientation, child),
    );
  }
}
