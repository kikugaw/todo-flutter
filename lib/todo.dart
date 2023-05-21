class Todo {
  String title;
  bool cFlag;

  /// コンストラクタ
  Todo(
    this.title,
    this.cFlag,
  );

  Map toJson() {
    return {
      'title': title,
      "cFlag": cFlag,
    };
  }

  Todo.fromJson(Map json) {
    title = json['title'];
    cFlag = json["cFlag"];
  }
}
