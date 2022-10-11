import 'package:flutter/widgets.dart';

import '../modifier.dart';

class TickerModeModifier extends SingleChildStatelessModifier {
  const TickerModeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.enabled,
  });

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
