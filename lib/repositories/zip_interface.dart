import '../models/zipcode.dart';

abstract class IZipRepository {
  Future<List<ZipCode>> getAll();
  Future<List<ZipCode>> getAreaCodes(String area);
  Future<List<ZipCode>?> find(String query);
}
