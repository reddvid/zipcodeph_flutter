import 'package:zipcodeph_flutter/models/zipcode.dart';

import '../db/zip_db.dart';
import '../repositories/zip.dart';

class SearchController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB.instance);

  Future<List<ZipCode>?> getAllCodes() {
    return _zipRepo.getAll();
  }

  Future<List<ZipCode>?> findCodes(String query) {
    // Return empty list for very short queries to avoid excessive results
    if (query.trim().length < 2) {
      return Future.value(<ZipCode>[]);
    }
    return _zipRepo.find(query);
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
