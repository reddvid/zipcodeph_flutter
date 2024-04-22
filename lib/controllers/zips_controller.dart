import 'package:zipcodeph_flutter/services/zip_brain.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/models/zipcodes_data.dart';

class ZipsController {

  final ZipRepository _zipRepo = ZipRepository(ZipDB());

  Future<List<ZipCode>?> getAreaCodes(String area) async {
    return await _zipRepo.getAreaCodes(area);
  }

  Future<void> unFaveItem(ZipCode zipCode) async {
    zipCode.fave = 0;
    return await _zipRepo.update(zipCode);
  }

  Future<void> faveItem(ZipCode zipCode) async {
    zipCode.fave = 1;
    return await _zipRepo.update(zipCode);
  }
}
