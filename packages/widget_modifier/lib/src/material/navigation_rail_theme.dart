import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class NavigationRailThemeModifier extends SingleChildStatelessModifier {
  const NavigationRailThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final NavigationRailThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NavigationRailTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
