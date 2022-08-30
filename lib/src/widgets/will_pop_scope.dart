import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class WillPopScopeModifier extends SingleChildStatelessWidget {
  const WillPopScopeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.onWillPop,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final WillPopCallback? onWillPop;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return WillPopScope(
      key: modifierKey,
      onWillPop: onWillPop,
      child: child!,
    );
  }
}
