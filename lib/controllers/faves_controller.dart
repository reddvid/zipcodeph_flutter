import 'package:zipcodeph_flutter/models/zipcode.dart';

import '../models/zipcodes_data.dart';
import '../services/zip_brain.dart';

class FavoritesController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getFaves() {
    return _zipRepo.getFaves();
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
