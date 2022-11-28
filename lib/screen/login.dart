import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_note/network/api.dart';
import 'package:x_note/screen/daftar.dart';
import 'package:x_note/screen/home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isloading = false;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Color.fromARGB(255, 217, 217, 217),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Image(
                image: AssetImage("images/logo2.png"),
                width: 250,
                height: 250,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
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
                    labelText: "email",
                  ),
                  controller: email,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
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
                  obscureText: _secureText,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 45,
                  width: 150,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 120, 120, 120)),
                      onPressed: () {
                        _login();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return home();
                        // }));
                      },
                      child: Text(_isloading ? "Processing..." : "Login")),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return daftar();
                      }),
                    );
                  },
                  child: Text(
                    "Daftar",
                    style: TextStyle(color: Color.fromARGB(255, 20, 124, 209)),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isloading = true;
    });

    var data = {'email': email.text, 'password': password.text};

    var res = await Network().auth(data, '/login');
    var body = jsonDecode(res.body);

    if (body['status']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString('token', jsonEncode(body['token']));
      await localStorage.setString('email', jsonEncode(body['email']));

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return home();
      }));
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isloading = false;
    });
  }

  _showMsg(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg),
            content: const Text('email atau password salah'),
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
        });
  }
}
