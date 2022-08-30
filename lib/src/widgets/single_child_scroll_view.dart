import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class SingleChildScrollViewModifier extends SingleChildStatelessWidget {
  const SingleChildScrollViewModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SingleChildScrollView(
      key: modifierKey,
      controller: controller,
      clipBehavior: clipBehavior,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}
