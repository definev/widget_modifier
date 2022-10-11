import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Annotates a region of the layer tree with a value.
///
/// See also:
///
///  * [Layer.find], for an example of how this value is retrieved.
///  * [AnnotatedRegionLayer], the layer pushed into the layer tree.
class AnnotatedRegionModifier<T extends Object> extends SingleChildStatelessModifier {
  /// Creates a new annotated region to insert [value] into the layer tree.
  ///
  /// Neither [child] nor [value] may be null.
  ///
  /// [sized] defaults to true and controls whether the annotated region will
  /// clip its child.
  const AnnotatedRegionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.value,
    this.sized = true,
  });

  /// A value which can be retrieved using [Layer.find].
  final T value;

  /// If false, the layer pushed into the tree will not be provided with a size.
  ///
  /// An [AnnotatedRegionLayer] with a size checks that the offset provided in
  /// [Layer.find] is within the bounds, returning null otherwise.
  ///
  /// See also:
  ///
  ///  * [AnnotatedRegionLayer], for a description of this behavior.
  final bool sized;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnnotatedRegion<T>(
      key: modifierKey,
      sized: sized,
      value: value,
      child: child!,
    );
  }
}
