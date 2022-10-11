import 'package:flutter/widgets.dart';

import '../modifier.dart';

const double _kHeight = 12.0; // height of banner

const Color _kColor = Color(0xA0B71C1C);
const TextStyle _kTextStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: _kHeight * 0.85,
  fontWeight: FontWeight.w900,
  height: 1.0,
);


/// Displays a diagonal message above the corner of another widget.
///
/// Useful for showing the execution mode of an app (e.g., that asserts are
/// enabled.)
///
/// See also:
///
///  * [CheckedModeBanner], which the [WidgetsApp] widget includes by default in
///    debug mode, to show a banner that says "DEBUG".
class BannerModifier extends SingleChildStatelessModifier {
  /// Creates a banner.
  ///
  /// The [message] and [location] arguments must not be null.
  const BannerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.message,
    this.textDirection,
    required this.location,
    this.layoutDirection,
    this.color = _kColor,
    this.textStyle = _kTextStyle,
  });

  /// The message to show in the banner.
  final String message;

  /// The directionality of the text.
  ///
  /// This is used to disambiguate how to render bidirectional text. For
  /// example, if the message is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  ///
  /// See also:
  ///
  ///  * [layoutDirection], which controls the interpretation of the [location].
  final TextDirection? textDirection;

  /// Where to show the banner (e.g., the upper right corner).
  final BannerLocation location;

  /// The directionality of the layout.
  ///
  /// This is used to resolve the [location] values.
  ///
  /// Defaults to the ambient [Directionality], if any.
  ///
  /// See also:
  ///
  ///  * [textDirection], which controls the reading direction of the [message].
  final TextDirection? layoutDirection;

  /// The color of the banner.
  final Color color;

  /// The style of the text shown on the banner.
  final TextStyle textStyle;


  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Banner(
      key: modifierKey,
      color: color,
      layoutDirection: layoutDirection,
      textDirection: textDirection,
      textStyle: textStyle,
      message: message,
      location: location,
      child: child,
    );
  }
}



/// Displays a [Banner] saying "DEBUG" when running in debug mode.
/// [MaterialApp] builds one of these by default.
///
/// Does nothing in release mode.
class CheckedModeBannerModifier extends SingleChildStatelessModifier {
  /// Creates a const debug mode banner.
  const CheckedModeBannerModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckedModeBanner(
      key: modifierKey,
      child: child!,
    );
  }
}
