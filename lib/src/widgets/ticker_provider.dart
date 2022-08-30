import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class TickerModeModifier extends SingleChildStatelessWidget {
  const TickerModeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.enabled,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TickerMode(
      key: modifierKey,
      enabled: enabled,
      child: child!,
    );
  }
}
