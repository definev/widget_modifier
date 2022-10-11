import 'package:flutter/material.dart';

import '../modifier.dart';

/// A piece of material.
///
/// The Material widget is responsible for:
///
/// 1. Clipping: If [clipBehavior] is not [Clip.none], Material clips its widget
///    sub-tree to the shape specified by [shape], [type], and [borderRadius].
///    By default, [clipBehavior] is [Clip.none] for performance considerations.
///    See [Ink] for an example of how this affects clipping [Ink] widgets.
/// 2. Elevation: Material elevates its widget sub-tree on the Z axis by
///    [elevation] pixels, and draws the appropriate shadow.
/// 3. Ink effects: Material shows ink effects implemented by [InkFeature]s
///    like [InkSplash] and [InkHighlight] below its children.
///
/// ## The Material Metaphor
///
/// Material is the central metaphor in Material Design. Each piece of material
/// exists at a given elevation, which influences how that piece of material
/// visually relates to other pieces of material and how that material casts
/// shadows.
///
/// Most user interface elements are either conceptually printed on a piece of
/// material or themselves made of material. Material reacts to user input using
/// [InkSplash] and [InkHighlight] effects. To trigger a reaction on the
/// material, use a [MaterialInkController] obtained via [Material.of].
///
/// In general, the features of a [Material] should not change over time (e.g. a
/// [Material] should not change its [color], [shadowColor] or [type]).
/// Changes to [elevation], [shadowColor] and [surfaceTintColor] are animated
/// for [animationDuration]. Changes to [shape] are animated if [type] is
/// not [MaterialType.transparency] and [ShapeBorder.lerp] between the previous
/// and next [shape] values is supported. Shape changes are also animated
/// for [animationDuration].
///
/// ## Shape
///
/// The shape for material is determined by [shape], [type], and [borderRadius].
///
///  - If [shape] is non null, it determines the shape.
///  - If [shape] is null and [borderRadius] is non null, the shape is a
///    rounded rectangle, with corners specified by [borderRadius].
///  - If [shape] and [borderRadius] are null, [type] determines the
///    shape as follows:
///    - [MaterialType.canvas]: the default material shape is a rectangle.
///    - [MaterialType.card]: the default material shape is a rectangle with
///      rounded edges. The edge radii is specified by [kMaterialEdges].
///    - [MaterialType.circle]: the default material shape is a circle.
///    - [MaterialType.button]: the default material shape is a rectangle with
///      rounded edges. The edge radii is specified by [kMaterialEdges].
///    - [MaterialType.transparency]: the default material shape is a rectangle.
///
/// ## Border
///
/// If [shape] is not null, then its border will also be painted (if any).
///
/// ## Layout change notifications
///
/// If the layout changes (e.g. because there's a list on the material, and it's
/// been scrolled), a [LayoutChangedNotification] must be dispatched at the
/// relevant subtree. This in particular means that transitions (e.g.
/// [SlideTransition]) should not be placed inside [Material] widgets so as to
/// move subtrees that contain [InkResponse]s, [InkWell]s, [Ink]s, or other
/// widgets that use the [InkFeature] mechanism. Otherwise, in-progress ink
/// features (e.g., ink splashes and ink highlights) won't move to account for
/// the new layout.
///
/// ## Painting over the material
///
/// Material widgets will often trigger reactions on their nearest material
/// ancestor. For example, [ListTile.hoverColor] triggers a reaction on the
/// tile's material when a pointer is hovering over it. These reactions will be
/// obscured if any widget in between them and the material paints in such a
/// way as to obscure the material (such as setting a [BoxDecoration.color] on
/// a [DecoratedBox]). To avoid this behavior, use [InkDecoration] to decorate
/// the material itself.
///
/// See also:
///
///  * [MergeableMaterial], a piece of material that can split and re-merge.
///  * [Card], a wrapper for a [Material] of [type] [MaterialType.card].
///  * <https://material.io/design/>
///  * <https://m3.material.io/styles/color/the-color-system/color-roles>
class MaterialModifier extends SingleChildStatelessModifier {
  /// Creates a piece of material.
  ///
  /// The [type], [elevation], [borderOnForeground],
  /// [clipBehavior], and [animationDuration] arguments must not be null.
  /// Additionally, [elevation] must be non-negative.
  ///
  /// If a [shape] is specified, then the [borderRadius] property must be
  /// null and the [type] property must not be [MaterialType.circle]. If the
  /// [borderRadius] is specified, then the [type] property must not be
  /// [MaterialType.circle]. In both cases, these restrictions are intended to
  /// catch likely errors.
  const MaterialModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.type = MaterialType.canvas,
    this.elevation = 0.0,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.textStyle,
    this.borderRadius,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
  });

  /// The kind of material to show (e.g., card or canvas). This
  /// affects the shape of the widget, the roundness of its corners if
  /// the shape is rectangular, and the default color.
  final MaterialType type;

  /// {@template flutter.material.material.elevation}
  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material and the opacity
  /// of the elevation overlay color if it is applied.
  ///
  /// If this is non-zero, the contents of the material are clipped, because the
  /// widget conceptually defines an independent printed piece of material.
  ///
  /// Defaults to 0. Changing this value will cause the shadow and the elevation
  /// overlay or surface tint to animate over [Material.animationDuration].
  ///
  /// The value is non-negative.
  ///
  /// See also:
  ///
  ///  * [ThemeData.useMaterial3] which defines whether a surface tint or
  ///    elevation overlay is used to indicate elevation.
  ///  * [ThemeData.applyElevationOverlayColor] which controls the whether
  ///    an overlay color will be applied to indicate elevation.
  ///  * [Material.color] which may have an elevation overlay applied.
  ///  * [Material.shadowColor] which will be used for the color of a drop shadow.
  ///  * [Material.surfaceTintColor] which will be used as the overlay tint to
  ///    show elevation.
  /// {@endtemplate}
  final double elevation;

  /// The color to paint the material.
  ///
  /// Must be opaque. To create a transparent piece of material, use
  /// [MaterialType.transparency].
  ///
  /// If [ThemeData.useMaterial3] is true then an optional [surfaceTintColor]
  /// overlay may be applied on top of this color to indicate elevation.
  ///
  /// If [ThemeData.useMaterial3] is false and [ThemeData.applyElevationOverlayColor]
  /// is true and [ThemeData.brightness] is [Brightness.dark] then a
  /// semi-transparent overlay color will be composited on top of this
  /// color to indicate the elevation. This is no longer needed for Material
  /// Design 3, which uses [surfaceTintColor].
  ///
  /// By default, the color is derived from the [type] of material.
  final Color? color;

  /// The color to paint the shadow below the material.
  ///
  /// When [ThemeData.useMaterial3] is true, and this is null, then no drop
  /// shadow will be rendered for this material. If it is non-null, then this
  /// color will be used to render a drop shadow below the material.
  ///
  /// When [ThemeData.useMaterial3] is false, and this is null, then
  /// [ThemeData.shadowColor] is used, which defaults to fully opaque black.
  ///
  /// See also:
  ///  * [ThemeData.useMaterial3], which determines the default value for this
  ///    property if it is null.
  ///  * [ThemeData.applyElevationOverlayColor], which turns elevation overlay
  /// on or off for dark themes.
  final Color? shadowColor;

  /// The color of the surface tint overlay applied to the material color
  /// to indicate elevation.
  ///
  /// Material Design 3 introduced a new way for some components to indicate
  /// their elevation by using a surface tint color overlay on top of the
  /// base material [color]. This overlay is painted with an opacity that is
  /// related to the [elevation] of the material.
  ///
  /// If [ThemeData.useMaterial3] is false, then this property is not used.
  ///
  /// If [ThemeData.useMaterial3] is true and [surfaceTintColor] is not null,
  /// then it will be used to overlay the base [color] with an opacity based
  /// on the [elevation].
  ///
  /// Otherwise, no surface tint will be applied.
  ///
  /// See also:
  ///
  ///   * [ThemeData.useMaterial3], which turns this feature on.
  ///   * [ElevationOverlay.applySurfaceTint], which is used to implement the
  ///     tint.
  ///   * https://m3.material.io/styles/color/the-color-system/color-roles
  ///     which specifies how the overlay is applied.
  final Color? surfaceTintColor;

  /// The typographical style to use for text within this material.
  final TextStyle? textStyle;

  /// Defines the material's shape as well its shadow.
  ///
  /// If shape is non null, the [borderRadius] is ignored and the material's
  /// clip boundary and shadow are defined by the shape.
  ///
  /// A shadow is only displayed if the [elevation] is greater than
  /// zero.
  final ShapeBorder? shape;

  /// Whether to paint the [shape] border in front of the [child].
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the [child].
  final bool borderOnForeground;

  /// {@template flutter.material.Material.clipBehavior}
  /// The content will be clipped (or not) according to this option.
  ///
  /// See the enum [Clip] for details of all possible options and their common
  /// use cases.
  /// {@endtemplate}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// Defines the duration of animated changes for [shape], [elevation],
  /// [shadowColor], [surfaceTintColor] and the elevation overlay if it is applied.
  ///
  /// The default value is [kThemeChangeDuration].
  final Duration animationDuration;

  /// If non-null, the corners of this box are rounded by this
  /// [BorderRadiusGeometry] value.
  ///
  /// Otherwise, the corners specified for the current [type] of material are
  /// used.
  ///
  /// If [shape] is non null then the border radius is ignored.
  ///
  /// Must be null if [type] is [MaterialType.circle].
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Material(
      key: modifierKey,
      animationDuration: animationDuration,
      borderOnForeground: borderOnForeground,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      surfaceTintColor: surfaceTintColor,
      textStyle: textStyle,
      type: type,
      child: child,
    );
  }
}
