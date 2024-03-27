import 'package:bumn_eid/core/models/common/user.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:copy_with_extension/copy_with_extension.dart';

// Generated code by @CopyWith
part 'auth_state.g.dart';

@immutable
@CopyWith()
class AuthState {
  // Initialize the default values here:
  const AuthState({User currentUser})
      : this.currentUser = currentUser;

  /// Current logged on user.
  final User currentUser;

}
