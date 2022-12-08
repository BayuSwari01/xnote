import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/models/Note.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/catatan/daftarNote.dart';

class editCatatan extends StatefulWidget {
  const editCatatan({super.key, this.note});
  final Note? note;

  @override
  State<editCatatan> createState() => _editCatatanState();
}

class _editCatatanState extends State<editCatatan> {
  Note? note;
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    judul.text = note?.judul ?? '';
    isi.text = note?.catatan ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Center(child: Text("Edit Catatan")),
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
                    labelText: "Judul",
                  ),
                  controller: judul,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  maxLines: 5,
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
                    labelText: "Isi",
                  ),
                  controller: isi,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 120, 120, 120),
                    ),
                    onPressed: () {
                      _editNote();
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.add)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _editNote() async {
    var data = {'id': note?.id, 'judul': judul.text, 'catatan': isi.text};
    var res = await Network().auth(data, '/editNote');
    var body = jsonDecode(res.body);
  }
}
