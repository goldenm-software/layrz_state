part of '../../layrz_state.dart';

/// A stream builder like widget that accepts
/// mutations and rebuilds after their execution.
class StateBuilder<T> extends StatelessWidget {
  /// [builder] provides the child widget to rendered.
  final StateWidgetBuilder<T> builder;

  /// Widget will rerender every time any of [mutations] executes.
  final Set<Type> mutations;

  /// Creates widget to rerender child widgets when given
  /// [mutations] execute.
  const StateBuilder({
    super.key,
    required this.builder,
    this.mutations = const {},
  });

  @override
  Widget build(BuildContext context) {
    final stream = LayrzState.events.where((e) => mutations.contains(e.runtimeType));

    return StreamBuilder<StateMutation>(
      stream: stream,
      builder: (context, mut) {
        StateStatus status = StateStatus.none;
        if (!mut.hasData || mut.connectionState == ConnectionState.waiting) {
          status = StateStatus.none;
        } else {
          status = mut.data?.status ?? StateStatus.none;
        }

        return builder(
          context,
          LayrzState.of(context) as T,
          status,
        );
      },
    );
  }
}
