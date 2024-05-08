

import '../db/zip_db.dart';
import '../models/zipcode.dart';
import '../models/zipcodes_data.dart';

class ZipsController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> find(String area) {
    return _zipRepo.find(area);
  }

  Future<List<ZipCode>?> getAreaCodes(String area) {
    return _zipRepo.getAreaCodes(area);
  }

  Future<void> unFaveItem(ZipCode zipCode) {
    zipCode.fave = 0;
    return _zipRepo.update(zipCode);
  }

  Future<void> faveItem(ZipCode zipCode) {
    zipCode.fave = 1;
    return _zipRepo.update(zipCode);
  }
}
