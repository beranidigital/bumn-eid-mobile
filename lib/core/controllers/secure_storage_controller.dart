import 'dart:convert';

import 'package:bumn_eid/core/models/common/local_companies.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKey { user, companies, session }

class SecureStorageController {
  final FlutterSecureStorage _storage;

  SecureStorageController([FlutterSecureStorage storage])
      : this._storage = storage ?? FlutterSecureStorage();

  void clear() {
    _storage.deleteAll();
  }

  Future<User> getUser() async {
    String jsonString =
        await _storage.read(key: SecureStorageKey.user.toString());
    if (jsonString == null) return null;
    final json = jsonDecode(jsonString);
    return User.fromJson(json);
  }

  Future<void> saveUser(User value) {
    final json = value.toJson();
    final jsonString = jsonEncode(json);
    return _storage.write(
        key: SecureStorageKey.user.toString(), value: jsonString);
  }

  Future<void> deleteUser() async {
    return _storage.deleteAll();
  }

  Future<bool> companiesExist() async {
    String jsonString =
        await _storage.read(key: SecureStorageKey.companies.toString());
    if (jsonString == null) return false;
    final json = jsonDecode(jsonString);
    final companies = LocalCompanies.fromJson(json);
    return companies.checkIfStillEligible();
  }

  Future<List<ProfilPerusahaan>> getCompanies() async {
    String jsonString =
        await _storage.read(key: SecureStorageKey.companies.toString());
    if (jsonString == null) return null;
    final json = jsonDecode(jsonString);
    final companies = LocalCompanies.fromJson(json);
    if (!companies.checkIfStillEligible()) return null;
    return companies.companies;
  }

  Future<void> saveCompanies(List<ProfilPerusahaan> companies) {
    final now = DateTime.now();
    final toBeSaved = LocalCompanies(companies: companies, savedTime: now);
    final jsonString = jsonEncode(toBeSaved.toJson());
    return _storage.write(
        key: SecureStorageKey.companies.toString(), value: jsonString);
  }

  Future<void> deleteCompanies() {
    return _storage.delete(key: SecureStorageKey.companies.toString());
  }
}
