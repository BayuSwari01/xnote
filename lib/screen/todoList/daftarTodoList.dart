import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x_note/screen/catatan/tambahCatatan.dart';
import 'package:x_note/screen/todoList/editTodoList.dart';
import 'package:x_note/screen/todoList/tambahTodoList.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class daftarTodoList extends StatefulWidget {
  const daftarTodoList({super.key});

  @override
  State<daftarTodoList> createState() => _daftarTodoListState();
}

class _daftarTodoListState extends State<daftarTodoList> {
  bool isSelected = false;
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
                20,
                (index) => DataRow(
                  selected: isSelected,
                  onSelectChanged: (value) {
                    showAdaptiveActionSheet(
                      context: context,
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                          title: Icon(
                            Icons.done,
                            size: 20,
                          ),
                          onPressed: (context) async {
                            this.isSelected = true;
                            Navigator.pop(context);
                            setState(() {});
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
                              return editTodoList();
                            }));
                          },
                        ),
                        BottomSheetAction(
                          title: Icon(
                            Icons.delete,
                            size: 20,
                          ),
                          onPressed: (context) async {
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
                              "Mengerjakan Tugas",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text("Tanggal 19 Oktober 2022"),
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahTodoList();
          }));
        },
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        child: Icon(Icons.add),
      ),
    );
  }
}
