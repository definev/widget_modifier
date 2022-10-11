import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// A full-screen modal route that opens when the [child] is long-pressed.
///
/// When open, the [CupertinoContextMenu] shows the child, or the widget returned
/// by [previewBuilder] if given, in a large full-screen [Overlay] with a list
/// of buttons specified by [actions]. The child/preview is placed in an
/// [Expanded] widget so that it will grow to fill the Overlay if its size is
/// unconstrained.
///
/// When closed, the CupertinoContextMenu simply displays the child as if the
/// CupertinoContextMenu were not there. Sizing and positioning is unaffected.
/// The menu can be closed like other [PopupRoute]s, such as by tapping the
/// background or by calling `Navigator.pop(context)`. Unlike PopupRoute, it can
/// also be closed by swiping downwards.
///
/// The [previewBuilder] parameter is most commonly used to display a slight
/// variation of [child]. See [previewBuilder] for an example of rounding the
/// child's corners and allowing its aspect ratio to expand, similar to the
/// Photos app on iOS.
///
/// {@tool dartpad}
/// This sample shows a very simple CupertinoContextMenu for an empty red
/// 100x100 Container. Simply long press on it to open.
///
/// ** See code in examples/api/lib/cupertino/context_menu/cupertino_context_menu.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/controls/context-menus/>
class CupertinoContextMenuModifier extends SingleChildStatelessModifier {
  /// Create a context menu.
  ///
  /// [actions] is required and cannot be null or empty.
  ///
  /// [child] is required and cannot be null.
  const CupertinoContextMenuModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.actions,
    this.previewBuilder,
  });

  
  /// The actions that are shown in the menu.
  ///
  /// These actions are typically [CupertinoContextMenuAction]s.
  ///
  /// This parameter cannot be null or empty.
  final List<Widget> actions;
 
  /// A function that returns an alternative widget to show when the
  /// [CupertinoContextMenu] is open.
  ///
  /// If not specified, [child] will be shown.
  ///
  /// The preview is often used to show a slight variation of the [child]. For
  /// example, the child could be given rounded corners in the preview but have
  /// sharp corners when in the page.
  ///
  /// In addition to the current [BuildContext], the function is also called
  /// with an [Animation] and the [child]. The animation goes from 0 to 1 when
  /// the CupertinoContextMenu opens, and from 1 to 0 when it closes, and it can
  /// be used to animate the preview in sync with this opening and closing. The
  /// child parameter provides access to the child displayed when the
  /// CupertinoContextMenu is closed.
  ///
  /// {@tool snippet}
  ///
  /// Below is an example of using `previewBuilder` to show an image tile that's
  /// similar to each tile in the iOS iPhoto app's context menu. Several of
  /// these could be used in a GridView for a similar effect.
  ///
  /// When opened, the child animates to show its full aspect ratio and has
  /// rounded corners. The larger size of the open CupertinoContextMenu allows
  /// the FittedBox to fit the entire image, even when it has a very tall or
  /// wide aspect ratio compared to the square of a GridView, so this animates
  /// into view as the CupertinoContextMenu is opened. The preview is swapped in
  /// right when the open animation begins, which includes the rounded corners.
  ///
  /// ```dart
  /// CupertinoContextMenu(
  ///   // The FittedBox in the preview here allows the image to animate its
  ///   // aspect ratio when the CupertinoContextMenu is animating its preview
  ///   // widget open and closed.
  ///   previewBuilder: (BuildContext context, Animation<double> animation, Widget child) {
  ///     return FittedBox(
  ///       fit: BoxFit.cover,
  ///       // This ClipRRect rounds the corners of the image when the
  ///       // CupertinoContextMenu is open, even though it's not rounded when
  ///       // it's closed. It uses the given animation to animate the corners
  ///       // in sync with the opening animation.
  ///       child: ClipRRect(
  ///         borderRadius: BorderRadius.circular(64.0 * animation.value),
  ///         child: Image.asset('assets/photo.jpg'),
  ///       ),
  ///     );
  ///   },
  ///   actions: <Widget>[
  ///     CupertinoContextMenuAction(
  ///       child: const Text('Action one'),
  ///       onPressed: () {},
  ///     ),
  ///   ],
  ///   child: FittedBox(
  ///     fit: BoxFit.cover,
  ///     child: Image.asset('assets/photo.jpg'),
  ///   ),
  /// )
  /// ```
  ///
  /// {@end-tool}
  final ContextMenuPreviewBuilder? previewBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoContextMenu(
      key: modifierKey,
      actions: actions,
      previewBuilder: previewBuilder,
      child: child!,
    );
  }
}
