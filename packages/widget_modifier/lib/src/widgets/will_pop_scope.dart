import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class WillPopScopeModifier extends SingleChildStatelessModifier {
  const WillPopScopeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.onWillPop,
  }) : super(key: key, child: child);

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
