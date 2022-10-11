import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Creates a new scope for restoration IDs used by descendant widgets to claim
/// [RestorationBucket]s.
///
/// {@template flutter.widgets.RestorationScope}
/// A restoration scope inserts a [RestorationBucket] into the widget tree,
/// which descendant widgets can access via [RestorationScope.of]. It is
/// uncommon for descendants to directly store data in this bucket. Instead,
/// descendant widgets should consider storing their own restoration data in a
/// child bucket claimed with [RestorationBucket.claimChild] from the bucket
/// provided by this scope.
/// {@endtemplate}
///
/// The bucket inserted into the widget tree by this scope has been claimed from
/// the surrounding [RestorationScope] using the provided [restorationId]. If
/// the [RestorationScope] is moved to a different part of the widget tree under
/// a different [RestorationScope], the bucket owned by this scope with all its
/// children and the data contained in them is moved to the new scope as well.
///
/// This widget will not make a [RestorationBucket] available to descendants if
/// [restorationId] is null or when there is no surrounding restoration scope to
/// claim a bucket from. In this case, descendant widgets invoking
/// [RestorationScope.of] will receive null as a return value indicating that no
/// bucket is available for storing restoration data. This will turn off state
/// restoration for the widget subtree.
///
/// See also:
///
///  * [RootRestorationScope], which inserts the root bucket provided by
///    the [RestorationManager] into the widget tree and makes it accessible
///    for descendants via [RestorationScope.of].
///  * [UnmanagedRestorationScope], which inserts a provided [RestorationBucket]
///    into the widget tree and makes it accessible for descendants via
///    [RestorationScope.of].
///  * [RestorationMixin], which may be used in [State] objects to manage the
///    restoration data of a [StatefulWidget] instead of manually interacting
///    with [RestorationScope]s and [RestorationBucket]s.
///  * [RestorationManager], which describes the basic concepts of state
///    restoration in Flutter.
class RestorationScopeModifier extends SingleChildStatelessModifier {
  /// Creates a [RestorationScope].
  ///
  /// Providing null as the [restorationId] turns off state restoration for
  /// the [child] and its descendants.
  ///
  /// The [child] must not be null.
  const RestorationScopeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.restorationId,
  });

  /// The restoration ID used by this widget to obtain a child bucket from the
  /// surrounding [RestorationScope].
  ///
  /// The child bucket obtained from the surrounding scope is made available to
  /// descendant widgets via [RestorationScope.of].
  ///
  /// If this is null, [RestorationScope.of] invoked by descendants will return
  /// null which effectively turns off state restoration for this subtree.
  final String? restorationId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RestorationScope(
      key: modifierKey,
      restorationId: restorationId,
      child: child!,
    );
  }
}

/// Inserts a provided [RestorationBucket] into the widget tree and makes it
/// available to descendants via [RestorationScope.of].
///
/// {@macro flutter.widgets.RestorationScope}
///
/// If [bucket] is null, no restoration bucket is made available to descendant
/// widgets ([RestorationScope.of] invoked from a descendant will return null).
/// This effectively turns off state restoration for the subtree because no
/// bucket for storing restoration data is made available.
///
/// See also:
///
///  * [RestorationScope], which inserts a bucket obtained from a surrounding
///    restoration scope into the widget tree and makes it accessible
///    for descendants via [RestorationScope.of].
///  * [RootRestorationScope], which inserts the root bucket provided by
///    the [RestorationManager] into the widget tree and makes it accessible
///    for descendants via [RestorationScope.of].
///  * [RestorationMixin], which may be used in [State] objects to manage the
///    restoration data of a [StatefulWidget] instead of manually interacting
///    with [RestorationScope]s and [RestorationBucket]s.
///  * [RestorationManager], which describes the basic concepts of state
///    restoration in Flutter.
class UnmanagedRestorationScopeModifier extends SingleChildStatelessModifier {
  /// Creates an [UnmanagedRestorationScope].
  ///
  /// When [bucket] is null state restoration is turned off for the [child] and
  /// its descendants.
  ///
  /// The [child] must not be null.
  const UnmanagedRestorationScopeModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.bucket,
  });

  /// The [RestorationBucket] that this widget will insert into the widget tree.
  ///
  /// Descendant widgets may obtain this bucket via [RestorationScope.of].
  final RestorationBucket? bucket;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return UnmanagedRestorationScope(
      key: modifierKey,
      bucket: bucket,
      child: child!,
    );
  }
}

/// Inserts a child bucket of [RestorationManager.rootBucket] into the widget
/// tree and makes it available to descendants via [RestorationScope.of].
///
/// This widget is usually used near the root of the widget tree to enable the
/// state restoration functionality for the application. For all other use
/// cases, consider using a regular [RestorationScope] instead.
///
/// The root restoration bucket can only be retrieved asynchronously from the
/// [RestorationManager]. To ensure that the provided [child] has its
/// restoration data available the first time it builds, the
/// [RootRestorationScope] will build an empty [Container] instead of the actual
/// [child] until the root bucket is available. To hide the empty container from
/// the eyes of users, the [RootRestorationScope] also delays rendering the
/// first frame while the container is shown. On platforms that show a splash
/// screen on app launch the splash screen is kept up (hiding the empty
/// container) until the bucket is available and the [child] is ready to be
/// build.
///
/// The exact behavior of this widget depends on its ancestors: When the
/// [RootRestorationScope] does not find an ancestor restoration bucket via
/// [RestorationScope.of] it will claim a child bucket from the root restoration
/// bucket ([RestorationManager.rootBucket]) using the provided [restorationId]
/// and inserts that bucket into the widget tree where descendants may access it
/// via [RestorationScope.of]. If the [RootRestorationScope] finds a non-null
/// ancestor restoration bucket via [RestorationScope.of] it will behave like a
/// regular [RestorationScope] instead: It will claim a child bucket from that
/// ancestor and insert that child into the widget tree.
///
/// Unlike the [RestorationScope] widget, the [RootRestorationScope] will
/// guarantee that descendants have a bucket available for storing restoration
/// data as long as [restorationId] is not null and [RestorationManager] is
/// able to provide a root bucket. In other words, it will force-enable
/// state restoration for the subtree if [restorationId] is not null.
///
/// If [restorationId] is null, no bucket is made available to descendants,
/// which effectively turns off state restoration for this subtree.
///
/// See also:
///
///  * [RestorationScope], which inserts a bucket obtained from a surrounding
///    restoration scope into the widget tree and makes it accessible
///    for descendants via [RestorationScope.of].
///  * [UnmanagedRestorationScope], which inserts a provided [RestorationBucket]
///    into the widget tree and makes it accessible for descendants via
///    [RestorationScope.of].
///  * [RestorationMixin], which may be used in [State] objects to manage the
///    restoration data of a [StatefulWidget] instead of manually interacting
///    with [RestorationScope]s and [RestorationBucket]s.
///  * [RestorationManager], which describes the basic concepts of state
///    restoration in Flutter.
class RootRestorationScopeModifier extends SingleChildStatelessModifier {
  /// Creates a [RootRestorationScope].
  ///
  /// Providing null as the [restorationId] turns off state restoration for
  /// the [child] and its descendants.
  ///
  /// The [child] must not be null.
  const RootRestorationScopeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.restorationId,
  });

  /// The restoration ID used to identify the child bucket that this widget
  /// will insert into the tree.
  ///
  /// If this is null, no bucket is made available to descendants and state
  /// restoration for the subtree is essentially turned off.
  final String? restorationId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RootRestorationScope(
      key: modifierKey,
      restorationId: restorationId,
      child: child!,
    );
  }
}
