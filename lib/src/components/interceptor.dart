part of '../../layrz_state.dart';

abstract class LayrzStateInterceptor<T extends LayrzStore?> {
  bool beforeMutation(StateMutation<T> mutation);
  void afterMutation(StateMutation<T> mutation);
}
