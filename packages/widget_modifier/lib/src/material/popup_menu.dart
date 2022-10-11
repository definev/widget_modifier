import 'package:flutter/material.dart';

import '../modifier.dart';

/// An item in a Material Design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// To show a checkmark next to a popup menu item, consider using
/// [CheckedPopupMenuItem].
///
/// Typically the [child] of a [PopupMenuItem] is a [Text] widget. More
/// elaborate menus with icons can use a [ListTile]. By default, a
/// [PopupMenuItem] is [kMinInteractiveDimension] pixels high. If you use a widget
/// with a different height, it must be specified in the [height] property.
///
/// {@tool snippet}
///
/// Here, a [Text] widget is used with a popup menu item. The `Menu` type
/// is an enum, not shown here.
///
/// ```dart
/// const PopupMenuItem<Menu>(
///   value: Menu.itemOne,
///   child: Text('Item 1'),
/// )
/// ```
/// {@end-tool}
///
/// See the example at [PopupMenuButton] for how this example could be used in a
/// complete menu, and see the example at [CheckedPopupMenuItem] for one way to
/// keep the text of [PopupMenuItem]s that use [Text] widgets in their [child]
/// slot aligned with the text of [CheckedPopupMenuItem]s or of [PopupMenuItem]
/// that use a [ListTile] in their [child] slot.
///
/// See also:
///
///  * [PopupMenuDivider], which can be used to divide items from each other.
///  * [CheckedPopupMenuItem], a variant of [PopupMenuItem] with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class PopupMenuItemModifier<T> extends SingleChildStatelessModifier {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is [enabled].
  ///
  /// The `enabled` and `height` arguments must not be null.
  const PopupMenuItemModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.value,
    this.onTap,
    this.enabled = true,
    this.height = kMinInteractiveDimension,
    this.padding,
    this.textStyle,
    this.mouseCursor,
  });

  /// The value that will be returned by [showMenu] if this entry is selected.
  final T? value;

  /// Called when the menu item is tapped.
  final VoidCallback? onTap;

  /// Whether the user is permitted to select this item.
  ///
  /// Defaults to true. If this is false, then the item will not react to
  /// touches.
  final bool enabled;

  /// The minimum height of the menu item.
  ///
  /// Defaults to [kMinInteractiveDimension] pixels.
  final double height;

  /// The padding of the menu item.
  ///
  /// Note that [height] may interact with the applied padding. For example,
  /// If a [height] greater than the height of the sum of the padding and [child]
  /// is provided, then the padding's effect will not be visible.
  ///
  /// When null, the horizontal padding defaults to 16.0 on both sides.
  final EdgeInsets? padding;

  /// The text style of the popup menu item.
  ///
  /// If this property is null, then [PopupMenuThemeData.textStyle] is used.
  /// If [PopupMenuThemeData.textStyle] is also null, then [TextTheme.subtitle1]
  /// of [ThemeData.textTheme] is used.
  final TextStyle? textStyle;

  /// {@template flutter.material.popupmenu.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// If null, then the value of [PopupMenuThemeData.mouseCursor] is used. If
  /// that is also null, then [MaterialStateMouseCursor.clickable] is used.
  final MouseCursor? mouseCursor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuItem<T>(
      key: modifierKey,
      enabled: enabled,
      height: height,
      mouseCursor: mouseCursor,
      onTap: onTap,
      padding: padding,
      textStyle: textStyle,
      value: value,
      child: child,
    );
  }
}


/// An item with a checkmark in a Material Design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// A [CheckedPopupMenuItem] is kMinInteractiveDimension pixels high, which
/// matches the default minimum height of a [PopupMenuItem]. The horizontal
/// layout uses [ListTile]; the checkmark is an [Icons.done] icon, shown in the
/// [ListTile.leading] position.
///
/// {@tool snippet}
///
/// Suppose a `Commands` enum exists that lists the possible commands from a
/// particular popup menu, including `Commands.heroAndScholar` and
/// `Commands.hurricaneCame`, and further suppose that there is a
/// `_heroAndScholar` member field which is a boolean. The example below shows a
/// menu with one menu item with a checkmark that can toggle the boolean, and
/// one menu item without a checkmark for selecting the second option. (It also
/// shows a divider placed between the two menu items.)
///
/// ```dart
/// PopupMenuButton<Commands>(
///   onSelected: (Commands result) {
///     switch (result) {
///       case Commands.heroAndScholar:
///         setState(() { _heroAndScholar = !_heroAndScholar; });
///         break;
///       case Commands.hurricaneCame:
///         // ...handle hurricane option
///         break;
///       // ...other items handled here
///     }
///   },
///   itemBuilder: (BuildContext context) => <PopupMenuEntry<Commands>>[
///     CheckedPopupMenuItem<Commands>(
///       checked: _heroAndScholar,
///       value: Commands.heroAndScholar,
///       child: const Text('Hero and scholar'),
///     ),
///     const PopupMenuDivider(),
///     const PopupMenuItem<Commands>(
///       value: Commands.hurricaneCame,
///       child: ListTile(leading: Icon(null), title: Text('Bring hurricane')),
///     ),
///     // ...other items listed here
///   ],
/// )
/// ```
/// {@end-tool}
///
/// In particular, observe how the second menu item uses a [ListTile] with a
/// blank [Icon] in the [ListTile.leading] position to get the same alignment as
/// the item with the checkmark.
///
/// See also:
///
///  * [PopupMenuItem], a popup menu entry for picking a command (as opposed to
///    toggling a value).
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class CheckedPopupMenuItemModifier<T> extends PopupMenuItemModifier<T> {
  /// Creates a popup menu item with a checkmark.
  ///
  /// By default, the menu item is [enabled] but unchecked. To mark the item as
  /// checked, set [checked] to true.
  ///
  /// The `checked` and `enabled` arguments must not be null.
  const CheckedPopupMenuItemModifier({
    super.key,
    super.modifierKey,
    super.value,
    this.checked = false,
    super.enabled,
    super.padding,
    super.height,
    super.mouseCursor,
    super.child,
  });

  /// Whether to display a checkmark next to the menu item.
  ///
  /// Defaults to false.
  ///
  /// When true, an [Icons.done] checkmark is displayed.
  ///
  /// When this popup menu item is selected, the checkmark will fade in or out
  /// as appropriate to represent the implied new state.
  final bool checked;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckedPopupMenuItem<T>(
      key: modifierKey,
      checked: checked,
      enabled: enabled,
      height: height,
      mouseCursor: mouseCursor,
      padding: padding,
      value: value,
      child: child,
    );
  }
}


/// Displays a menu when pressed and calls [onSelected] when the menu is dismissed
/// because an item was selected. The value passed to [onSelected] is the value of
/// the selected menu item.
///
/// One of [child] or [icon] may be provided, but not both. If [icon] is provided,
/// then [PopupMenuButton] behaves like an [IconButton].
///
/// If both are null, then a standard overflow icon is created (depending on the
/// platform).
///
/// {@tool dartpad}
/// This example shows a menu with four items, selecting between an enum's
/// values and setting a `_selectedMenu` field based on the selection
///
/// ** See code in examples/api/lib/material/popupmenu/popupmenu.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [PopupMenuItem], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItem], a popup menu item with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
class PopupMenuButtonModifier<T> extends SingleChildStatelessModifier {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const PopupMenuButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback,
    this.constraints,
    this.position = PopupMenuPosition.over,
  });

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the user selects a value from the popup menu created by this button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemSelected<T>? onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled? onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double? elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// The splash radius.
  ///
  /// If null, default splash radius of [InkWell] or [IconButton] is used.
  final double? splashRadius;
  
  /// If provided, the [icon] is used for this button
  /// and the button will behave like an [IconButton].
  final Widget? icon;

  /// The offset is applied relative to the initial position
  /// set by the [position].
  ///
  /// When not set, the offset defaults to [Offset.zero].
  final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// Theme.of(context).cardColor is used.
  final Color? color;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// If provided, the size of the [Icon].
  ///
  /// If this property is null, then [IconThemeData.size] is used.
  /// If [IconThemeData.size] is also null, then
  /// default size is 24.0 pixels.
  final double? iconSize;

  /// Optional size constraints for the menu.
  ///
  /// When unspecified, defaults to:
  /// ```dart
  /// const BoxConstraints(
  ///   minWidth: 2.0 * 56.0,
  ///   maxWidth: 5.0 * 56.0,
  /// )
  /// ```
  ///
  /// The default constraints ensure that the menu width matches maximum width
  /// recommended by the Material Design guidelines.
  /// Specifying this parameter enables creation of menu wider than
  /// the default maximum width.
  final BoxConstraints? constraints;

  /// Whether the popup menu is positioned over or under the popup menu button.
  ///
  /// [offset] is used to change the position of the popup menu relative to the
  /// position set by this parameter.
  ///
  /// When not set, the position defaults to [PopupMenuPosition.over] which makes the
  /// popup menu appear directly over the button that was used to create it.
  final PopupMenuPosition position;


  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuButton<T>(
      key: modifierKey,
      color: color,
      constraints: constraints,
      elevation: elevation,
      enableFeedback: enableFeedback,
      enabled: enabled,
      icon: icon,
      iconSize: iconSize,
      initialValue: initialValue,
      offset: offset,
      onCanceled: onCanceled,
      onSelected: onSelected,
      padding: padding,
      position: position,
      shape: shape,
      splashRadius: splashRadius,
      tooltip: tooltip,
      itemBuilder: itemBuilder,
      child: child,
    );
  }
}
