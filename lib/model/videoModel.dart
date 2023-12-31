

class videoModel {
  String? title;
  String? url;

  videoModel({
    required this.title,
    required this.url,
  });

  toJSON() {
    return {
      'title' : title,
      'url' : url,
    };
  }

  videoModel.fromJson(Map<dynamic, dynamic> map) {
    title = map['title'];
    url = map['url'];
  }
}