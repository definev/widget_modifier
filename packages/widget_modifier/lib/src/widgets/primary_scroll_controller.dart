import 'package:flutter/widgets.dart';

import '../modifier.dart';

const Set<TargetPlatform> _kMobilePlatforms = <TargetPlatform>{
  TargetPlatform.android,
  TargetPlatform.iOS,
  TargetPlatform.fuchsia,
};

/// Associates a [ScrollController] with a subtree.
///
/// When a [ScrollView] has [ScrollView.primary] set to true, the [ScrollView]
/// uses [of] to inherit the [PrimaryScrollController] associated with its
/// subtree.
///
/// A ScrollView that doesn't have a controller or the primary flag set will
/// inherit the PrimarySCrollController, if [shouldInherit] allows it. By
/// default [shouldInherit] is true for mobile platforms when the ScrollView has
/// a scroll direction of [Axis.vertical]. This automatic inheritance can be
/// configured with [automaticallyInheritForPlatforms] and [scrollDirection].
///
/// Inheriting this ScrollController can provide default behavior for scroll
/// views in a subtree. For example, the [Scaffold] uses this mechanism to
/// implement the scroll-to-top gesture on iOS.
///
/// Another default behavior handled by the PrimaryScrollController is default
/// [ScrollAction]s. If a ScrollAction is not handled by an otherwise focused
/// part of the application, the ScrollAction will be evaluated using the scroll
/// view associated with a PrimaryScrollController, for example, when executing
/// [Shortcuts] key events like page up and down.
///
/// See also:
///   * [ScrollAction], an [Action] that scrolls the [Scrollable] that encloses
///     the current [primaryFocus] or is attached to the PrimaryScrollController.
///   * [Shortcuts], a widget that establishes a [ShortcutManager] to be used
///     by its descendants when invoking an [Action] via a keyboard key
///     combination that maps to an [Intent].
class PrimaryScrollControllerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that associates a [ScrollController] with a subtree.
  const PrimaryScrollControllerModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.controller,
    this.automaticallyInheritForPlatforms = _kMobilePlatforms,
    this.scrollDirection = Axis.vertical,
  });

  /// Creates a subtree without an associated [ScrollController].
  const PrimaryScrollControllerModifier.none({
    super.key,
    super.child,
    super.modifierKey,
  })  : automaticallyInheritForPlatforms = const <TargetPlatform>{},
        scrollDirection = null,
        controller = null;

  /// The [ScrollController] associated with the subtree.
  ///
  /// See also:
  ///
  ///  * [ScrollView.controller], which discusses the purpose of specifying a
  ///    scroll controller.
  final ScrollController? controller;

  /// The [Axis] this controller is configured for [ScrollView]s to
  /// automatically inherit.
  ///
  /// Used in conjunction with [automaticallyInheritForPlatforms]. If the
  /// current [TargetPlatform] is not included in
  /// [automaticallyInheritForPlatforms], this is ignored.
  ///
  /// When null, no [ScrollView] in any Axis will automatically inherit this
  /// controller. This is dissimilar to [PrimaryScrollController.none]. When a
  /// PrimaryScrollController is inherited, ScrollView will insert
  /// PrimaryScrollController.none into the tree to prevent further descendant
  /// ScrollViews from inheriting the current PrimaryScrollController.
  ///
  /// Defaults to [Axis.vertical].
  final Axis? scrollDirection;

  /// The [TargetPlatform]s this controller is configured for [ScrollView]s to
  /// automatically inherit.
  ///
  /// Used in conjunction with [scrollDirection]. If the [Axis] provided to
  /// [shouldInherit] is not [scrollDirection], this is ignored.
  ///
  /// When empty, no ScrollView in any Axis will automatically inherit this
  /// controller. Defaults to [TargetPlatformVariant.mobile].
  final Set<TargetPlatform> automaticallyInheritForPlatforms;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (controller == null) {
      return PrimaryScrollController.none(child: child!);
    }
    return PrimaryScrollController(
      controller: controller!,
      child: child!,
    );
  }
}
