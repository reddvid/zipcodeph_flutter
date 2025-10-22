import '../db/zip_db.dart';
import '../models/zipcode.dart';
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
    // Optimize for memory: don't load all data if query is empty
    if (query.isEmpty) {
      return null; // Return null to indicate no search performed
    }

    // Use direct database query instead of loading all data
    var db = await _db.database;
    if (db == null) return null;

    var items = await db.query(
      ZipDB.table,
      where: '${ZipDB.columnTown} LIKE ? OR ${ZipDB.columnArea} LIKE ?',
      whereArgs: ['${query.toLowerCase()}%', '${query.toLowerCase()}%'],
      limit: 50, // Limit results to manage memory
    );

    return items.map((item) => ZipCode.fromMap(item)).toList();
  }

  @override
  Future<List<ZipCode>?> getAreaCodes(String query) async {
    var db = await _db.database;
    if (db == null) return null;

    if (query.isEmpty) {
      // Load all area codes but with pagination support
      var items = await db.query(
        ZipDB.table,
        limit: 100, // Limit initial load
      );
      return items.map((item) => ZipCode.fromMap(item)).toList();
    } else {
      var items = await db.query(
        ZipDB.table,
        where: '${ZipDB.columnArea} LIKE ?',
        whereArgs: ['${query.toLowerCase()}%'],
      );
      return items.map((item) => ZipCode.fromMap(item)).toList();
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
