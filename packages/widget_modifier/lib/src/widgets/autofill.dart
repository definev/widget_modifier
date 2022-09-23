import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class AutofillGroupModifier extends SingleChildStatelessModifier {
  const AutofillGroupModifier({
    super.key,
    required super.child,
    super.modifierKey,
    this.onDisposeAction = AutofillContextAction.commit,
  });

  final AutofillContextAction onDisposeAction;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AutofillGroup(
      key: modifierKey,
      onDisposeAction: onDisposeAction,
      child: child!,
    );
  }
}
