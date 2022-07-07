import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ZipDB {
  // final List<Map<String, dynamic>> _items = [
  //   {'code': 2418, 'town': 'Calasiao', 'area': 'Pangasinan', 'fave': false},
  //   {'code': 2400, 'town': 'Dagupan', 'area': 'Pangasinan', 'fave': false},
  // ];

  static final _databaseName = "test_.db";
  static final _databaseVersion = 1;

  static final table = "codes";

  static final columnId = '_code';
  static final columnTown = 'town';
  static final columnArea = 'area';
  static final columnFave = 'fave';

  ZipDB._privateConstructor();
  static final ZipDB instance = ZipDB._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    String path = join(applicationDirectory.path, 't2.db');
    bool dbExists = await io.File(path).exists();
    if (!dbExists) {
      ByteData data = await rootBundle.load(join('assets', 't2.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }

  factory ZipDB() {
    return instance;
  }

  // DATABASE METHODS
  Future<List<Map<String, dynamic>>?> list() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  Future<int?> update(Map<String, dynamic> updatedItem) async {
    Database? db = await instance.database;
    int i = updatedItem[columnId];
    String area = updatedItem[columnArea];
    return await db?.update(table, updatedItem,
        where: '$columnId = ? AND $columnArea = ?', whereArgs: [i, area]);
  }
}
