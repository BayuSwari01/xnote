import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/home.dart';

class daftar extends StatefulWidget {
  const daftar({super.key});

  @override
  State<daftar> createState() => _daftarState();
}

class _daftarState extends State<daftar> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  bool _secureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 120, 120),
        title: Center(child: Text("Daftar")),
      ),
      body: Container(
        color: Color.fromARGB(255, 217, 217, 217),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                    labelText: "Name",
                  ),
                  controller: name,
                ),
              ),
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
                    labelText: "Email",
                  ),
                  controller: email,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
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
                    labelText: "Password",
                  ),
                  controller: password,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                width: double.infinity,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                    onPressed: () {
                      _register();
                    },
                    child: Text("Daftar"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': name.text,
      'email': email.text,
      'password': password.text,
    };

    var res = await Network().auth(data, '/register');
    var body = jsonDecode(res.body);

    if (body['status']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', jsonEncode(body['token']));
      localStorage.setString('email', jsonEncode(body['email']));
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
    } else {
      if (body['message']['name'] != null) {
        _showMsg(body['message']['name'][0].toString());
      } else if (body['message']['email'] != null) {
        _showMsg(body['message']['email'][0].toString());
      } else if (body['message']['password'] != null) {
        _showMsg(body['message']['password'][0].toString());
      }
    }
  }

  _showMsg(message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.toString()),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
}
