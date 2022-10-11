import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that insets its child by sufficient padding to avoid intrusions by
/// the operating system.
///
/// For example, this will indent the child by enough to avoid the status bar at
/// the top of the screen.
///
/// It will also indent the child by the amount necessary to avoid The Notch on
/// the iPhone X, or other similar creative physical features of the display.
///
/// When a [minimum] padding is specified, the greater of the minimum padding
/// or the safe area padding will be applied.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=lkF0TQJO0bA}
///
/// See also:
///
///  * [SliverSafeArea], for insetting slivers to avoid operating system
///    intrusions.
///  * [Padding], for insetting widgets in general.
///  * [MediaQuery], from which the window padding is obtained.
///  * [dart:ui.FlutterView.padding], which reports the padding from the operating
///    system.
class SafeAreaModifier extends SingleChildStatelessModifier {
  /// Creates a widget that avoids operating system interfaces.
  ///
  /// The [left], [top], [right], [bottom], and [minimum] arguments must not be
  /// null.
  const SafeAreaModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  });

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// This minimum padding to apply.
  ///
  /// The greater of the minimum insets and the media padding will be applied.
  final EdgeInsets minimum;

  /// Specifies whether the [SafeArea] should maintain the bottom
  /// [MediaQueryData.viewPadding] instead of the bottom [MediaQueryData.padding],
  /// defaults to false.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// SafeArea, the padding can be maintained below the obstruction rather than
  /// being consumed. This can be helpful in cases where your layout contains
  /// flexible widgets, which could visibly move when opening a software
  /// keyboard due to the change in the padding value. Setting this to true will
  /// avoid the UI shift.
  final bool maintainBottomViewPadding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SafeArea(
      key: modifierKey,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child!,
    );
  }
}

/// A sliver that insets another sliver by sufficient padding to avoid
/// intrusions by the operating system.
///
/// For example, this will indent the sliver by enough to avoid the status bar
/// at the top of the screen.
///
/// It will also indent the sliver by the amount necessary to avoid The Notch
/// on the iPhone X, or other similar creative physical features of the
/// display.
///
/// When a [minimum] padding is specified, the greater of the minimum padding
/// or the safe area padding will be applied.
///
/// See also:
///
///  * [SafeArea], for insetting widgets to avoid operating system intrusions.
///  * [SliverPadding], for insetting slivers in general.
///  * [MediaQuery], from which the window padding is obtained.
///  * [dart:ui.FlutterView.padding], which reports the padding from the operating
///    system.
class SliverSafeAreaModifier extends SingleChildStatelessModifier {
  /// Creates a sliver that avoids operating system interfaces.
  ///
  /// The [left], [top], [right], [bottom], and [minimum] arguments must not be null.
  const SliverSafeAreaModifier({
    super.key,
    Widget? sliver,
    super.modifierKey,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
  }) : super(child: sliver);

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// This minimum padding to apply.
  ///
  /// The greater of the minimum padding and the media padding is be applied.
  final EdgeInsets minimum;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliverSafeArea(
      key: modifierKey,
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      minimum: minimum,
      sliver: child!,
    );
  }
}
