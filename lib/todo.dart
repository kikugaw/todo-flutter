class Todo {
  String title;
  bool checkFlag;

  /// コンストラクタ
  Todo(
    this.title,
    this.checkFlag,
  );

  Map toJson() {
    return {
      'title': title,
      "checkFlag": checkFlag,
    };
  }

  Todo.fromJson(Map json) {
    title = json['title'];
    checkFlag = json["checkFlag"];
  }
}
