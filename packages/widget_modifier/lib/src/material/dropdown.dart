import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that causes any descendant [DropdownButton]
/// widgets to not include their regular underline.
///
/// This is used by [DataTable] to remove the underline from any
/// [DropdownButton] widgets placed within material data tables, as
/// required by the Material Design specification.
class DropdownButtonHideUnderlineModifier extends SingleChildStatelessModifier {
  /// Creates a [DropdownButtonHideUnderline]. A non-null [child] must
  /// be given.
  const DropdownButtonHideUnderlineModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DropdownButtonHideUnderline(
      key: modifierKey,
      child: child!,
    );
  }
}
