import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class BackButtonListenerModifier extends SingleChildStatelessWidget {
  const BackButtonListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.onBackButtonPressed,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final ValueGetter<Future<bool>> onBackButtonPressed;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BackButtonListener(
      key: modifierKey,
      onBackButtonPressed: onBackButtonPressed,
      child: child!,
    );
  }
}
