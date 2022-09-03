import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class TickerModeModifier extends SingleChildStatelessModifier {
  const TickerModeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.enabled,
  }) : super(key: key, child: child);

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
