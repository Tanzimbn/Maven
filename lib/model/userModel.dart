

class userModel {
  String? id, name, email, img;
  int? point;

  userModel({
    this.id,
    this.name,
    this.email,
    this.img,
    this.point,
  });

  toJSON() {
    return {
      'id' : id,
      'name' : name,
      'email' : email,
      'img' : img,
      'point' : point,
    };
  }

  userModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    img = map['img'];
    point = map['point'];
  }
}