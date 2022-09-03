import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DefaultTabControllerModifier extends SingleChildStatelessWidget {
  const DefaultTabControllerModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.length,
    this.initialIndex = 0,
    this.animationDuration,
  });

  final Key? modifierKey;
  final int length;
  final int initialIndex;
  final Duration? animationDuration;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTabController(
      key: modifierKey,
      length: length,
      animationDuration: animationDuration,
      initialIndex: initialIndex,
      child: child!,
    );
  }
}
