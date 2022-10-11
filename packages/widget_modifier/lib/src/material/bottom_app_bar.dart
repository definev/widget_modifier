import 'package:flutter/material.dart';

import '../modifier.dart';

/// A container that is typically used with [Scaffold.bottomNavigationBar], and
/// can have a notch along the top that makes room for an overlapping
/// [FloatingActionButton].
///
/// Typically used with a [Scaffold] and a [FloatingActionButton].
///
/// {@tool snippet}
/// ```dart
/// Scaffold(
///   bottomNavigationBar: BottomAppBar(
///     color: Colors.white,
///     child: bottomAppBarContents,
///   ),
///   floatingActionButton: const FloatingActionButton(onPressed: null),
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows the [BottomAppBar], which can be configured to have a notch using the
/// [BottomAppBar.shape] property. This also includes an optional [FloatingActionButton], which illustrates
/// the [FloatingActionButtonLocation]s in relation to the [BottomAppBar].
///
/// ** See code in examples/api/lib/material/bottom_app_bar/bottom_app_bar.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [NotchedShape] which calculates the notch for a notched [BottomAppBar].
///  * [FloatingActionButton] which the [BottomAppBar] makes a notch for.
///  * [AppBar] for a toolbar that is shown at the top of the screen.
class BottomAppBarModifier extends SingleChildStatelessModifier {
  /// Creates a bottom application bar.
  ///
  /// The [clipBehavior] argument defaults to [Clip.none] and must not be null.
  /// Additionally, [elevation] must be non-negative.
  ///
  /// If [color], [elevation], or [shape] are null, their [BottomAppBarTheme] values will be used.
  /// If the corresponding [BottomAppBarTheme] property is null, then the default
  /// specified in the property's documentation will be used.
  const BottomAppBarModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.color,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
  });

  /// The bottom app bar's background color.
  ///
  /// If this property is null then [BottomAppBarTheme.color] of
  /// [ThemeData.bottomAppBarTheme] is used. If that's null then
  /// [ThemeData.bottomAppBarColor] is used.
  final Color? color;
  
  /// The z-coordinate at which to place this bottom app bar relative to its
  /// parent.
  ///
  /// This controls the size of the shadow below the bottom app bar. The
  /// value is non-negative.
  ///
  /// If this property is null then [BottomAppBarTheme.elevation] of
  /// [ThemeData.bottomAppBarTheme] is used. If that's null, the default value
  /// is 8.
  final double? elevation;
  
  /// The notch that is made for the floating action button.
  ///
  /// If this property is null then [BottomAppBarTheme.shape] of
  /// [ThemeData.bottomAppBarTheme] is used. If that's null then the shape will
  /// be rectangular with no notch.
  final NotchedShape? shape;
 
  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;
  
  /// The margin between the [FloatingActionButton] and the [BottomAppBar]'s
  /// notch.
  ///
  /// Not used if [shape] is null.
  final double notchMargin;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BottomAppBar(
      key: modifierKey,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      notchMargin: notchMargin,
      shape: shape,
      child: child,
    );
  }
}
