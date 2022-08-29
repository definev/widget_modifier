import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class NestedScrollViewModifier extends SingleChildStatelessWidget {
  const NestedScrollViewModifier({
    Key? key,
    this.modifierKey,
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

  final Key? modifierKey;
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

class SliverOverlapAbsorberModifier extends SingleChildStatelessWidget {
  const SliverOverlapAbsorberModifier({
    Key? key,
    Widget? sliver,
    this.modifierKey,
    required this.handle,
  }) : super(key: key, child: sliver);

  final Key? modifierKey;
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

class SliverOverlapInjectorModifier extends SingleChildStatelessWidget {
  const SliverOverlapInjectorModifier({
    Key? key,
    Widget? sliver,
    this.modifierKey,
    required this.handle,
  }) : super(key: key, child: sliver);

  final Key? modifierKey;
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
