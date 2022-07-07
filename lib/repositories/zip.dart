import 'package:zipcodeph_flutter/db/zip_db.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/repositories/zip_interface.dart';

class ZipRepository implements IZipRepository {
  late final ZipDB _db;

  ZipRepository(this._db);

  @override
  Future<List<ZipCode>> getAll() async {
    var items = await _db.list();
    return items.map((item) => ZipCode.fromMap(item)).toList();
  }

  @override
  Future<List<ZipCode>?> find(String query) {
    // TODO: implement find
    throw UnimplementedError();
  }
}
