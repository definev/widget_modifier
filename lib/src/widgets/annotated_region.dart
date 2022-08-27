import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class AnnotatedRegionModifier<T extends Object>
    extends SingleChildStatelessWidget {
  const AnnotatedRegionModifier({
    Key? key,
    this.modifiedKey,
    required Widget child,
    required this.value,
    this.sized = true,
  }) : super(key: key, child: child);

  final Key? modifiedKey;
  final T value;
  final bool sized;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnnotatedRegion(
      key: modifiedKey,
      value: value,
      child: child!,
    );
  }
}
