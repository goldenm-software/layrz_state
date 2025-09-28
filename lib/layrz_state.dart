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
