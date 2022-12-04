import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_note/models/Note.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/catatan/catatan.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';
import 'package:x_note/screen/catatan/editCatatan.dart';

class daftarNote extends StatefulWidget {
  const daftarNote({super.key});

  @override
  State<daftarNote> createState() => _daftarNoteState();
}

class _daftarNoteState extends State<daftarNote> {
  List<Note> notes = [];
  String? emailFix;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Center(child: Text("Daftar Note")),
      ),
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Wrap(
              children: List<GestureDetector>.generate(
                  notes.length,
                  (index) => GestureDetector(
                        onTap: () async {
                          // _getNote();
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return catatan(note: notes[index]);
                          }));
                          setState(() {
                            _getNote();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 120, 120, 120),
                          ),
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 140,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  notes[index].judul ?? "404",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  notes[index].catatan ?? "404",
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahCatatan(
              email: emailFix,
            );
          }));
          setState(() {
            _getNote();
          });
        },
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        child: Icon(Icons.add),
      ),
    );
  }

  void _getNote() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = await localStorage.get('email');
    emailFix = email.toString().replaceAll('"', '');
    var data = {'email': email.toString().replaceAll('"', '')};
    var res = await Network().auth(data, '/getNote');
    var body = jsonDecode(res.body);
    setState(() {
      notes.clear();
      body['notes'].forEach((note) {
        notes.add(Note(
          id: note['id'],
          email: note['email'],
          judul: note['judul'],
          catatan: note['catatan'],
        ));
      });
    });
  }
}
