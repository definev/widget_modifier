import 'package:flutter/cupertino.dart';

import '../modifier.dart';


/// Establishes a subtree in which [CupertinoUserInterfaceLevel.of] resolves to
/// the given data.
///
/// Querying the current elevation status using [CupertinoUserInterfaceLevel.of]
/// will cause your widget to rebuild automatically whenever the
/// [CupertinoUserInterfaceLevelData] changes.
///
/// If no [CupertinoUserInterfaceLevel] is in scope then the
/// [CupertinoUserInterfaceLevel.of] method will throw an exception.
/// Alternatively, [CupertinoUserInterfaceLevel.maybeOf] can be used, which
/// returns null instead of throwing if no [CupertinoUserInterfaceLevel] is in
/// scope.
///
/// See also:
///
///  * [CupertinoUserInterfaceLevelData], specifies the visual level for the content
///    in the subtree [CupertinoUserInterfaceLevel] established.
class CupertinoUserInterfaceLevelModifier extends SingleChildStatelessModifier {
  /// Creates a [CupertinoUserInterfaceLevel] to change descendant Cupertino widget's
  /// visual level.
  const CupertinoUserInterfaceLevelModifier({
    super.key,
    super.child,
    super.modifierKey,
    required CupertinoUserInterfaceLevelData data,
  }) : _data = data;

  final CupertinoUserInterfaceLevelData _data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoUserInterfaceLevel(
      key: modifierKey,
      data: _data,
      child: child!,
    );
  }
}
