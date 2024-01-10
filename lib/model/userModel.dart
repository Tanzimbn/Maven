

class userModel {
  String? id, name, email, img;
  num? point, money;

  userModel({
    this.id,
    this.name,
    this.email,
    this.img,
    this.point,
    this.money,
  });

  toJSON() {
    return {
      'id' : id,
      'name' : name,
      'email' : email,
      'img' : img,
      'point' : point,
      'money' : money,
    };
  }

  userModel.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    img = map['img'];
    point = map['point'];
    money = map['money'];
  }
}