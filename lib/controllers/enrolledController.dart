

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/enrollModel.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:get/get.dart';

class enrolledController extends GetxController {
  List<enrollModel> allCourse = [];
  
  loadAllCourse(String uid) async {
    allCourse.clear();
    CollectionReference _collection = FirebaseFirestore.instance.collection('Enrollment');
    QuerySnapshot querySnap = await _collection.get();

    for(QueryDocumentSnapshot docSnap in querySnap.docs) {
      Map<dynamic, dynamic> value = docSnap.data() as Map<dynamic, dynamic>;
      if(value['user_id'] == uid) {
        allCourse.add(enrollModel.fromJson(value));
      }
    }
  }

  Future<bool> updateInfo(String uid, String courseId, num value) async {
    enrollModel enroll = enrollModel(
      id: "${uid}_${courseId}", course_id: courseId, user_id: uid, video_seen: [], quiz_complete: []);
    FirebaseFirestore.instance.collection('Enrollment').doc().set(enroll.toJSON());
    
    final post =  await FirebaseFirestore.instance.collection("User")
    .where('id', isEqualTo: uid).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    batch.update(post, { 'money': value }); 
    batch.commit();
    await loadAllCourse(uid);
    return true;
  }

  Future<bool> remove(String uid, String course_id) async {

    var collection = FirebaseFirestore.instance.collection('Enrollment');
    var snapshot = await collection.where('user_id', isEqualTo: uid).where('course_id', isEqualTo: course_id).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    enrollModel index;
    for(int i = 0; i < allCourse.length; i++) {
      if(allCourse[i].user_id == uid && allCourse[i].course_id == course_id) {
        allCourse.remove(allCourse[i]);
        return true;
      }
    }

    return true;
  }

  Future<bool> updateResource(String uid, String courseId, bool isvideo) async {
    final post =  await FirebaseFirestore.instance.collection("Enrollment")
    .where('user_id', isEqualTo: uid)
    .where('course_id', isEqualTo: courseId).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    if(isvideo) {
      var index = 0;
      for(int i = 0; i < allCourse.length; i++) {
        if(allCourse[i].user_id == uid && allCourse[i].course_id == courseId) {
          allCourse[i].video_seen.add('done');
          index = i;
        }
      }
      batch.update(post, { 'video_seen': FieldValue.arrayUnion(['done${allCourse[index].video_seen.length}']) }); 
      batch.commit();
    }
    else {
      var index = 0;
      for(int i = 0; i < allCourse.length; i++) {
        if(allCourse[i].user_id == uid && allCourse[i].course_id == courseId) {
          allCourse[i].quiz_complete.add('done');
          index = i;
        }
      }
      batch.update(post, { 'quiz_complete': FieldValue.arrayUnion(['done${allCourse[index].quiz_complete.length}']) }); 
      batch.commit();
    }
    
    // await loadAllCourse(uid);
    return true;
  }

}