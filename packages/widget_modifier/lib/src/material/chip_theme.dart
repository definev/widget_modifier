import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a chip theme to descendant [RawChip]-based widgets, like [Chip],
/// [InputChip], [ChoiceChip], [FilterChip], and [ActionChip].
///
/// A chip theme describes the color, shape and text styles for the chips it is
/// applied to.
///
/// Descendant widgets obtain the current theme's [ChipThemeData] object using
/// [ChipTheme.of]. When a widget uses [ChipTheme.of], it is automatically
/// rebuilt if the theme later changes.
///
/// The [ThemeData] object given by the [Theme.of] call also contains a default
/// [ThemeData.chipTheme] that can be customized by copying it (using
/// [ChipThemeData.copyWith]).
///
/// See also:
///
///  * [Chip], a chip that displays information and can be deleted.
///  * [InputChip], a chip that represents a complex piece of information, such
///    as an entity (person, place, or thing) or conversational text, in a
///    compact form.
///  * [ChoiceChip], allows a single selection from a set of options. Choice
///    chips contain related descriptive text or categories.
///  * [FilterChip], uses tags or descriptive words as a way to filter content.
///  * [ActionChip], represents an action related to primary content.
///  * [ChipThemeData], which describes the actual configuration of a chip
///    theme.
///  * [ThemeData], which describes the overall theme information for the
///    application.
class ChipThemeModifier extends SingleChildStatelessModifier {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const ChipThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the color, shape, and text style values for descendant chip
  /// widgets.
  final ChipThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ChipTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
