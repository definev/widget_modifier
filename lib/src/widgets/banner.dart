import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

const double _kHeight = 12.0; // height of banner

const Color _kColor = Color(0xA0B71C1C);
const TextStyle _kTextStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: _kHeight * 0.85,
  fontWeight: FontWeight.w900,
  height: 1.0,
);

class BannerModifier extends SingleChildStatelessWidget {
  const BannerModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.message,
    this.textDirection,
    required this.location,
    this.layoutDirection,
    this.color = _kColor,
    this.textStyle = _kTextStyle,
  });

  final Key? modifierKey;
  final String message;
  final TextDirection? textDirection;
  final BannerLocation location;
  final TextDirection? layoutDirection;
  final Color color;
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

class CheckedModeBannerModifier extends SingleChildStatelessWidget {
  const CheckedModeBannerModifier({
    super.key,
    super.child,
    this.modifierKey,
  });

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckedModeBanner(
      key: modifierKey,
      child: child!,
    );
  }
}
