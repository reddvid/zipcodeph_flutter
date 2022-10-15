import 'package:zipcodeph_flutter/services/zip_brain.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/models/zipcodes_data.dart';

class ZipsController {
  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getAreaCodes(String area) {
    return _zipRepo.getAreaCodes(area);
  }

  Future<void> updateItem(ZipCode zipCode) {
    return _zipRepo.update(zipCode);
  }
}
