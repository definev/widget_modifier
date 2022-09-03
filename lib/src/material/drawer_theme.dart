import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class DrawerThemeModifier extends SingleChildStatelessModifier {
  const DrawerThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final DrawerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DrawerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
