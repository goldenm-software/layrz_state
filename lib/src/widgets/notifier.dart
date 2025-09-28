part of '../../layrz_state.dart';

/// Function signature for the callback with context.
typedef ContextCallback = void Function(BuildContext context, StateMutation mutation, {StateStatus? status});

/// Helper widget that executes the provided callbacks with context
/// on execution of the mutations. Useful to show SnackBar or navigate
/// to a different route after a mutation.
class StateNotifier<T> extends StatefulWidget {
  /// Optional child widget
  final Widget? child;

  /// Map of mutations and their corresponding callback
  final Map<Type, ContextCallback> mutations;

  /// [StateNotifier] make callbacks for given mutations
  const StateNotifier({
    super.key,
    this.child,
    this.mutations = const {},
  });

  @override
  State<StateNotifier> createState() => StateNotifierState<T>();
}

class StateNotifierState<T> extends State<StateNotifier> {
  StreamSubscription? eventSub;

  @override
  void initState() {
    super.initState();
    final mutations = widget.mutations.keys.toSet();
    final stream = LayrzState.events.where((e) => mutations.contains(e.runtimeType));
    eventSub = stream.listen((e) {
      // ignore: use_build_context_synchronously
      widget.mutations[e.runtimeType]?.call(context, e, status: e.status);
    });
  }

  @override
  void dispose() {
    eventSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // allow null child
    return widget.child ?? const SizedBox();
  }
}
