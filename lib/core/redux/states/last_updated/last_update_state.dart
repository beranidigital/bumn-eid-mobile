import 'package:bumn_eid/core/models/common/last_update.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:copy_with_extension/copy_with_extension.dart';

// Generated code by @CopyWith
part 'last_update_state.g.dart';

@immutable
@CopyWith()
class LastUpdateState {
  // Initialize the default values here:
  const LastUpdateState({
    List<LastUpdate> lastUpdated,
  })
      : this.lastUpdated = lastUpdated ?? const [];

  /// The last updated data list we got from server.
  final List<LastUpdate> lastUpdated;

}
