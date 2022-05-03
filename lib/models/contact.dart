class Contact{

  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colMobile = 'mobile';

  Contact({
    required this.id,
    required this.name,
    required this.mobile
});

  Contact.formMap(Map<String, dynamic> map){
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
  }

  int id;
  String name;
  String mobile;

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      colName: name,
      colMobile: mobile,
    };
    if(id != null) {
      map[colId] = id;
    }
    return map;
  }
}

