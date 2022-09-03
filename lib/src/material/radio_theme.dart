import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class RadioThemeModifier extends SingleChildStatelessWidget {
  const RadioThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final RadioThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RadioTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
