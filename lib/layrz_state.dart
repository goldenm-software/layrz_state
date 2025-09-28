library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'src/state.dart';
part 'src/components/mutation.dart';
part 'src/components/interceptor.dart';
part 'src/components/inherited_model.dart';

part 'src/widgets/builder.dart';
part 'src/widgets/consumer.dart';
part 'src/widgets/notifier.dart';

// Backwards compatibility
@Deprecated('Use LayrzStateWidgetBuilder instead')
typedef VxStateWidgetBuilder<T> = StateWidgetBuilder<T>;

@Deprecated('Use StateStatus instead')
typedef VxStatus = StateStatus;

@Deprecated('Use LayrzStore instead')
typedef VxStore = LayrzStore;

@Deprecated('Use LayrzState instead')
typedef VxState = LayrzState;

@Deprecated('Use StateMutation instead')
typedef VxMutationBuilder = StateMutationBuilder;

@Deprecated('Use StateMutation instead')
typedef VxMutation<T extends VxStore?> = StateMutation<T>;

@Deprecated('Use StateNotifier instead')
typedef VxBuilder<T> = StateBuilder<T>;

@Deprecated('Use StateConsumer instead')
typedef VxConsumer<T> = StateConsumer<T>;

@Deprecated('Use StateNotifier instead')
typedef VxNotifier = StateNotifier;

@Deprecated('Use ContextCallback instead')
typedef VxInterceptor<T extends VxStore?> = LayrzStateInterceptor<T>;

bool debugCheckHasLayrzState(BuildContext context) {
  assert(() {
    if (context.findAncestorWidgetOfExactType<LayrzState>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No LayrzState widget found.'),
        ErrorDescription(
          'LayrzState.of() was called with a context that does not contain a LayrzState.\n',
        ),
        ErrorHint(
          'No LayrzState ancestor could be found starting from the context that was passed to LayrzState.of().\n'
          'This can happen because you do not have a WidgetsApp or MaterialApp widget (those widgets introduce '
          'a LayrzState), or it can happen if the context you use comes from a widget above those widgets.\n'
          'The context used was:\n'
          '  $context',
        ),
      ]);
    }
    return true;
  }());
  return true;
}
