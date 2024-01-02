import 'package:flutter_application_1/model/quizModel.dart';
import 'package:flutter_application_1/model/videoModel.dart';

class courseModel {
  String? id, title, description, category, instructor, img;
  String? payment;
  num? rating, rating_count;
  List<videoModel>? videos;
  List<quizModel>? quizzes;

  courseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    required this.category,
    required this.instructor,
    required this.payment,
    required this.rating,
    required this.rating_count,
    required this.videos,
    required this.quizzes,
  });

  toJSON() {
    List videoJson = [], quizJson = [];
    if (videos?.length != null) {
      for (var i = 0; i < videos!.length; i++) {
        videoJson.add(videos?[i].toJSON());
      }
    }
    if(quizzes?.length != null) {
      for (var i = 0; i < quizzes!.length; i++) {
        quizJson.add(quizzes?[i].toJSON());
      }
    }
    return {
      'id': id,
      'title': title,
      'description': description,
      'img': img,
      'category': category,
      'instructor': instructor,
      'payment': payment,
      'rating': rating,
      'rating_count': rating_count,
      'videos': videoJson,
      'quizzes': quizJson,
    };
  }

  courseModel.fromJson(Map<dynamic, dynamic> map) {
    title = map['title'];
    id = map['id'];
    description = map['description'];
    img = map['img'];
    category = map['category'];
    instructor = map['instructor'];
    payment = map['payment'];
    rating = map['rating'];
    rating_count = map['rating_count'];
    videos?.add(videoModel.fromJson(map['videos']));
    quizzes?.add(quizModel.fromJson(map['quizzes']));
  }
}

class courseBasicModel {
  String? course_id, title, img, category, payment;
  double? rating;

  toJSON() {
    return {
      'course_id': course_id,
      'title': title,
      'img': img,
      'rating': rating,
      'category': category,
      'payment': payment,
    };
  }

  courseBasicModel.fromJson(Map<dynamic, dynamic> map) {
    title = map['title'];
    course_id = map['course_id'];
    img = map['img'];
    rating = map['rating'];
    category = map['category'];
    payment = map['payment'];
  }
}
