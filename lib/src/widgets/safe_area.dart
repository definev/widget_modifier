import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class SafeAreaModifier extends SingleChildStatelessWidget {
  const SafeAreaModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SafeArea(
      key: modifierKey,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child!,
    );
  }
}
