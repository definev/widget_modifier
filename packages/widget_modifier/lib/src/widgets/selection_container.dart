import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A container that handles [SelectionEvent]s for the [Selectable]s in
/// the subtree.
///
/// This widget is useful when one wants to customize selection behaviors for
/// a group of [Selectable]s
///
/// The state of this container is a single selectable and will register
/// itself to the [registrar] if provided. Otherwise, it will register to the
/// [SelectionRegistrar] from the context.
///
/// The containers handle the [SelectionEvent]s from the registered
/// [SelectionRegistrar] and delegate the events to the [delegate].
///
/// This widget uses [SelectionRegistrarScope] to host the [delegate] as the
/// [SelectionRegistrar] for the subtree to collect the [Selectable]s, and
/// [SelectionEvent]s received by this container are sent to the [delegate] using
/// the [SelectionHandler] API of the delegate.
///
/// {@tool dartpad}
/// This sample demonstrates how to create a [SelectionContainer] that only
/// allows selecting everything or nothing with no partial selection.
///
/// ** See code in examples/api/lib/material/selection_area/custom_container.dart **
/// {@end-tool}
///
/// See also:
///  * [SelectableRegion], which provides an overview of the selection system.
///  * [SelectionContainer.disabled], which disable selection for a
///    subtree.
class SelectionContainerModifier extends SingleChildStatelessModifier {
  /// Creates a selection container to collect the [Selectable]s in the subtree.
  ///
  /// If [registrar] is not provided, this selection container gets the
  /// [SelectionRegistrar] from the context instead.
  ///
  /// The [delegate] and [child] must not be null.
  const SelectionContainerModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.registrar,
    required SelectionContainerDelegate this.delegate,
  }) : assert(delegate != null);

  /// Creates a selection container that disables selection for the
  /// subtree.
  ///
  /// The [child] must not be null.
  const SelectionContainerModifier.disabled({
    super.key,
    super.modifierKey,
    super.child,
  })  : registrar = null,
        delegate = null;

  /// The [SelectionRegistrar] this container is registered to.
  ///
  /// If null, this widget gets the [SelectionRegistrar] from the current
  /// context.
  final SelectionRegistrar? registrar;

  /// The delegate for [SelectionEvent]s sent to this selection container.
  ///
  /// The [Selectable]s in the subtree are added or removed from this delegate
  /// using [SelectionRegistrar] API.
  ///
  /// This delegate is responsible for updating the selections for the selectables
  /// under this widget.
  final SelectionContainerDelegate? delegate;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (delegate == null) {
      return SelectionContainer.disabled(
        key: modifierKey,
        child: child!,
      );
    }
    return SelectionContainer(
      key: modifierKey,
      delegate: delegate!,
      child: child!,
    );
  }
}
