import 'package:flutter/material.dart';

import '../modifier.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;

/// A Material Design [TabBar] tab.
///
/// If both [icon] and [text] are provided, the text is displayed below
/// the icon.
///
/// See also:
///
///  * [TabBar], which displays a row of tabs.
///  * [TabBarView], which displays a widget for the currently selected tab.
///  * [TabController], which coordinates tab selection between a [TabBar] and a [TabBarView].
///  * <https://material.io/design/components/tabs.html>
class TabModifier extends SingleChildStatelessModifier implements PreferredSizeWidget {
  /// Creates a Material Design [TabBar] tab.
  ///
  /// At least one of [text], [icon], and [child] must be non-null. The [text]
  /// and [child] arguments must not be used at the same time. The
  /// [iconMargin] is only useful when [icon] and either one of [text] or
  /// [child] is non-null.
  const TabModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.text,
    this.icon,
    this.iconMargin = const EdgeInsets.only(bottom: 10.0),
    this.height,
  })  : assert(text != null || child != null || icon != null),
        assert(text == null || child == null);

  /// The text to display as the tab's label.
  ///
  /// Must not be used in combination with [child].
  final String? text;

  /// An icon to display as the tab's label.
  final Widget? icon;

  /// The margin added around the tab's icon.
  ///
  /// Only useful when used in combination with [icon], and either one of
  /// [text] or [child] is non-null.
  final EdgeInsetsGeometry iconMargin;

  /// The height of the [Tab].
  ///
  /// If null, the height will be calculated based on the content of the [Tab].  When `icon` is not
  /// null along with `child` or `text`, the default height is 72.0 pixels. Without an `icon`, the
  /// height is 46.0 pixels.
  final double? height;

  @override
  Size get preferredSize {
    if (height != null) {
      return Size.fromHeight(height!);
    } else if (text != null && icon != null) {
      return const Size.fromHeight(_kTextAndIconTabHeight);
    } else {
      return const Size.fromHeight(_kTabHeight);
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Tab(
      key: modifierKey,
      height: height,
      icon: icon,
      iconMargin: iconMargin,
      text: text,
      child: child,
    );
  }
}
