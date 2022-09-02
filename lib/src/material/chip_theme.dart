import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ChipThemeModifier extends SingleChildStatelessWidget {
  const ChipThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final ChipThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ChipTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
