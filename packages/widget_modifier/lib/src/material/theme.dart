import 'package:flutter/material.dart';

import '../modifier.dart';
import '../widgets/implicit_animations.dart';

/// Applies a theme to descendant widgets.
///
/// A theme describes the colors and typographic choices of an application.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oTvQDJOBXmM}
///
/// Descendant widgets obtain the current theme's [ThemeData] object using
/// [Theme.of]. When a widget uses [Theme.of], it is automatically rebuilt if
/// the theme later changes, so that the changes can be applied.
///
/// The [Theme] widget implies an [IconTheme] widget, set to the value of the
/// [ThemeData.iconTheme] of the [data] for the [Theme].
///
/// See also:
///
///  * [ThemeData], which describes the actual configuration of a theme.
///  * [AnimatedTheme], which animates the [ThemeData] when it changes rather
///    than changing the theme all at once.
///  * [MaterialApp], which includes an [AnimatedTheme] widget configured via
///    the [MaterialApp.theme] argument.
class ThemeModifier extends SingleChildStatelessModifier {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const ThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the color and typography values for descendant widgets.
  final ThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Theme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}


/// Animated version of [Theme] which automatically transitions the colors,
/// etc, over a given duration whenever the given theme changes.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.elasticInOut].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_theme.mp4}
///
/// See also:
///
///  * [Theme], which [AnimatedTheme] uses to actually apply the interpolated
///    theme.
///  * [ThemeData], which describes the actual configuration of a theme.
///  * [MaterialApp], which includes an [AnimatedTheme] widget configured via
///    the [MaterialApp.theme] argument.
class AnimatedThemeModifier extends SingleChildImplicitlyAnimatedModifier {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve. The [data] and
  /// [child] arguments must not be null.
  const AnimatedThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
  });

  /// Specifies the color and typography values for descendant widgets.
  final ThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedTheme(
      key: modifierKey,
      data: data,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child!,
    );
  }
}
