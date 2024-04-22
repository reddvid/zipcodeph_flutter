import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/models/zipcodes_data.dart';
import 'package:zipcodeph_flutter/services/zip_brain.dart';

class CustomSearchController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getAllCodes() async {
    return await _zipRepo.getAll();
  }

  Future<List<ZipCode>?> findCodes(String query) async {
    return await _zipRepo.find(query);
  }

  Future<void> updateItem(ZipCode zipCode) async {
    return await _zipRepo.update(zipCode);
  }
}
