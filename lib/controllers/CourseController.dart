

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:get/get.dart';

class courseController extends GetxController {
  List<courseModel> allCourse = [];

  loadAllCourse() async {
    // print("start");
    allCourse.clear();
    CollectionReference _collection = FirebaseFirestore.instance.collection('Course');
    QuerySnapshot querySnap = await _collection.get();

    for(QueryDocumentSnapshot docSnap in querySnap.docs) {
      Map<dynamic, dynamic> value = docSnap.data() as Map<dynamic, dynamic>;
      allCourse.add(courseModel.fromJson(value));
    }
    // print("end");
    
  }
  Future<bool> updateInfo(String uid, num value) async {
    if(value <= 0) return true;
    final post =  await FirebaseFirestore.instance.collection("Course")
    .where('id', isEqualTo: uid).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    
    DocumentSnapshot table =  await FirebaseFirestore.instance.doc(post.path).get();
    Map<dynamic, dynamic> temp = table.data() as Map<dynamic, dynamic>;
    courseModel course = courseModel.fromJson(temp);
    
    num new_rating = (course.rating! * course.rating_count!) + value;
    num new_rating_count = course.rating_count! + 1;
    new_rating = new_rating / (course.rating_count! + 1);
    new_rating = num.parse(new_rating.toStringAsFixed(1));
    for(int i = 0; i < allCourse.length; i++) {
      if(allCourse[i].id == uid) {
        allCourse[i].rating = new_rating;
        allCourse[i].rating_count = new_rating_count;
      }
    }

    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    batch.update(post, { 'rating': new_rating, 'rating_count' : new_rating_count}); 
    await batch.commit();
    return true;
  }
}