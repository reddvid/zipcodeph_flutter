import '../db/zip_db.dart';
import '../models/zipcode.dart';
import '../repositories/zip.dart';

class FavesController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getFaves() {
    return _zipRepo.getFaves();
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
