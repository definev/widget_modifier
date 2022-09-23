import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class SafeAreaModifier extends SingleChildStatelessModifier {
  const SafeAreaModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  }) : super(key: key, child: child);

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

class SliverSafeAreaModifier extends SingleChildStatelessModifier {
  const SliverSafeAreaModifier({
    Key? key,
    Widget? sliver,
    super.modifierKey,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
  }) : super(key: key, child: sliver);

  final bool left;

  final bool top;

  final bool right;

  final bool bottom;

  final EdgeInsets minimum;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverSafeArea(
      key: modifierKey,
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      minimum: minimum,
      sliver: child!,
    );
  }
}
