import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a data table theme to descendant [DataTable] widgets.
///
/// Descendant widgets obtain the current theme's [DataTableTheme] object using
/// [DataTableTheme.of]. When a widget uses [DataTableTheme.of], it is
/// automatically rebuilt if the theme later changes.
///
/// A data table theme can be specified as part of the overall Material
/// theme using [ThemeData.dataTableTheme].
///
/// See also:
///
///  * [DataTableThemeData], which describes the actual configuration
///    of a data table theme.
class DataTableThemeModifier extends SingleChildStatelessModifier {
  /// Constructs a data table theme that configures all descendant
  /// [DataTable] widgets.
  ///
  /// The [data] must not be null.
  const DataTableThemeModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.data,
  });

  /// The properties used for all descendant [DataTable] widgets.
  final DataTableThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DataTableTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
