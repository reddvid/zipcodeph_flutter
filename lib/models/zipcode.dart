class ZipCode {
  final int id;
  final int code;
  final String town;
  final String area;
  int fave;

  ZipCode(this.id, this.code, this.town, this.area, this.fave);

  ZipCode.fromMap(Map<String, dynamic> data)
      : id = data['_id'],
        code = data['code'],
        town = data['town'],
        area = data['area'],
        fave = data['fave'];

  Map<String, dynamic> toMap() {
    return {'_id': id, 'code': code, 'town': town, 'area': area, 'fave': fave};
  }
}
