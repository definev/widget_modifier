import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that enables inspecting the child widget's structure.
///
/// Select a location on your device or emulator and view what widgets and
/// render object that best matches the location. An outline of the selected
/// widget and terse summary information is shown on device with detailed
/// information is shown in the observatory or in IntelliJ when using the
/// Flutter Plugin.
///
/// The inspector has a select mode and a view mode.
///
/// In the select mode, tapping the device selects the widget that best matches
/// the location of the touch and switches to view mode. Dragging a finger on
/// the device selects the widget under the drag location but does not switch
/// modes. Touching the very edge of the bounding box of a widget triggers
/// selecting the widget even if another widget that also overlaps that
/// location would otherwise have priority.
///
/// In the view mode, the previously selected widget is outlined, however,
/// touching the device has the same effect it would have if the inspector
/// wasn't present. This allows interacting with the application and viewing how
/// the selected widget changes position. Clicking on the select icon in the
/// bottom left corner of the application switches back to select mode.
class WidgetInspectorModifier extends SingleChildStatelessModifier {
  /// Creates a widget that enables inspection for the child.
  ///
  /// The [child] argument must not be null.
  const WidgetInspectorModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.selectButtonBuilder,
  });

  /// A builder that is called to create the select button.
  ///
  /// The `onPressed` callback passed as an argument to the builder should be
  /// hooked up to the returned widget.
  final InspectorSelectButtonBuilder? selectButtonBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return WidgetInspector(
      key: modifierKey,
      selectButtonBuilder: selectButtonBuilder,
      child: child!,
    );
  }
}
