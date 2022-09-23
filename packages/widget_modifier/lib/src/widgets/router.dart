import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class BackButtonListenerModifier extends SingleChildStatelessModifier {
  const BackButtonListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.onBackButtonPressed,
  }) : super(key: key, child: child);

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
