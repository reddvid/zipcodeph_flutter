import 'package:zipcodeph_flutter/db/zip_db.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/repositories/zip.dart';

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
