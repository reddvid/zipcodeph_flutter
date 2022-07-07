import 'package:zipcodeph_flutter/db/zip_db.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/repositories/zip_interface.dart';

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
    var filtered = items
        ?.where((i) =>
            i['town'].toString().toLowerCase().startsWith(query.toLowerCase()))
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
        ?.where((i) =>
            i['town'].toString().toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query == "") {
      return items?.map((item) => ZipCode.fromMap(item)).toList();
    } else {
      return filtered?.map((item) => ZipCode.fromMap(item)).toList();
    }
  }

  @override
  Future<void> update(ZipCode zipCode) async {
    await _db.update(zipCode.toMap());
  }
}
