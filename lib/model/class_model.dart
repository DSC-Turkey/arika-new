class ClassModel {
  var categoryID;
  var grade;

  ClassModel({this.categoryID, this.grade});

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'grade': grade,
    };
  }

  ClassModel.fromMap(Map<String, dynamic> map)
      : categoryID = map['categoryID'],
        grade = map['grade'];
}
