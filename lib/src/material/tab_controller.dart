import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class DefaultTabControllerModifier extends SingleChildStatelessModifier {
  const DefaultTabControllerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.length,
    this.initialIndex = 0,
    this.animationDuration,
  });

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
