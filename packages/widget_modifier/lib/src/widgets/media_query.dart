import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Establishes a subtree in which media queries resolve to the given data.
///
/// For example, to learn the size of the current media (e.g., the window
/// containing your app), you can read the [MediaQueryData.size] property from
/// the [MediaQueryData] returned by [MediaQuery.of]:
/// `MediaQuery.of(context).size`.
///
/// Querying the current media using [MediaQuery.of] will cause your widget to
/// rebuild automatically whenever the [MediaQueryData] changes (e.g., if the
/// user rotates their device).
///
/// If no [MediaQuery] is in scope then the [MediaQuery.of] method will throw an
/// exception. Alternatively, [MediaQuery.maybeOf] may be used, which returns
/// null instead of throwing if no [MediaQuery] is in scope.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=A3WrA4zAaPw}
///
/// See also:
///
///  * [WidgetsApp] and [MaterialApp], which introduce a [MediaQuery] and keep
///    it up to date with the current screen metrics as they change.
///  * [MediaQueryData], the data structure that represents the metrics.
class MediaQueryModifier extends SingleChildStatelessModifier {
  /// Creates a widget that provides [MediaQueryData] to its descendants.
  ///
  /// The [data] and [child] arguments must not be null.
  const MediaQueryModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Creates a new [MediaQuery] that inherits from the ambient [MediaQuery]
  /// from the given context, but removes the specified padding.
  ///
  /// This should be inserted into the widget tree when the [MediaQuery] padding
  /// is consumed by a widget in such a way that the padding is no longer
  /// exposed to the widget's descendants or siblings.
  ///
  /// The [context] argument is required, must not be null, and must have a
  /// [MediaQuery] in scope.
  ///
  /// The `removeLeft`, `removeTop`, `removeRight`, and `removeBottom` arguments
  /// must not be null. If all four are false (the default) then the returned
  /// [MediaQuery] reuses the ambient [MediaQueryData] unmodified, which is not
  /// particularly useful.
  ///
  /// The [child] argument is required and must not be null.
  ///
  /// See also:
  ///
  ///  * [SafeArea], which both removes the padding from the [MediaQuery] and
  ///    adds a [Padding] widget.
  ///  * [MediaQueryData.padding], the affected property of the
  ///    [MediaQueryData].
  ///  * [removeViewInsets], the same thing but for [MediaQueryData.viewInsets].
  ///  * [removeViewPadding], the same thing but for
  ///    [MediaQueryData.viewPadding].
  factory MediaQueryModifier.removePadding({
    Key? key,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
    Widget? child,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removePadding(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  /// Creates a new [MediaQuery] that inherits from the ambient [MediaQuery]
  /// from the given context, but removes the specified view insets.
  ///
  /// This should be inserted into the widget tree when the [MediaQuery] view
  /// insets are consumed by a widget in such a way that the view insets are no
  /// longer exposed to the widget's descendants or siblings.
  ///
  /// The [context] argument is required, must not be null, and must have a
  /// [MediaQuery] in scope.
  ///
  /// The `removeLeft`, `removeTop`, `removeRight`, and `removeBottom` arguments
  /// must not be null. If all four are false (the default) then the returned
  /// [MediaQuery] reuses the ambient [MediaQueryData] unmodified, which is not
  /// particularly useful.
  ///
  /// The [child] argument is required and must not be null.
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.viewInsets], the affected property of the
  ///    [MediaQueryData].
  ///  * [removePadding], the same thing but for [MediaQueryData.padding].
  ///  * [removeViewPadding], the same thing but for
  ///    [MediaQueryData.viewPadding].
  factory MediaQueryModifier.removeViewInsets({
    Key? key,
    Widget? child,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removeViewInsets(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  /// Creates a new [MediaQuery] that inherits from the ambient [MediaQuery]
  /// from the given context, but removes the specified view padding.
  ///
  /// This should be inserted into the widget tree when the [MediaQuery] view
  /// padding is consumed by a widget in such a way that the view padding is no
  /// longer exposed to the widget's descendants or siblings.
  ///
  /// The [context] argument is required, must not be null, and must have a
  /// [MediaQuery] in scope.
  ///
  /// The `removeLeft`, `removeTop`, `removeRight`, and `removeBottom` arguments
  /// must not be null. If all four are false (the default) then the returned
  /// [MediaQuery] reuses the ambient [MediaQueryData] unmodified, which is not
  /// particularly useful.
  ///
  /// The [child] argument is required and must not be null.
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.viewPadding], the affected property of the
  ///    [MediaQueryData].
  ///  * [removePadding], the same thing but for [MediaQueryData.padding].
  ///  * [removeViewInsets], the same thing but for [MediaQueryData.viewInsets].
  factory MediaQueryModifier.removeViewPadding({
    Key? key,
    Widget? child,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removeViewPadding(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  /// Contains information about the current media.
  ///
  /// For example, the [MediaQueryData.size] property contains the width and
  /// height of the current window.
  final MediaQueryData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MediaQuery(key: modifierKey, data: data, child: child!);
  }
}
