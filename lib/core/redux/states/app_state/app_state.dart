import 'package:bumn_eid/core/redux/states/auth/auth_state.dart';
import 'package:bumn_eid/core/redux/states/companies/companies_state.dart';
import 'package:bumn_eid/core/redux/states/last_updated/last_update_state.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:copy_with_extension/copy_with_extension.dart';

// Generated code by @CopyWith
part 'app_state.g.dart';

// NOTE:
// If you change any of the @CopyWith classes (or add new ones),
// you will need to run a command to re-generate the copyWith code.
//
// RUN THIS WHEN CHANGING ANY @CopyWith CLASS:
// $ flutter pub run build_runner build
//
// Altenatively, on VSCode, you can use the Command Palette > Run Build Task > Generate Flutter code
//
@immutable
@CopyWith()
class AppState {
  // Initialize the default values here:
  const AppState({
    CompaniesState companiesState,
    AuthState authState,
    LastUpdateState lastUpdateState
  })  : this.companiesState =
      companiesState ?? const CompaniesState(),
        this.authState =
            authState ?? const AuthState(),
        this.lastUpdateState = lastUpdateState ?? const LastUpdateState();

  // Finally, the properties of this class:
  final CompaniesState companiesState;
  final AuthState authState;
  final LastUpdateState lastUpdateState;
}
