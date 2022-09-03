import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class NavigationBarThemeModifier extends SingleChildStatelessWidget {
  const NavigationBarThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final NavigationBarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NavigationBarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
