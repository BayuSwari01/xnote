import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/screen/catatan/editCatatan.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';

class catatan extends StatefulWidget {
  const catatan({super.key});

  @override
  State<catatan> createState() => _catatanState();
}

class _catatanState extends State<catatan> {
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
                          "Judul",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 30),
                        child: Text(
                            "Isi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk awIsi dari catetan awlaejwk awliawe awiakw paw awlk awpk awpk   awpiaw awpaw awpawkaw paw  awpikaw\nawloawkaw awpaw awlawk aw"),
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
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return editCatatan();
                          }));
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
                        Navigator.pop(context);
                      },
                      child: Text("Hapus"),
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
}
