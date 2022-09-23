import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class DividerThemeModifier extends SingleChildStatelessModifier {
  const DividerThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final DividerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DividerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
