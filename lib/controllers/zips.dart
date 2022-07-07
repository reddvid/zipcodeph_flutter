import 'package:zipcodeph_flutter/db/zip_db.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/repositories/zip.dart';

class ZipsController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getAreaCodes(String area) {
    return _zipRepo.getAreaCodes(area);
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
