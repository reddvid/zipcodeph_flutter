import '../db/zip_db.dart';
import '../models/zipcode.dart';
import '../models/zipcodes_data.dart';

class SearchZipsController {
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
