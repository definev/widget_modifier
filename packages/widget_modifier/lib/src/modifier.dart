// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Original idea and source code by @remi_rousselet
///
/// A widget that simplify the writing of deeply Modifier widget trees.
///
/// It relies on the new kind of widget [SingleChildModifier], which has two
/// concrete implementations:
/// - [SingleChildStatelessModifier]
/// - [SingleChildStatefulModifier]
///
/// They are both respectively a [SingleChildModifier] variant of [StatelessWidget]
/// and [StatefulWidget].
///
/// The difference between a widget and its single-child variant is that they have
/// a custom `build` method that takes an extra parameter.
///
/// As such, a `StatelessWidget` would be:
///
/// ```dart
/// class MyWidget extends StatelessWidget {
///   MyWidget({Key key, this.child}): super(key: key);
///
///   final Widget child;
///
///   @override
///   Widget build(BuildContext context) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// Whereas a [SingleChildStatelessModifier] would be:
///
/// ```dart
/// class MyWidget extends SingleChildStatelessWidget {
///   MyWidget({Key key, Widget child}): super(key: key, child: child);
///
///   @override
///   Widget buildWithChild(BuildContext context, Widget child) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// This allows our new `MyWidget` to be used both with:
///
/// ```dart
/// MyWidget(
///   child: AnotherWidget(),
/// )
/// ```
///
/// and to be placed inside `children` of [Modifier] like so:
///
/// ```dart
/// Modifier(
///   modifiers: [
///     MyWidget(),
///     ...
///   ],
///   child: AnotherWidget(),
/// )
/// ```
class Modifier extends StatelessWidget with ModifierManager implements SingleChildModifier {
  /// Allows configuring key, children and child
  Modifier({
    super.key,
    required List<SingleChildModifier> modifiers,
    Widget? child,
  })  : _modifiers = modifiers,
        _child = child;

  final List<SingleChildModifier> _modifiers;
  final Widget? _child;

  @override
  Modifier wrapWith(SingleChildModifier modifier) {
    _modifiers.insert(0, modifier);
    return this;
  }

  @override
  Modifier wrapWithAll(List<SingleChildModifier> modifiers) {
    _modifiers.insertAll(0, modifiers);
    return this;
  }

  @override
  Widget build(BuildContext context) {
    throw StateError('implemented internally');
  }

  /// Create modifier stateless element
  @override
  _ModifierElement createElement() => _ModifierElement(this);
}

class _ModifierElement extends StatelessElement with _SingleChildWidgetElementMixin {
  _ModifierElement(Modifier super.widget);

  @override
  Modifier get widget => super.widget as Modifier;

  final Set<_ModifierHookElement> nodes = <_ModifierHookElement>{};

  @override
  Widget build() {
    _ModifierHook? modifierHook;
    Widget? nextNode = _parent?.injectedChild ?? widget._child;

    for (final SingleChildModifier child in widget._modifiers.reversed) {
      nextNode = modifierHook = _ModifierHook(
        owner: this,
        wrappedModifier: child,
        injectedModifier: nextNode,
      );
    }

    if (modifierHook != null) {
      // We manually update _ModifierHookElement instead of letter widgets do their thing
      // because an item N may be constant but N+1 not. So, if we used widgets
      // then N+1 wouldn't rebuild because N didn't change
      for (final _ModifierHookElement node in nodes) {
        node
          ..wrappedChild = modifierHook!.wrappedModifier
          ..injectedChild = modifierHook.injectedModifier;

        final Widget? next = modifierHook.injectedModifier;
        if (next is _ModifierHook) {
          modifierHook = next;
        } else {
          break;
        }
      }
    }

    return nextNode!;
  }
}

class _ModifierHook extends StatelessWidget {
  _ModifierHook({
    this.injectedModifier,
    required this.wrappedModifier,
    required this.owner,
  });

  final SingleChildModifier wrappedModifier;
  final Widget? injectedModifier;
  final _ModifierElement owner;

  @override
  _ModifierHookElement createElement() => _ModifierHookElement(this);

  @override
  Widget build(BuildContext context) => throw StateError('handled internally');
}

class _ModifierHookElement extends StatelessElement {
  _ModifierHookElement(_ModifierHook super.widget);

  @override
  _ModifierHook get widget => super.widget as _ModifierHook;

  Widget? _injectedModifier;
  Widget? get injectedChild => _injectedModifier;
  set injectedChild(Widget? value) {
    final Widget? previous = _injectedModifier;
    if (value is _ModifierHook &&
        previous is _ModifierHook &&
        Widget.canUpdate(value.wrappedModifier, previous.wrappedModifier)) {
      // no need to rebuild the wrapped widget just for a _ModifierHook.
      // The widget doesn't matter here, only its Element.
      return;
    }
    if (previous != value) {
      _injectedModifier = value;
      visitChildren((Element e) => e.markNeedsBuild());
    }
  }

  SingleChildModifier? _wrappedModifier;
  SingleChildModifier? get wrappedChild => _wrappedModifier;
  set wrappedChild(SingleChildModifier? value) {
    if (_wrappedModifier != value) {
      _wrappedModifier = value;
      markNeedsBuild();
    }
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    widget.owner.nodes.add(this);
    _wrappedModifier = widget.wrappedModifier;
    _injectedModifier = widget.injectedModifier;
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    widget.owner.nodes.remove(this);
    super.unmount();
  }

  @override
  Widget build() {
    return wrappedChild!;
  }
}

/// A [Widget] that takes a single descendant.
///
/// As opposed to [ProxyWidget], it may have a "build" method.
///
/// See also:
/// - [SingleChildStatelessModifier]
/// - [SingleChildStatefulModifier]
// ignore: avoid_implementing_value_types
abstract class SingleChildModifier implements Widget {
  @override
  _SingleChildWidgetElementMixin createElement();
}

mixin _SingleChildWidgetElementMixin on Element {
  _ModifierHookElement? _parent;

  @override
  void mount(Element? parent, dynamic newSlot) {
    if (parent is _ModifierHookElement?) {
      _parent = parent;
    }
    super.mount(parent, newSlot);
  }

  @override
  void activate() {
    super.activate();
    visitAncestorElements((Element parent) {
      if (parent is _ModifierHookElement) {
        _parent = parent;
      }
      return false;
    });
  }
}

/// A [StatelessWidget] that implements [SingleChildModifier] and is therefore
/// compatible with [Modifier].
///
/// Its [build] method must **not** be overriden. Instead use [buildWithChild].
abstract class SingleChildStatelessModifier extends StatelessWidget implements SingleChildModifier {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatelessModifier({
    super.key,
    Widget? child,
    this.modifierKey,
  }) : _child = child;

  /// {@template widget_modifier.modifierKey}
  /// The actual key of the widget, which [Modifier] wrapped
  ///
  /// Because flutter [key] property is the default for the widget so don't miss-used
  /// - [key] which is modifier key
  /// - [modifierKey] which is the key of widget in [buildWithChild]
  /// {@endtemplate}
  final Key? modifierKey;
  final Widget? _child;

  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessModifier].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget? child);

  @override
  Widget build(BuildContext context) => buildWithChild(context, _child);

  /// Create a SingleChildStatelessElement
  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }
}

/// An [Element] that uses a [SingleChildStatelessModifier] as its configuration.
class SingleChildStatelessElement extends StatelessElement with _SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatelessElement(SingleChildStatelessModifier super.widget);

  @override
  Widget build() {
    if (_parent != null) {
      return widget.buildWithChild(this, _parent!.injectedChild);
    }
    return super.build();
  }

  @override
  SingleChildStatelessModifier get widget => super.widget as SingleChildStatelessModifier;
}

/// A [StatefulWidget] that is compatible with [Modifier].
abstract class SingleChildStatefulModifier extends StatefulWidget implements SingleChildModifier {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatefulModifier({super.key, Widget? child, this.modifierKey}) : _child = child;

  /// {@macro widget_modifier.modifierKey}
  final Key? modifierKey;
  final Widget? _child;

  /// Create element SingleChildStatefulElement
  @override
  SingleChildStatefulElement createElement() {
    return SingleChildStatefulElement(this);
  }
}

/// A [State] for [SingleChildStatefulModifier].
///
/// Do not override [build] and instead override [buildWithChild].
abstract class SingleChildState<T extends SingleChildStatefulModifier> extends State<T> {
  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessModifier].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget? child);

  @override
  Widget build(BuildContext context) => buildWithChild(context, widget._child);
}

/// An [Element] that uses a [SingleChildStatefulModifier] as its configuration.
class SingleChildStatefulElement extends StatefulElement with _SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatefulElement(SingleChildStatefulModifier super.widget);

  @override
  SingleChildStatefulModifier get widget => super.widget as SingleChildStatefulModifier;

  @override
  SingleChildState<SingleChildStatefulModifier> get state =>
      super.state as SingleChildState<SingleChildStatefulModifier>;

  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent!.injectedChild);
    }
    return super.build();
  }
}

/// Mix [StatelessWidget] with [SingleChildStatelessModifier]
mixin SingleChildStatelessWidgetMixin implements StatelessWidget, SingleChildStatelessModifier {
  /// The child widget which [Modifier] give to [SingleChildModifier]
  Widget? get child;

  @override
  Widget? get _child => child;

  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return buildWithChild(context, child);
  }
}

/// Mix [StatefulWidget] with [SingleChildStatelessModifier]
mixin SingleChildStatefulWidgetMixin on StatefulWidget implements SingleChildModifier {
  /// The child widget which [Modifier] give to [SingleChildModifier]
  Widget? get child;

  /// Create a custom element
  @override
  _SingleChildStatefulMixinElement createElement() => _SingleChildStatefulMixinElement(this);
}

/// This enable [State] class can use with [Modifier]
///
/// Remember override [buildWithChild] not default [build] function
mixin SingleChildStateMixin<T extends StatefulWidget> on State<T> {
  /// Create widget with [child] is given by [Modifier]
  Widget buildWithChild(BuildContext context, Widget child);

  @override
  Widget build(BuildContext context) {
    return buildWithChild(
      context,
      (widget as SingleChildStatefulWidgetMixin).child!,
    );
  }
}

class _SingleChildStatefulMixinElement extends StatefulElement with _SingleChildWidgetElementMixin {
  _SingleChildStatefulMixinElement(SingleChildStatefulWidgetMixin super.widget);

  @override
  SingleChildStatefulWidgetMixin get widget => super.widget as SingleChildStatefulWidgetMixin;

  @override
  SingleChildStateMixin<StatefulWidget> get state => super.state as SingleChildStateMixin<StatefulWidget>;

  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent!.injectedChild!);
    }
    return super.build();
  }
}

///
mixin SingleChildInheritedElementMixin on InheritedElement, _SingleChildWidgetElementMixin {
  @override
  Widget build() {
    if (_parent != null) {
      return _parent!.injectedChild!;
    }
    return super.build();
  }
}

/// Transform normal widget to [Modifier]
extension ModifierTransformer on Widget {
  /// Transform normal widget to [Modifier]
  // ignore: prefer_const_literals_to_create_immutables
  Modifier modified() => Modifier(modifiers: <SingleChildModifier>[], child: this);
}

/// Mixin help control [SingleChildModifier] list
mixin ModifierManager {
  /// Wrap current [child] widget with a [SingleChildModifier]
  Modifier wrapWith(SingleChildModifier modifier) {
    throw UnimplementedError('Missing implement');
  }

  /// Wrap current [child] widget with a [SingleChildModifier]s list
  Modifier wrapWithAll(List<SingleChildModifier> modifiers) {
    throw UnimplementedError('Missing implement');
  }
}
