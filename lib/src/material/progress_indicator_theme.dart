import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ProgressIndicatorThemeModifier extends SingleChildStatelessWidget {
  const ProgressIndicatorThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final ProgressIndicatorThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ProgressIndicatorTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
