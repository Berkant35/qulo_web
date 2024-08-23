import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';

/// when we're listening to multi devices'
/// events, we need to know when to break the
/// listening loop.
@JsonEnum(fieldRename: defaultFieldRename)
enum EventExecutionType {
  /// after the very first event, we'll stop listening
  firstEvent,

  /// after the very last event, we'll stop listening
  awaitAllEvents,
}
