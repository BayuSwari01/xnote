import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:x_note/models/TimeOfDayCOnverter.dart';
import 'package:x_note/network/api.dart';

class tambahTodoList extends StatefulWidget {
  const tambahTodoList({super.key, this.email});
  final String? email;

  @override
  State<tambahTodoList> createState() => _tambahTodoListState();
}

class _tambahTodoListState extends State<tambahTodoList> {
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController todo = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    tanggal.text = "";
    super.initState();
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Center(child: Text("Tambah Todo List")),
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
                        initialDate: DateTime.now(),
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
                      initialTime: selectedTime,
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
                    if (tanggal.text == '' ||
                        jam.text == '' ||
                        tanggal.text == 'Tanggal belum dipilih' ||
                        jam.text == 'Jam belum dipilih') {
                      _showMsg('Harap lengkapi tanggal dan jam dengan benar!');
                    } else {
                      _addTodolist();
                      Navigator.pop(context);
                    }
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

  void _addTodolist() async {
    final ymd = tanggal.text.split('/');
    String tanggalJam =
        ymd[2] + '-' + ymd[0] + '-' + ymd[1] + ' ' + jam.text + ':00';

    var data = {
      'email': email,
      'todo': todo.text,
      'tanggal': tanggalJam,
      'status': 0,
    };

    var res = await Network().auth(data, '/addTodolist');

    var body = jsonDecode(res.body);
  }

  _showMsg(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
