import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/models/Note.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/catatan/editCatatan.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';

class catatan extends StatefulWidget {
  const catatan({super.key, this.note});
  final Note? note;

  @override
  State<catatan> createState() => _catatanState();
}

class _catatanState extends State<catatan> {
  Note? note;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Text("Catatan"),
      ),
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 120, 120, 120),
                ),
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          note?.judul ?? "404",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 30),
                        child: Text(note?.catatan ?? "404"),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 120, 120, 120)),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return editCatatan(
                              note: note,
                            );
                          }));
                          Navigator.pop(context);
                        },
                        child: Text("Edit"),
                      )),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(120, 120, 120, 1)),
                      onPressed: () {
                        _hapusNote();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Hapus",
                        style:
                            TextStyle(color: Color.fromARGB(206, 241, 75, 63)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _hapusNote() async {
    var data = {'id': note?.id};
    var res = await Network().auth(data, '/deleteNote');
    var body = jsonDecode(res.body);
  }
}
