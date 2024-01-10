

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/notification.dart';
import 'package:get/get.dart';

class notificationController extends GetxController {
  List<notificationModel> allnotification = [];

  loadAllNotification(String uid) async {
    allnotification.clear();
    CollectionReference _collection = FirebaseFirestore.instance.collection('Notification');
    QuerySnapshot querySnap = await _collection.get();

    for(QueryDocumentSnapshot docSnap in querySnap.docs) {
      Map<dynamic, dynamic> value = docSnap.data() as Map<dynamic, dynamic>;
      if(value['user_id'] == uid)
      allnotification.add(notificationModel.fromJson(value));
    }

    
  }

  Future<bool> addNotification(String uid, String title, String message, bool seen) async {
    notificationModel noti = notificationModel(id: DateTime.now().toString(), user_id: uid, title: title, message: message, seen: seen);
    FirebaseFirestore.instance.collection('Notification').doc().set(noti.toJSON());

    await loadAllNotification(uid);
    return true;
  }

  Future<bool> updateNotification(String id, String user_id) async {
    final post =  await FirebaseFirestore.instance.collection("Notification")
    .where('id', isEqualTo: id).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    batch.update(post, { 'seen': true }); 
    batch.commit();
    await loadAllNotification(user_id);
    return true;
  }
}