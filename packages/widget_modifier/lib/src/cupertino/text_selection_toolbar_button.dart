// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

import '../modifier.dart';

const TextStyle _kToolbarButtonFontStyle = TextStyle(
  inherit: false,
  fontSize: 14.0,
  letterSpacing: -0.15,
  fontWeight: FontWeight.w400,
);

/// A button in the style of the iOS text selection toolbar buttons.
class CupertinoTextSelectionToolbarButtonModifier extends SingleChildStatelessModifier {
  /// Create an instance of [CupertinoTextSelectionToolbarButton].
const CupertinoTextSelectionToolbarButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onPressed,
  });

  /// Create an instance of [CupertinoTextSelectionToolbarButton] whose child is
  /// a [Text] widget styled like the default iOS text selection toolbar button.
  CupertinoTextSelectionToolbarButtonModifier.text({
    super.key,
    this.onPressed,
    required String text,
  }) : super(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: _kToolbarButtonFontStyle.copyWith(
              color: onPressed != null ? CupertinoColors.white : CupertinoColors.inactiveGray,
            ),
          ),
        );

  /// {@template flutter.cupertino.CupertinoTextSelectionToolbarButton.onPressed}
  final VoidCallback? onPressed;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoTextSelectionToolbarButton(
      key: modifierKey,
      onPressed: onPressed,
      child: child!,
    );
  }
}
