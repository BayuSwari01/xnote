import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:x_note/models/TimeOfDayCOnverter.dart';
import 'package:x_note/models/Todolist.dart';
import 'package:x_note/network/api.dart';

class editTodoList extends StatefulWidget {
  const editTodoList({
    super.key,
    this.todo,
  });
  final Todolist? todo;

  @override
  State<editTodoList> createState() => _editTodoListState();
}

class _editTodoListState extends State<editTodoList> {
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController todo = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();
  Todolist? dataTodo;
  int? hour, minute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataTodo = widget.todo;
    todo.text = dataTodo?.todo ?? '';
    final yearMonth = dataTodo?.tanggal.toString().split('-');
    final day = yearMonth![2].split(' ');
    final hourMinute = day[1].split(':');
    hour = int.parse(hourMinute[0]);
    minute = int.parse(hourMinute[1]);
    tanggal.text = yearMonth[1] + '/' + day[0] + '/' + yearMonth[0];
    jam.text = hourMinute[0] + ':' + hourMinute[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Center(child: Text("Edit Todo List")),
      ),
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 120, 120, 120),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    labelText: "Todo",
                  ),
                  controller: todo,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 120, 120, 120),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    labelText: "Tanggal",
                  ),
                  readOnly: true,
                  controller: tanggal,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: dataTodo?.tanggal ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat.yMd().format(pickedDate);

                      setState(() {
                        tanggal.text = formattedDate;
                      });
                    } else {
                      setState(() {
                        tanggal.text = "Tanggal belum dipilih";
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 120, 120, 120),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    labelText: "Jam",
                  ),
                  readOnly: true,
                  controller: jam,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay(hour: hour ?? 00, minute: minute ?? 00),
                    );
                    if (pickedTime != null) {
                      String formattedTime = pickedTime.to24hours();

                      setState(() {
                        jam.text = formattedTime;
                      });
                    } else {
                      setState(() {
                        jam.text = "Jam belum dipilih";
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                  onPressed: () {
                    _editTodolist();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _editTodolist() async {
    final ymd = tanggal.text.split('/');
    String tanggalJam =
        ymd[2] + '-' + ymd[0] + '-' + ymd[1] + ' ' + jam.text + ':00';

    var data = {
      'id': dataTodo?.id,
      'todo': todo.text,
      'tanggal': tanggalJam,
    };

    var res = await Network().auth(data, '/editTodolist');

    var body = jsonDecode(res.body);
  }
}
