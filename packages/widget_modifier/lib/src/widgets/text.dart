import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../modifier.dart';
import 'basic.dart';

/// The text style to apply to descendant [Text] widgets which don't have an
/// explicit style.
///
/// See also:
///
///  * [AnimatedDefaultTextStyle], which animates changes in the text style
///    smoothly over a given duration.
///  * [DefaultTextStyleTransition], which takes a provided [Animation] to
///    animate changes in text style smoothly over time.
class DefaultTextStyleModifier extends SingleChildStatelessModifier {
  /// Creates a default text style for the given subtree.
  ///
  /// Consider using [DefaultTextStyle.merge] to inherit styling information
  /// from the current default text style for a given [BuildContext].
  ///
  /// The [style] and [child] arguments are required and must not be null.
  ///
  /// The [softWrap] and [overflow] arguments must not be null (though they do
  /// have default values).
  ///
  /// The [maxLines] property may be null (and indeed defaults to null), but if
  /// it is not null, it must be greater than zero.
  const DefaultTextStyleModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  });

  /// Creates a default text style that overrides the text styles in scope at
  /// this point in the widget tree.
  ///
  /// The given [style] is merged with the [style] from the default text style
  /// for the [BuildContext] where the widget is inserted, and any of the other
  /// arguments that are not null replace the corresponding properties on that
  /// same default text style.
  ///
  /// This constructor cannot be used to override the [maxLines] property of the
  /// ancestor with the value null, since null here is used to mean "defer to
  /// ancestor". To replace a non-null [maxLines] from an ancestor with the null
  /// value (to remove the restriction on number of lines), manually obtain the
  /// ambient [DefaultTextStyle] using [DefaultTextStyle.of], then create a new
  /// [DefaultTextStyle] using the [DefaultTextStyle.new] constructor directly.
  /// See the source below for an example of how to do this (since that's
  /// essentially what this constructor does).
  static SingleChildModifier merge({
    Key? key,
    Widget? child,
    Key? modifierKey,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
  }) {
    return BuilderModifier(
      builder: (BuildContext context, Widget? child) {
        final DefaultTextStyle parent = DefaultTextStyle.of(context);
        return DefaultTextStyleModifier(
          key: key,
          modifierKey: modifierKey,
          style: parent.style.merge(style),
          textAlign: textAlign ?? parent.textAlign,
          softWrap: softWrap ?? parent.softWrap,
          overflow: overflow ?? parent.overflow,
          maxLines: maxLines ?? parent.maxLines,
          textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
          child: child,
        );
      },
    );
  }

  /// The text style to apply.
  final TextStyle style;

  /// How each line of text in the Text widget should be aligned horizontally.
  final TextAlign? textAlign;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  ///
  /// This also decides the [overflow] property's behavior. If this is true or null,
  /// the glyph causing overflow, and those that follow, will not be rendered.
  final bool softWrap;

  /// How visual overflow should be handled.
  ///
  /// If [softWrap] is true or null, the glyph causing overflow, and those that follow,
  /// will not be rendered. Otherwise, it will be shown with the given overflow option.
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is non-null, it will override even explicit null values of
  /// [Text.maxLines].
  final int? maxLines;

  /// The strategy to use when calculating the width of the Text.
  ///
  /// See [TextWidthBasis] for possible values and their implications.
  final TextWidthBasis textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextStyle(
      key: modifierKey,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      child: child!,
    );
  }
}

/// The [TextHeightBehavior] that will apply to descendant [Text] and [EditableText]
/// widgets which have not explicitly set [Text.textHeightBehavior].
///
/// If there is a [DefaultTextStyle] with a non-null [DefaultTextStyle.textHeightBehavior]
/// below this widget, the [DefaultTextStyle.textHeightBehavior] will be used
/// over this widget's [TextHeightBehavior].
///
/// See also:
///
///  * [DefaultTextStyle], which defines a [TextStyle] to apply to descendant
///    [Text] widgets.
class DefaultTextHeightBehaviorModifier extends SingleChildStatelessModifier {
  /// Creates a default text height behavior for the given subtree.
  ///
  /// The [textHeightBehavior] and [child] arguments are required and must not be null.
  const DefaultTextHeightBehaviorModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.textHeightBehavior,
  });

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior textHeightBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextHeightBehavior(
      key: modifierKey,
      textHeightBehavior: textHeightBehavior,
      child: child!,
    );
  }
}
