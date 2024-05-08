import 'package:zipcodeph_flutter/models/zipcode.dart';

import '../db/zip_db.dart';
import '../repositories/zip_interface.dart';

class ZipRepository implements IZipRepository {
  late final ZipDB _db;

  ZipRepository(this._db);

  @override
  Future<List<ZipCode>?> getAll() async {
    var items = await _db.list();
    return items?.map((item) => ZipCode.fromMap(item)).toList();
  }

  @override
  Future<List<ZipCode>?> find(String query) async {
    var items = await _db.list();

    query = query.trim();

    if (query.toLowerCase().contains("Pinas")) {
      query = query.replaceFirst("Pinas", "Piñas");
    }

    var filtered = items
        ?.where((i) =>
            i['town']
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()) ||
            i['area'].toString().toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query == "") {
      return items?.map((item) => ZipCode.fromMap(item)).toList();
    } else {
      return filtered?.map((item) => ZipCode.fromMap(item)).toList();
    }
  }

  @override
  Future<List<ZipCode>?> getAreaCodes(String query) async {
    var items = await _db.list();
    var filtered = items
        ?.where(
            (i) => i['area'].toString().toLowerCase() == query.toLowerCase())
        .toList();
    if (query == "") {
      return items?.map((item) => ZipCode.fromMap(item)).toList();
    } else {
      return filtered?.map((item) => ZipCode.fromMap(item)).toList();
    }
  }

  Future<void> update(ZipCode zipCode) async {
    await _db.update(zipCode.toMap());
  }

  Future<List<ZipCode>?> getFaves() async {
    var items = await _db.list();
    return items
        ?.where((i) => i['fave'] == 1)
        .toList()
        .map((e) => ZipCode.fromMap(e))
        .toList();
  }
}
