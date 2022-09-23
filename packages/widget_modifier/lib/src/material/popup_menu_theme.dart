import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class PopupMenuThemeModifier extends SingleChildStatelessModifier {
  const PopupMenuThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

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
