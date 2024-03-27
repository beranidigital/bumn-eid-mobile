// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension AppStateCopyWithExtension on AppState {
  AppState copyWith({
    AuthState authState,
    CompaniesState companiesState,
    LastUpdateState lastUpdateState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      companiesState: companiesState ?? this.companiesState,
      lastUpdateState: lastUpdateState ?? this.lastUpdateState,
    );
  }
}
