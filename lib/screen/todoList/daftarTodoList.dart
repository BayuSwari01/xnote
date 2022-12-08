import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_note/models/Todolist.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';
import 'package:x_note/screen/todoList/editTodoList.dart';
import 'package:x_note/screen/todoList/tambahTodoList.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:intl/intl.dart';

class daftarTodoList extends StatefulWidget {
  const daftarTodoList({super.key});

  @override
  State<daftarTodoList> createState() => _daftarTodoListState();
}

class _daftarTodoListState extends State<daftarTodoList> {
  List<Todolist> todolists = [];
  String? emailFix;
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 120, 120, 120),
          title: Center(child: Text("Daftar Todo List"))),
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        child: ListView(
          children: <Widget>[
            DataTable(
              dividerThickness: 3,
              headingRowHeight: 60,
              dataRowHeight: 60,
              showCheckboxColumn: true,
              dataRowColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Color.fromARGB(100, 215, 217, 219)),
              columns: [
                DataColumn(
                    label: Text(
                  "Todo List",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ))
              ],
              rows: List<DataRow>.generate(
                todolists.length,
                (index) => DataRow(
                  selected: todolists[index].status ?? false,
                  onSelectChanged: (value) {
                    showAdaptiveActionSheet(
                      context: context,
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                          title: Icon(
                            Icons.done,
                            size: 20,
                            color: Colors.blueAccent,
                          ),
                          onPressed: (context) async {
                            int status;
                            if (todolists[index].status!) {
                              status = 0;
                            } else {
                              status = 1;
                            }
                            _editStatusTodolist(todolists[index].id, status);
                            Navigator.pop(context);
                            setState(() {
                              _getTodolist();
                            });
                          },
                        ),
                        BottomSheetAction(
                          title: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          onPressed: (context) async {
                            Navigator.pop(context);
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return editTodoList(
                                todo: todolists[index],
                              );
                            }));
                            setState(() {
                              _getTodolist();
                            });
                          },
                        ),
                        BottomSheetAction(
                          title: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          onPressed: (context) async {
                            _delete(todolists[index].id);
                            setState(() {
                              _getTodolist();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      cancelAction: CancelAction(
                        title: Text("Cancel"),
                      ),
                    );
                  },
                  cells: [
                    DataCell(
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              todolists[index].todo ?? "404",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(todolists[index].tanggal.toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahTodoList(
              email: emailFix,
            );
          }));
          setState(() {
            _getTodolist();
          });
        },
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        child: Icon(Icons.add),
      ),
    );
  }

  void _getTodolist() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = await localStorage.get('email');
    emailFix = email.toString().replaceAll('"', '');
    var data = {'email': emailFix};
    var res = await Network().auth(data, '/getTodolist');
    var body = jsonDecode(res.body);

    setState(() {
      todolists.clear();
      body['todolists'].forEach((todolist) {
        bool flag;
        if (todolist['status'] == 1) {
          flag = true;
        } else {
          flag = false;
        }

        todolists.add(Todolist(
          id: todolist['id'],
          email: todolist['email'],
          todo: todolist['todo'],
          tanggal: DateTime.parse(todolist['tanggal']),
          status: flag,
        ));
      });
    });
  }

  void _delete(id) async {
    var data = {'id': id};

    var res = await Network().auth(data, '/deleteTodolist');

    var body = jsonDecode(res.body);
  }

  void _editStatusTodolist(id, status) async {
    var data = {'id': id, 'status': status};

    var res = await Network().auth(data, '/editStatusTodolist');

    var body = jsonDecode(res.body);
  }
}
