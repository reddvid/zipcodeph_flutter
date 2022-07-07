class ZipCode {
  final int code;
  final String town;
  final String area;
  int fave;

  ZipCode(this.code, this.town, this.area, this.fave);

  ZipCode.fromMap(Map<String, dynamic> data)
      : code = data['_code'],
        town = data['town'],
        area = data['area'],
        fave = data['fave'];

  Map<String, dynamic> toMap() {
    return {'_code': code, 'town': town, 'area': area, 'fave': fave};
  }
}
