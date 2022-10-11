import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// An [AutofillScope] widget that groups [AutofillClient]s together.
///
/// [AutofillClient]s that share the same closest [AutofillGroup] ancestor must
/// be built together, and they be will be autofilled together.
///
/// {@macro flutter.services.AutofillScope}
///
/// The [AutofillGroup] widget only knows about [AutofillClient]s registered to
/// it using the [AutofillGroupState.register] API. Typically, [AutofillGroup]
/// will not pick up [AutofillClient]s that are not mounted, for example, an
/// [AutofillClient] within a [Scrollable] that has never been scrolled into the
/// viewport. To workaround this problem, ensure clients in the same
/// [AutofillGroup] are built together.
///
/// The topmost [AutofillGroup] widgets (the ones that are closest to the root
/// widget) can be used to clean up the current autofill context when the
/// current autofill context is no longer relevant.
///
/// {@macro flutter.services.TextInput.finishAutofillContext}
///
/// By default, [onDisposeAction] is set to [AutofillContextAction.commit], in
/// which case when any of the topmost [AutofillGroup]s is being disposed, the
/// platform will be informed to save the user input from the current autofill
/// context, then the current autofill context will be destroyed, to free
/// resources. You can, for example, wrap a route that contains a [Form] full of
/// autofillable input fields in an [AutofillGroup], so the user input of the
/// [Form] can be saved for future autofill by the platform.
///
/// {@tool dartpad}
/// An example form with autofillable fields grouped into different
/// `AutofillGroup`s.
///
/// ** See code in examples/api/lib/widgets/autofill/autofill_group.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [AutofillContextAction], an enum that contains predefined autofill context
///   clean up actions to be run when a topmost [AutofillGroup] is disposed.
class AutofillGroupModifier extends SingleChildStatelessModifier {
  /// Creates a scope for autofillable input fields.
  ///
  /// The [child] argument must not be null.
  const AutofillGroupModifier({
    super.key,
    required super.child,
    super.modifierKey,
    this.onDisposeAction = AutofillContextAction.commit,
  });

  /// The [AutofillContextAction] to be run when this [AutofillGroup] is the
  /// topmost [AutofillGroup] and it's being disposed, in order to clean up the
  /// current autofill context.
  ///
  /// {@macro flutter.services.TextInput.finishAutofillContext}
  ///
  /// Defaults to [AutofillContextAction.commit], which prompts the platform to
  /// save the user input and destroy the current autofill context.
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
