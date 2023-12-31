
class quizModel {
  late String id;
  String? title, question, op1, op2, op3, op4, answer;
  int? point;

  quizModel({
    required this.id,
    required this.title,
    required this.question,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.answer,
    required this.point,
  });

  toJSON() {
    return {
      'id' : id,
      'title' : title,
      'question' : question,
      'op1' : op1,
      'op2' : op2,
      'op3' : op3,
      'op4' : op4,
      'answer' : answer,
      'point' : point,
    };
  }

  quizModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    title = map['title'];
    question = map['question'];
    op1 = map['op1'];
    op2 = map['op2'];
    op3 = map['op3'];
    op4 = map['op4'];
    answer = map['answer'];
    point = map['point'];
  }
}