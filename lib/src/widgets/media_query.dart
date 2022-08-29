import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class MediaQueryModifier extends SingleChildStatelessWidget {
  const MediaQueryModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  factory MediaQueryModifier.removePadding({
    Key? key,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
    Widget? child,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removePadding(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  factory MediaQueryModifier.removeViewInsets({
    Key? key,
    Widget? child,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removeViewInsets(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  factory MediaQueryModifier.removeViewPadding({
    Key? key,
    Widget? child,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
  }) {
    return MediaQueryModifier(
      key: key,
      data: MediaQuery.of(context).removeViewPadding(
        removeLeft: removeLeft,
        removeTop: removeTop,
        removeRight: removeRight,
        removeBottom: removeBottom,
      ),
      child: child,
    );
  }

  final Key? modifierKey;
  final MediaQueryData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MediaQuery(key: modifierKey, data: data, child: child!);
  }
}
