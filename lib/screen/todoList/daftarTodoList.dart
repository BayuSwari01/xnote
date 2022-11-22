import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';

class daftarTodoList extends StatefulWidget {
  const daftarTodoList({super.key});

  @override
  State<daftarTodoList> createState() => _daftarTodoListState();
}

class _daftarTodoListState extends State<daftarTodoList> {
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
              showCheckboxColumn: true,
              columns: [DataColumn(label: Text("Todo List"))],
              rows: List<DataRow>.generate(
                  3,
                  (index) => DataRow(cells: [
                        DataCell(
                          Text("Mengerjakan Tugas"),
                        )
                      ])),
            ),
          ],
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
