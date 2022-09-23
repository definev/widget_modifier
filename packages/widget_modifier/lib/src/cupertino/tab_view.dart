import 'package:widget_modifier/src/modifier.dart';
import 'package:widget_modifier/src/widgets/basic.dart';
import 'package:flutter/cupertino.dart';

class CupertinoTabViewModifier extends SingleChildStatelessModifier {
  const CupertinoTabViewModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.builder,
    this.navigatorKey,
    this.defaultTitle,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.restorationScopeId,
  });

  final SingleChildWidgetBuilder? builder;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? defaultTitle;
  final Map<String, WidgetBuilder>? routes;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final String? restorationScopeId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoTabView(
      key: modifierKey,
      builder: builder != null ? (context) => builder!.call(context, child) : null,
      defaultTitle: defaultTitle,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      restorationScopeId: restorationScopeId,
      routes: routes,
    );
  }
}
