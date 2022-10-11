import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A transition builder that animates its [child] based on the
/// [AnimationStatus] of the provided [animation].
///
/// This widget can be used to specify different enter and exit transitions for
/// a [child].
///
/// While the [animation] runs forward, the [child] is animated according to
/// [forwardBuilder] and while the [animation] is running in reverse, it is
/// animated according to [reverseBuilder].
///
/// Using this builder allows the widget tree to maintain its shape by nesting
/// the enter and exit transitions. This ensures that no state information of
/// any descendant widget is lost when the transition starts or completes.
class DualTransitionBuilderModifier extends SingleChildStatelessModifier {
  /// Creates a [DualTransitionBuilder].
  ///
  /// The [animation], [forwardBuilder], and [reverseBuilder] arguments are
  /// required and must not be null.
  const DualTransitionBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.animation,
    required this.forwardBuilder,
    required this.reverseBuilder,
  });

  /// The animation that drives the [child]'s transition.
  ///
  /// When this animation runs forward, the [child] transitions as specified by
  /// [forwardBuilder]. When it runs in reverse, the child transitions according
  /// to [reverseBuilder].
  final Animation<double> animation;

  /// A builder for the transition that makes [child] appear on screen.
  ///
  /// The [child] should be fully visible when the provided `animation` reaches
  /// 1.0.
  ///
  /// The `animation` provided to this builder is running forward from 0.0 to
  /// 1.0 when [animation] runs _forward_. When [animation] runs in reverse,
  /// the given `animation` is set to [kAlwaysCompleteAnimation].
  ///
  /// See also:
  ///
  ///  * [reverseBuilder], which builds the transition for making the [child]
  ///   disappear from the screen.
  final AnimatedTransitionBuilder forwardBuilder;

  /// A builder for a transition that makes [child] disappear from the screen.
  ///
  /// The [child] should be fully invisible when the provided `animation`
  /// reaches 1.0.
  ///
  /// The `animation` provided to this builder is running forward from 0.0 to
  /// 1.0 when [animation] runs in _reverse_. When [animation] runs forward,
  /// the given `animation` is set to [kAlwaysDismissedAnimation].
  ///
  /// See also:
  ///
  ///  * [forwardBuilder], which builds the transition for making the [child]
  ///    appear on screen.
  final AnimatedTransitionBuilder reverseBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DualTransitionBuilder(
      animation: animation,
      forwardBuilder: forwardBuilder,
      reverseBuilder: reverseBuilder,
    );
  }
}
