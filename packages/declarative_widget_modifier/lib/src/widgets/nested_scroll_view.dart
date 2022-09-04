import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class NestedScrollViewModifier extends SingleChildStatelessModifier {
  const NestedScrollViewModifier({
    Key? key,
    super.modifierKey,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    required this.headerSliverBuilder,
    this.body,
    this.dragStartBehavior = DragStartBehavior.start,
    this.floatHeaderSlivers = false,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollBehavior,
  }) : super(key: key, child: body);

  final ScrollController? controller;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final NestedScrollViewHeaderSliversBuilder headerSliverBuilder;
  final Widget? body;
  final DragStartBehavior dragStartBehavior;
  final bool floatHeaderSlivers;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NestedScrollView(
      key: modifierKey,
      headerSliverBuilder: headerSliverBuilder,
      clipBehavior: clipBehavior,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      floatHeaderSlivers: floatHeaderSlivers,
      physics: physics,
      restorationId: restorationId,
      reverse: reverse,
      scrollBehavior: scrollBehavior,
      scrollDirection: scrollDirection,
      body: child!,
    );
  }
}

class SliverOverlapAbsorberModifier extends SingleChildStatelessModifier {
  const SliverOverlapAbsorberModifier({
    Key? key,
    Widget? sliver,
    super.modifierKey,
    required this.handle,
  }) : super(key: key, child: sliver);

  final SliverOverlapAbsorberHandle handle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverOverlapAbsorber(
      key: modifierKey,
      handle: handle,
      sliver: child,
    );
  }
}

class SliverOverlapInjectorModifier extends SingleChildStatelessModifier {
  const SliverOverlapInjectorModifier({
    Key? key,
    Widget? sliver,
    super.modifierKey,
    required this.handle,
  }) : super(key: key, child: sliver);

  final SliverOverlapAbsorberHandle handle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverOverlapInjector(
      key: modifierKey,
      handle: handle,
      sliver: child,
    );
  }
}
