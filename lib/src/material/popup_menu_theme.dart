import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class PopupMenuThemeModifier extends SingleChildStatelessWidget {
  const PopupMenuThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final PopupMenuThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
