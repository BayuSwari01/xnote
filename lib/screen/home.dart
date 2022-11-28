import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/catatan/daftarNote.dart';
import 'package:x_note/screen/login.dart';
import 'package:x_note/screen/todoList/daftarTodoList.dart';

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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Image(
                  image: AssetImage("images/logo2.png"),
                  width: 300,
                  height: 300,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return daftarNote();
                        }));
                      },
                      child: Text(
                        "Note",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                      onPressed: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return daftarTodoList();
                          }));
                        });
                      },
                      child: Text(
                        'Todo list',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        _logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return login();
                        }));
                      },
                      child: Text(
                        'Log Out',
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

  void _logout() async {
    var data;
    var res = await Network().getData(data, '/logout');
    var body = await jsonDecode(res.body);

    if (body['status']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('email');
      localStorage.remove('token');
    }
  }
}
