class SubjectModel {
  var categoryId;
  var classId;
  var mfid;
  var name;
  var id;

  SubjectModel({this.categoryId, this.mfid, this.name, this.classId, this.id});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'classId': classId,
      'mfid': mfid,
      'id': id,
      'name': name,
    };
  }

  SubjectModel.fromMap(Map<String, dynamic> map)
      : categoryId = map['categoryId'],
        mfid = map['mfid'],
        classId = map['classId'],
        id = map['id'],
        name = map['name'];
}
