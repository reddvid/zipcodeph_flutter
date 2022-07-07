import 'dart:math';

class ZipDB {
  final List<Map<String, dynamic>> _items = [
    {'code': 2418, 'town': 'Calasiao', 'area': 'Pangasinan', 'fave': false},
    {'code': 2400, 'town': 'Dagupan', 'area': 'Pangasinan', 'fave': false},
  ];
  static final ZipDB _db = ZipDB._privateConstructor();

  ZipDB._privateConstructor();

  factory ZipDB() {
    return _db;
  }

  Future<List<Map<String, dynamic>>> list() async {
    return _items;
  }
}
