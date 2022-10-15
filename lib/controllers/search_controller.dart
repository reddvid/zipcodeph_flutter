import 'package:zipcodeph_flutter/services/zip_brain.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/models/zipcodes_data.dart';

class SearchController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getAllCodes() {
    return _zipRepo.getAll();
  }

  Future<List<ZipCode>?> findCodes(String query) {
    return _zipRepo.find(query);
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
