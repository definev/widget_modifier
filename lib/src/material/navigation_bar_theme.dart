import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class NavigationBarThemeModifier extends SingleChildStatelessModifier {
  const NavigationBarThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

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
