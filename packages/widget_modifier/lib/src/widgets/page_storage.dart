import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Establish a subtree in which widgets can opt into persisting states after
/// being destroyed.
///
/// [PageStorage] is used to save and restore values that can outlive the widget.
/// For example, when multiple pages are grouped in tabs, when a page is
/// switched out, its widget is destroyed and its state is lost. By adding a
/// [PageStorage] at the root and adding a [PageStorageKey] to each page, some of the
/// page's state (e.g. the scroll position of a [Scrollable] widget) will be stored
/// automatically in its closest ancestor [PageStorage], and restored when it's
/// switched back.
///
/// Usually you don't need to explicitly use a [PageStorage], since it's already
/// included in routes.
///
/// [PageStorageKey] is used by [Scrollable] if [ScrollController.keepScrollOffset]
/// is enabled to save their [ScrollPosition]s. When more than one
/// scrollable ([ListView], [SingleChildScrollView], [TextField], etc.) appears
/// within the widget's closest ancestor [PageStorage] (such as within the same route),
/// if you want to save all of their positions independently,
/// you should give each of them unique [PageStorageKey]s, or set some of their
/// `keepScrollOffset` false to prevent saving.
///
/// {@tool dartpad}
/// This sample shows how to explicitly use a [PageStorage] to
/// store the states of its children pages. Each page includes a scrollable
/// list, whose position is preserved when switching between the tabs thanks to
/// the help of [PageStorageKey].
///
/// ** See code in examples/api/lib/widgets/page_storage/page_storage.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ModalRoute], which includes this class.
class PageStorageModifier extends SingleChildStatelessModifier {
  /// Creates a widget that provides a storage bucket for its descendants.
  ///
  /// The [bucket] argument must not be null.
  const PageStorageModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.bucket,
  });

  
  /// The page storage bucket to use for this subtree.
  final PageStorageBucket bucket;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PageStorage(
      key: modifierKey,
      bucket: bucket,
      child: child!,
    );
  }
}
