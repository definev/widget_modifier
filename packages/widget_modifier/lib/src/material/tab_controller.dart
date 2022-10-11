import 'package:flutter/material.dart';

import '../modifier.dart';

/// The [TabController] for descendant widgets that don't specify one
/// explicitly.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=POtoEH-5l40}
///
/// [DefaultTabController] is an inherited widget that is used to share a
/// [TabController] with a [TabBar] or a [TabBarView]. It's used when sharing an
/// explicitly created [TabController] isn't convenient because the tab bar
/// widgets are created by a stateless parent widget or by different parent
/// widgets.
///
/// {@animation 700 540 https://flutter.github.io/assets-for-api-docs/assets/material/tabs.mp4}
///
/// ```dart
/// class MyDemo extends StatelessWidget {
///   final List<Tab> myTabs = <Tab>[
///     Tab(text: 'LEFT'),
///     Tab(text: 'RIGHT'),
///   ];
///
///   @override
///   Widget build(BuildContext context) {
///     return DefaultTabController(
///       length: myTabs.length,
///       child: Scaffold(
///         appBar: AppBar(
///           bottom: TabBar(
///             tabs: myTabs,
///           ),
///         ),
///         body: TabBarView(
///           children: myTabs.map((Tab tab) {
///             final String label = tab.text.toLowerCase();
///             return Center(
///               child: Text(
///                 'This is the $label tab',
///                 style: const TextStyle(fontSize: 36),
///               ),
///             );
///           }).toList(),
///         ),
///       ),
///     );
///   }
/// }
/// ```
class DefaultTabControllerModifier extends SingleChildStatelessModifier {
  /// Creates a default tab controller for the given [child] widget.
  ///
  /// The [length] argument is typically greater than one. The [length] must
  /// match [TabBar.tabs]'s and [TabBarView.children]'s length.
  ///
  /// The [initialIndex] argument must not be null.
  const DefaultTabControllerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.length,
    this.initialIndex = 0,
    this.animationDuration,
  });

  /// The total number of tabs.
  ///
  /// Typically greater than one. Must match [TabBar.tabs]'s and
  /// [TabBarView.children]'s length.
  final int length;

  /// The initial index of the selected tab.
  ///
  /// Defaults to zero.
  final int initialIndex;

  /// Controls the duration of DefaultTabController and TabBarView animations.
  ///
  /// Defaults to kTabScrollDuration.
  final Duration? animationDuration;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTabController(
      key: modifierKey,
      length: length,
      animationDuration: animationDuration,
      initialIndex: initialIndex,
      child: child!,
    );
  }
}
