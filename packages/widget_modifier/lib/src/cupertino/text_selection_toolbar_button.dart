// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoTextSelectionToolbarButtonModifier extends SingleChildStatelessModifier {
  const CupertinoTextSelectionToolbarButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onPressed,
  });

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
