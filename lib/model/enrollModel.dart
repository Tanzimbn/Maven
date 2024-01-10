

class enrollModel {
  String? id, course_id, user_id, state;
  List<dynamic> video_seen = [], quiz_complete = [];

  enrollModel({
    required this.id,
    required this.course_id,
    required this.user_id,
    this.state = "Not complete",
    required this.video_seen,
    required this.quiz_complete,
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