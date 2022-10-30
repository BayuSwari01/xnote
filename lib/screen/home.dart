import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 70),
              child: Text(
                "X Note",
                style: TextStyle(fontSize: 70),
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: null, child: Text("Note"))),
            Container(
                margin: EdgeInsets.all(20),
                child:
                    ElevatedButton(onPressed: null, child: Text('Todo list'))),
          ],
        ),
      ),
    );
  }
}
