import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DividerThemeModifier extends SingleChildStatelessWidget {
  const DividerThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
