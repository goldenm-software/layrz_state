part of '../../layrz_state.dart';

/// A stream builder like widget that accepts
/// mutations and rebuilds after their execution.
class StateConsumer<T> extends StatefulWidget {
  /// [builder] provides the child widget to rendered.
  final StateWidgetBuilder<T> builder;

  /// Widget will rerender every time any of [mutations] executes.
  final Set<Type> mutations;

  /// Map of mutations and their corresponding callback
  final Map<Type, ContextCallback> notifications;

  /// Creates widget to rerender child widgets when given
  /// [mutations] execute.
  const StateConsumer({
    super.key,
    required this.builder,
    this.mutations = const {},
    this.notifications = const {},
  });

  @override
  State<StateConsumer> createState() => StateConsumerState<T>();
}

class StateConsumerState<T> extends State<StateConsumer<T>> {
  StreamSubscription? eventSub;

  @override
  void initState() {
    super.initState();
    final notifications = widget.notifications.keys.toSet();
    final stream = LayrzState.events.where((e) => notifications.contains(e.runtimeType));
    eventSub = stream.listen((e) {
      // ignore: use_build_context_synchronously
      widget.notifications[e.runtimeType]?.call(context, e, status: e.status);
    });
  }

  @override
  void dispose() {
    eventSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stream = LayrzState.events.where((e) => widget.mutations.contains(e.runtimeType));
    return StreamBuilder<StateMutation>(
      stream: stream,
      builder: (context, mut) {
        StateStatus? status;
        if (!mut.hasData || mut.connectionState == ConnectionState.waiting) {
          status = StateStatus.none;
        } else {
          status = mut.data?.status;
        }
        final T store = LayrzState.store as T;
        return widget.builder(context, store, status);
      },
    );
  }
}
