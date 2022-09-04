import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class SizeChangedLayoutNotifierModifier extends SingleChildStatelessModifier {
  const SizeChangedLayoutNotifierModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizeChangedLayoutNotifier(
      key: modifierKey,
      child: child,
    );
  }
}
