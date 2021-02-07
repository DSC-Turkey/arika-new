class TeacherModel {
  var categoryId;
  var classId;
  var subjectId;
  var url;
  var userid;
  var name;
  var description;

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'classId': classId,
      'subjectId': subjectId,
      'url': url,
      'userid': userid,
      'description': description,
      'name': name,
    };
  }

  TeacherModel.fromMap(Map<String, dynamic> map)
      : categoryId = map['categoryId'],
        classId = map['classId'],
        subjectId = map['subjectId'],
        url = map['url'],
        description = map['description'],
        userid = map['userid'],
        name = map['name'];
}
