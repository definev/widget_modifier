import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class SwitchThemeModifier extends SingleChildStatelessWidget {
  /// Constructs a switch theme that configures all descendant [Switch] widgets.
  const SwitchThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final SwitchThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SwitchTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
