import 'package:flutter/cupertino.dart';
import '../modifier.dart';

/// Implements a single iOS application page's layout.
///
/// The scaffold lays out the navigation bar on top and the content between or
/// behind the navigation bar.
///
/// When tapping a status bar at the top of the CupertinoPageScaffold, an
/// animation will complete for the current primary [ScrollView], scrolling to
/// the beginning. This is done using the [PrimaryScrollController] that
/// encloses the [ScrollView]. The [ScrollView.primary] flag is used to connect
/// a [ScrollView] to the enclosing [PrimaryScrollController].
///
/// {@tool dartpad}
/// This example shows a [CupertinoPageScaffoldModifier] with a [ListView] as a [child].
/// The [CupertinoButton] is connected to a callback that increments a counter.
/// The [backgroundColor] can be changed.
///
/// ** See code in examples/api/lib/cupertino/page_scaffold/cupertino_page_scaffold.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CupertinoTabScaffold], a similar widget for tabbed applications.
///  * [CupertinoPageRoute], a modal page route that typically hosts a
///    [CupertinoPageScaffold] with support for iOS-style page transitions.
class CupertinoPageScaffoldModifier extends SingleChildStatelessModifier {
  /// Creates a layout for pages with a navigation bar at the top.
  const CupertinoPageScaffoldModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.navigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  /// The [navigationBar], typically a [CupertinoNavigationBar], is drawn at the
  /// top of the screen.
  ///
  /// If translucent, the main content may slide behind it.
  /// Otherwise, the main content's top margin will be offset by its height.
  ///
  /// The scaffold assumes the navigation bar will account for the [MediaQuery]
  /// top padding, also consume it if the navigation bar is opaque.
  ///
  /// By default `navigationBar` has its text scale factor set to 1.0 and does
  /// not respond to text scale factor changes from the operating system, to match
  /// the native iOS behavior. To override such behavior, wrap each of the `navigationBar`'s
  /// components inside a [MediaQuery] with the desired [MediaQueryData.textScaleFactor]
  /// value. The text scale factor value from the operating system can be retrieved
  /// in many ways, such as querying [MediaQuery.textScaleFactorOf] against
  /// [CupertinoApp]'s [BuildContext].
  final ObstructingPreferredSizeWidget? navigationBar;

  /// The color of the widget that underlies the entire scaffold.
  ///
  /// By default uses [CupertinoTheme]'s `scaffoldBackgroundColor` when null.
  final Color? backgroundColor;

  /// Whether the [child] should size itself to avoid the window's bottom inset.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true and cannot be null.
  final bool resizeToAvoidBottomInset;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoPageScaffold(
      key: modifierKey,
      navigationBar: navigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      child: child!,
    );
  }
}
