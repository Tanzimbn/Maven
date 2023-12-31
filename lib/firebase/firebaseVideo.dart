import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadUserPhoto(String url, String uid) async {
    Reference ref = _storage.ref().child('photo/${DateTime.now()}_${uid}.jpg');
    await ref.putFile(File(url));
    String firebase_url = await ref.getDownloadURL();
    return firebase_url;
  }

  Future<String> uploadCoursePhoto(String url, String uid) async {
    Reference ref = _storage.ref().child('CourseImg/${DateTime.now()}_${uid}.jpg');
    await ref.putFile(File(url));
    String firebase_url = await ref.getDownloadURL();
    return firebase_url;
  }

  Future<String> uploadVideo(String url) async {
    Reference ref = _storage.ref().child('video/${DateTime.now()}.mp4');
    await ref.putFile(File(url));
    String firebase_url = await ref.getDownloadURL();
    return firebase_url;
  }

  Future<void> saveVideo(String url, String dbCollection) async {
    await _firestore.collection(dbCollection).add({
      'url' : url,
    });
  }
}