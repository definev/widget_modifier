import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class AutomaticKeepAliveModifier extends SingleChildStatelessModifier {
  const AutomaticKeepAliveModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AutomaticKeepAlive(
      key: modifierKey,
      child: child!,
    );
  }
}
