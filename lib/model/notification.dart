

class notificationModel {
  String? id, user_id, title, message;
  bool? seen;

  notificationModel({
    required this.id,
    required this.user_id,
    required this.title,
    required this.message,
    required this.seen,
  });

  toJSON() {
    return {
      'id' : id,
      'user_id' : user_id,
      'title' : title,
      'message' : message,
      'seen' : seen,
    };
  }

  notificationModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    user_id = map['user_id'];
    title = map['title'];
    message = map['message'];
    seen = map['seen'];
  }
}