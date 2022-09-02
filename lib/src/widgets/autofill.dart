import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class AutofillGroupModifier extends SingleChildStatelessWidget {
  const AutofillGroupModifier({
    super.key,
    required super.child,
    this.modifierKey,
    this.onDisposeAction = AutofillContextAction.commit,
  });

  final Key? modifierKey;
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
