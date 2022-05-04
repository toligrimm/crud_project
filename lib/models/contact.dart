class Contact {
  int? id;
  String? name;
  String? mobile;

  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colMobile = 'mobile';

  Contact({required this.id,required this.name,required this.mobile});



  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colName: name, colMobile: mobile};
    map[colId] = id;
    return map;
  }
}
