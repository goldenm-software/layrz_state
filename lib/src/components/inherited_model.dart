part of '../../layrz_state.dart';

class _StateModel extends InheritedModel {
  final Set<Type>? recent;

  const _StateModel({
    required super.child,
    this.recent,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => oldWidget.hashCode != recent.hashCode;

  @override
  bool updateShouldNotifyDependent(covariant InheritedModel oldWidget, Set dependencies) {
    return dependencies.intersection(recent!).isNotEmpty;
  }
}
