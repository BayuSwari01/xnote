import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = '/api';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    //localStorage.getString('token') dikasih tanda seru supaya tetep dijalanin meskipun null
    token = jsonDecode(localStorage.getString('token')!);
  }

  auth(data, apiURL) async {
    var fullUrl = await Uri.http('127.0.0.1:8000', _url + apiURL);

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getData(data, apiURL) async {
    var fullUrl = Uri.http('127.0.0.1:8000', _url + apiURL);
    await _getToken();
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
