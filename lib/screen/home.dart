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
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        child: Center(
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
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        "Note",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        'Todo list',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
