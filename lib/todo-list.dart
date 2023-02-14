import 'package:flutter/material.dart';
/*ローカル保存
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'todo.dart';
*/

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  String task = '';
  final TextEditingController ctrl = TextEditingController();
  List<String> todoList = ['aaa', "bbb"];
  int indent = 0;
  bool addFlag = false;
  List<bool> checkFlags = [false, false];

/*  ローカル保存
  _setPrefItems(List<String> e) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("title", e);
    print("e:$e");
  }

  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList("title") ?? [];
      print("e:$todoList");    

    });
  }
  */

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

/*  ローカル保存
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    setState(() {
      _getPrefItems();
      showList(todoList);
    });
  }
  */

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
                  task.length > 0 ? addFlag = true : addFlag = false;
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
                        // _setPrefItems(todoList); ローカル保存
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
          ],
        ),
      ),
    );
  }
}
