part of '../../layrz_state.dart';

typedef StateMutationBuilder = StateMutation Function();

abstract class StateMutation<T extends LayrzStore?> {
  T? get store => LayrzState.store as T?;

  StateStatus? status;

  final List<StateMutationBuilder> _laterMutations = [];
  final bool notifyLoading;
  StateMutation({
    this.notifyLoading = false,
  }) {
    status = StateStatus.none;
    _run();
  }

  Future<void> _run() async {
    for (final i in LayrzState._interceptors) {
      if (!i.beforeMutation(this)) {
        return;
      }
    }

    try {
      dynamic result = perform();
      if (result is Future) {
        status = StateStatus.loading;
        if (notifyLoading) LayrzState.notify(this);

        result = await result;
      }

      status = StateStatus.success;
      LayrzState.notify(this);

      for (final mut in _laterMutations) {
        mut();
      }
    } catch (e, s) {
      status = StateStatus.error;

      onException(e, s);
      LayrzState.notify(this);
    }

    for (final i in LayrzState._interceptors) {
      i.afterMutation(this);
    }
  }

  void next(StateMutationBuilder mutationBuilder) {
    _laterMutations.add(mutationBuilder);
  }

  dynamic perform();

  void onException(dynamic e, StackTrace s) {
    var isAssertOn = false;
    assert(isAssertOn = true);
    if (isAssertOn) {
      debugPrint("layrz_state/mutation/onException: $e");
      debugPrint("layrz_state/mutation/onException: $s");
    }
  }
}
