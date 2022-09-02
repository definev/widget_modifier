import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class AutomaticKeepAliveModifier extends SingleChildStatelessWidget {
  const AutomaticKeepAliveModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AutomaticKeepAlive(
      key: modifierKey,
      child: child!,
    );
  }
}
