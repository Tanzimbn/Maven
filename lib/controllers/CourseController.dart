

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:get/get.dart';

class courseController extends GetxController {
  List<courseModel> allCourse = [];

  loadAllCourse() async {
    allCourse.clear();
    CollectionReference _collection = FirebaseFirestore.instance.collection('Course');
    QuerySnapshot querySnap = await _collection.get();

    for(QueryDocumentSnapshot docSnap in querySnap.docs) {
      Map<dynamic, dynamic> value = docSnap.data() as Map<dynamic, dynamic>;
      allCourse.add(courseModel.fromJson(value));
    }

    
  }
}