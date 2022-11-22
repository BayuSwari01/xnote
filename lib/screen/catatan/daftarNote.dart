import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/screen/catatan/catatan.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';
import 'package:x_note/screen/catatan/editCatatan.dart';

class daftarNote extends StatefulWidget {
  const daftarNote({super.key});

  @override
  State<daftarNote> createState() => _daftarNoteState();
}

class _daftarNoteState extends State<daftarNote> {
  List<String> judul = [
    "Catetan tugas",
    "Catetan kerjaan",
    "Catetan kuliah",
    "Catetan belanja",
    "Catetan",
    "Catetan belanja",
    "Catetan"
  ];
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
                  7,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return catatan();
                          }));
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
                                  judul[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  "isi dari catatan askldj asdjkasjdas alskdjasd asldkasjd asdlkasjd asdlkasjdsa dasldkjas lkasjd asdlksa asdoasdjas,m asldljas asdl;ajsd ",
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahCatatan();
          }));
        },
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        child: Icon(Icons.add),
      ),
    );
  }
}
