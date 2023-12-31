

class enrollModel {
  String? id, course_id, user_id, state;
  List<String>? video_seen, quiz_complete;

  enrollModel({
    this.id,
    this.course_id,
    this.user_id,
    this.state,
    this.video_seen,
    this.quiz_complete,
  });

  toJSON() {
    return {
      'id' : id,
      'course_id' : course_id,
      'user_id' : user_id,
      'state' : state,
      'video_seen' : video_seen,
      'quiz_complete' : quiz_complete,
    };
  }

  enrollModel.fromJson(Map<dynamic, dynamic> map) {
    course_id = map['course_id'];
    id = map['id'];
    user_id = map['user_id'];
    state = map['state'];
    video_seen = map['video_seen'];
    quiz_complete = map['quiz_complete'];
  }
}