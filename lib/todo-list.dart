import 'package:flutter/material.dart';
// ローカル保存
import 'package:shared_preferences/shared_preferences.dart';

//チェック管理の保存の仕方

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  String task = '';
  final TextEditingController ctrl = TextEditingController();
  List<String> todoList = ['aaa', "bbb"];
  List<bool> checkFlags = [false, false, true, false, true];
  int indent = 0;
  bool addFlag = false;
  SharedPreferences prefs;

  Future<void> getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

// /*ローカル保存
  _setPrefItems(List<String> e, key) async {
    await getSharedPreference();
    prefs.setStringList(key, e);
  }

//ローカルから取得
  _getPrefItems(key) async {
    await getSharedPreference();
    setState(() {
      // e = prefs.getStringList(key) ?? [];
      todoList = prefs.getStringList(key) ?? [];
    });
  }

//ローカル保存削除
  _clearPrefItems(key) async {
    await getSharedPreference();
    await prefs.remove(key);
  }

// */リスト表示
  Widget showList(e) {
    return ListView.builder(
      itemCount: e.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            child: ListTile(
              title: Text(
                e[index],
                style: TextStyle(fontSize: 24),
              ),
              // subtitle: Text('2022'), // 日付
              // trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.check_circle_outline,
                  color: !checkFlags[index] ? Colors.grey : Colors.pinkAccent),
              onTap: () {
                setState(() {
                  checkFlags[index] = !checkFlags[index];
                });
              },
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              todoList.removeAt(index);
              checkFlags.removeAt(index);
            });
          },
          background: Container(
            color: Colors.red,
          ),
        );
      },
    );
  }

//再起動時実行
  @override
  void initState() {
    super.initState();
    setState(() {
      _getPrefItems("list");
      showList(todoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextField(
              controller: ctrl,
              decoration: InputDecoration(labelText: ('ToDo')),
              onSubmitted: (value) {
                print('value:$value');
                task = value;
                setState(() {
                  task.trim().length > 0 ? addFlag = true : addFlag = false;
                });
              },
            ),
            addFlag
                ? FloatingActionButton(
                    onPressed: () => {
                      setState(() {
                        todoList.add(task);
                        checkFlags.add(false);
                        indent = todoList.length;
                        ctrl.clear();
                        task = "";
                        addFlag = false;
                        _setPrefItems(todoList, "list"); //ローカル保存
                        print(todoList);
                      }),
                    },
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add),
                  )
                : FloatingActionButton(
                    onPressed: null,
                    backgroundColor: Colors.grey[600],
                    child: Icon(Icons.add)),
            Expanded(child: showList(todoList)),
            IconButton(
              color: Colors.red[400],
              icon: Icon(Icons.delete),
              onPressed: (() => _clearPrefItems("list")),
            )
          ],
        ),
      ),
    );
  }
}
