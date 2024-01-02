
import 'package:flutter_application_1/model/courseModel.dart';

var categoryItem = [
  'Coding',
  'Education',
  'Design',
  'Electronics',
  'Finance',
  'Art',
  'Music',
  'Cooking',
  'Business',
  'Other',
];

class categoryModel {
  String? id, name, icon;
  List<courseBasicModel>? courses;

  toJSON() {
    return {
      'id' : id,
      'name' : name,
      'icon' : icon,
      'courses' : courses,
    };
  }

  categoryModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    icon = map['icon'];
    courses?.add(courseBasicModel.fromJson(map['courses']));
  }
}