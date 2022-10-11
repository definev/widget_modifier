import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that introduces an area for user selections.
///
/// Flutter widgets are not selectable by default. To enable selection for
/// a Flutter application, consider wrapping a portion of widget subtree with
/// [SelectableRegion]. The wrapped subtree can be selected by users using mouse
/// or touch gestures, e.g. users can select widgets by holding the mouse
/// left-click and dragging across widgets, or they can use long press gestures
/// to select words on touch devices.
///
/// ## An overview of the selection system.
///
/// Every [Selectable] under the [SelectableRegion] can be selected. They form a
/// selection tree structure to handle the selection.
///
/// The [SelectableRegion] is a wrapper over [SelectionContainer]. It listens to
/// user gestures and sends corresponding [SelectionEvent]s to the
/// [SelectionContainer] it creates.
///
/// A [SelectionContainer] is a single [Selectable] that handles
/// [SelectionEvent]s on behalf of child [Selectable]s in the subtree. It
/// creates a [SelectionRegistrarScope] with its [SelectionContainer.delegate]
/// to collect child [Selectable]s and sends the [SelectionEvent]s it receives
/// from the parent [SelectionRegistrar] to the appropriate child [Selectable]s.
/// It creates an abstraction for the parent [SelectionRegistrar] as if it is
/// interacting with a single [Selectable].
///
/// The [SelectionContainer] created by [SelectableRegion] is the root node of a
/// selection tree. Each non-leaf node in the tree is a [SelectionContainer],
/// and the leaf node is a leaf widget whose render object implements
/// [Selectable]. They are connected through [SelectionRegistrarScope]s created
/// by [SelectionContainer]s.
///
/// Both [SelectionContainer]s and the leaf [Selectable]s need to register
/// themselves to the [SelectionRegistrar] from the
/// [SelectionContainer.maybeOf] if they want to participate in the
/// selection.
///
/// An example selection tree will look like:
///
/// {@tool snippet}
///
/// ```dart
/// MaterialApp(
///   home: SelectableRegion(
///     selectionControls: materialTextSelectionControls,
///     focusNode: FocusNode(),
///     child: Scaffold(
///       appBar: AppBar(title: const Text('Flutter Code Sample')),
///       body: ListView(
///         children: const <Widget>[
///           Text('Item 0', style: TextStyle(fontSize: 50.0)),
///           Text('Item 1', style: TextStyle(fontSize: 50.0)),
///         ],
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ```
///
///               SelectionContainer
///               (SelectableRegion)
///                  /         \
///                 /           \
///                /             \
///           Selectable          \
///      ("Flutter Code Sample")   \
///                                 \
///                          SelectionContainer
///                              (ListView)
///                              /       \
///                             /         \
///                            /           \
///                     Selectable        Selectable
///                     ("Item 0")         ("Item 1")
///
///```
///
/// ## Making a widget selectable
///
/// Some leaf widgets, such as [Text], have all of the selection logic wired up
/// automatically and can be selected as long as they are under a
/// [SelectableRegion].
///
/// To make a custom selectable widget, its render object needs to mix in
/// [Selectable] and implement the required APIs to handle [SelectionEvent]s
/// as well as paint appropriate selection highlights.
///
/// The render object also needs to register itself to a [SelectionRegistrar].
/// For the most cases, one can use [SelectionRegistrant] to auto-register
/// itself with the register returned from [SelectionContainer.maybeOf] as
/// seen in the example below.
///
/// {@tool dartpad}
/// This sample demonstrates how to create an adapter widget that makes any
/// child widget selectable.
///
/// ** See code in examples/api/lib/material/selection_area/custom_selectable.dart **
/// {@end-tool}
///
/// ## Complex layout
///
/// By default, the screen order is used as the selection order. If a group of
/// [Selectable]s needs to select differently, consider wrapping them with a
/// [SelectionContainer] to customize its selection behavior.
///
/// {@tool dartpad}
/// This sample demonstrates how to create a [SelectionContainer] that only
/// allows selecting everything or nothing with no partial selection.
///
/// ** See code in examples/api/lib/material/selection_area/custom_container.dart **
/// {@end-tool}
///
/// In the case where a group of widgets should be excluded from selection under
/// a [SelectableRegion], consider wrapping that group of widgets using
/// [SelectionContainer.disabled].
///
/// {@tool dartpad}
/// This sample demonstrates how to disable selection for a Text in a Column.
///
/// ** See code in examples/api/lib/material/selection_area/disable_partial_selection.dart **
/// {@end-tool}
///
/// To create a separate selection system from its parent selection area,
/// wrap part of the subtree with another [SelectableRegion]. The selection of the
/// child selection area can not extend past its subtree, and the selection of
/// the parent selection area can not extend inside the child selection area.
///
/// See also:
///  * [SelectionArea], which creates a [SelectableRegion] with
///    platform-adaptive selection controls.
///  * [SelectionHandler], which contains APIs to handle selection events from the
///    [SelectableRegion].
///  * [Selectable], which provides API to participate in the selection system.
///  * [SelectionRegistrar], which [Selectable] needs to subscribe to receive
///    selection events.
///  * [SelectionContainer], which collects selectable widgets in the subtree
///    and provides api to dispatch selection event to the collected widget.
class SelectableRegionModifier extends SingleChildStatelessModifier {
  /// Create a new [SelectableRegion] widget.
  ///
  /// The [selectionControls] are used for building the selection handles and
  /// toolbar for mobile devices.
  const SelectableRegionModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.focusNode,
    required this.selectionControls,
  });

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode focusNode;

  /// The delegate to build the selection handles and toolbar for mobile
  /// devices.
  final TextSelectionControls selectionControls;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SelectableRegion(
      key: modifierKey,
      focusNode: focusNode,
      selectionControls: selectionControls,
      child: child!,
    );
  }
}
