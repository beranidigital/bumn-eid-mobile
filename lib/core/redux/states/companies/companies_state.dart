import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:copy_with_extension/copy_with_extension.dart';

// Generated code by @CopyWith
part 'companies_state.g.dart';

@immutable
@CopyWith()
class CompaniesState {
  // Initialize the default values here:
  const CompaniesState({
    List<ProfilPerusahaan> companies,
    List<ProfilPerusahaan> filteredTotalCompanies
  })
      : this.companies = companies ?? const [],
        this.filteredTotalCompanies = filteredTotalCompanies ?? const [];

  /// The company list we fetched from the server.
  final List<ProfilPerusahaan> companies;

  /// Filtered total companies for total_bumn_page
  final List<ProfilPerusahaan> filteredTotalCompanies;

}
