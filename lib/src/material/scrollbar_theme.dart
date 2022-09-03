import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ScrollbarThemeModifier extends SingleChildStatelessModifier {
  const ScrollbarThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final ScrollbarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScrollbarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
