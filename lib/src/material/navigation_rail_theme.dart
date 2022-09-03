import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class NavigationRailThemeModifier extends SingleChildStatelessWidget {
  const NavigationRailThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
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
