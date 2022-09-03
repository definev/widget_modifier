import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class OutlinedButtonThemeModifier extends SingleChildStatelessWidget {
  const OutlinedButtonThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final OutlinedButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OutlinedButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
