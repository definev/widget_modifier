import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class SizeChangedLayoutNotifierModifier extends SingleChildStatelessWidget {
  const SizeChangedLayoutNotifierModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizeChangedLayoutNotifier(
      key: modifierKey,
      child: child,
    );
  }
}
