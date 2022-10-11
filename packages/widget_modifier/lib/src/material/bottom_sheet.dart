import 'package:flutter/material.dart';
import '../modifier.dart';
import '../widgets/basic.dart';

/// A Material Design bottom sheet.
///
/// There are two kinds of bottom sheets in Material Design:
///
///  * _Persistent_. A persistent bottom sheet shows information that
///    supplements the primary content of the app. A persistent bottom sheet
///    remains visible even when the user interacts with other parts of the app.
///    Persistent bottom sheets can be created and displayed with the
///    [ScaffoldState.showBottomSheet] function or by specifying the
///    [Scaffold.bottomSheet] constructor parameter.
///
///  * _Modal_. A modal bottom sheet is an alternative to a menu or a dialog and
///    prevents the user from interacting with the rest of the app. Modal bottom
///    sheets can be created and displayed with the [showModalBottomSheet]
///    function.
///
/// The [BottomSheet] widget itself is rarely used directly. Instead, prefer to
/// create a persistent bottom sheet with [ScaffoldState.showBottomSheet] or
/// [Scaffold.bottomSheet], and a modal bottom sheet with [showModalBottomSheet].
///
/// See also:
///
///  * [showBottomSheet] and [ScaffoldState.showBottomSheet], for showing
///    non-modal "persistent" bottom sheets.
///  * [showModalBottomSheet], which can be used to display a modal bottom
///    sheet.
///  * [BottomSheetThemeData], which can be used to customize the default
///    bottom sheet property values.
///  * <https://material.io/design/components/sheets-bottom.html>
class BottomSheetModifier extends SingleChildStatelessModifier {
  /// Creates a bottom sheet.
  ///
  /// Typically, bottom sheets are created implicitly by
  /// [ScaffoldState.showBottomSheet], for persistent bottom sheets, or by
  /// [showModalBottomSheet], for modal bottom sheets.
  const BottomSheetModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.animationController,
    this.enableDrag = true,
    this.onDragStart,
    this.onDragEnd,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    required this.onClosing,
    required this.builder,
  }) : assert(elevation == null || elevation >= 0.0);

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController? animationController;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final VoidCallback onClosing;

  /// A builder for the contents of the sheet.
  ///
  /// The bottom sheet will wrap the widget produced by this builder in a
  /// [Material] widget.
  final SingleChildWidgetBuilder builder;

  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// Default is true.
  final bool enableDrag;

  /// Called when the user begins dragging the bottom sheet vertically, if
  /// [enableDrag] is true.
  ///
  /// Would typically be used to change the bottom sheet animation curve so
  /// that it tracks the user's finger accurately.
  final BottomSheetDragStartHandler? onDragStart;

  /// Called when the user stops dragging the bottom sheet, if [enableDrag]
  /// is true.
  ///
  /// Would typically be used to reset the bottom sheet animation curve, so
  /// that it animates non-linearly. Called before [onClosing] if the bottom
  /// sheet is closing.
  final BottomSheetDragEndHandler? onDragEnd;

  /// The bottom sheet's background color.
  ///
  /// Defines the bottom sheet's [Material.color].
  ///
  /// Defaults to null and falls back to [Material]'s default.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material.
  ///
  /// Defaults to 0. The value is non-negative.
  final double? elevation;

  /// The shape of the bottom sheet.
  ///
  /// Defines the bottom sheet's [Material.shape].
  ///
  /// Defaults to null and falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defines the bottom sheet's [Material.clipBehavior].
  ///
  /// Use this property to enable clipping of content when the bottom sheet has
  /// a custom [shape] and the content can extend past this shape. For example,
  /// a bottom sheet with rounded corners and an edge-to-edge [Image] at the
  /// top.
  ///
  /// If this property is null then [BottomSheetThemeData.clipBehavior] of
  /// [ThemeData.bottomSheetTheme] is used. If that's null then the behavior
  /// will be [Clip.none].
  final Clip? clipBehavior;

  /// Defines minimum and maximum sizes for a [BottomSheet].
  ///
  /// Typically a bottom sheet will cover the entire width of its
  /// parent. However for large screens you may want to limit the width
  /// to something smaller and this property provides a way to specify
  /// a maximum width.
  ///
  /// If null, then the ambient [ThemeData.bottomSheetTheme]'s
  /// [BottomSheetThemeData.constraints] will be used. If that
  /// is null then the bottom sheet's size will be constrained
  /// by its parent (usually a [Scaffold]).
  ///
  /// If constraints are specified (either in this property or in the
  /// theme), the bottom sheet will be aligned to the bottom-center of
  /// the available space. Otherwise, no alignment is applied.
  final BoxConstraints? constraints;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BottomSheet(
      key: modifierKey,
      onClosing: onClosing,
      builder: (BuildContext context) => builder(context, child),
      animationController: animationController,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      constraints: constraints,
      elevation: elevation,
      enableDrag: enableDrag,
      onDragEnd: onDragEnd,
      onDragStart: onDragStart,
      shape: shape,
    );
  }
}
