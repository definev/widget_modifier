import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class CheckboxThemeModifier extends SingleChildStatelessWidget {
  const CheckboxThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final CheckboxThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckboxTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
