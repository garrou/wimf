import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/utils/constant.dart';

class AuthService {
  Future<HttpResponse> login(String username, String password) async {
    final Response response = await http.post(
      Uri.parse('$endpoint/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    return HttpResponse(response);
  }

  Future<HttpResponse> register(
      String username, String password, String confirm) async {
    final Response response = await http.post(
      Uri.parse('$endpoint/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'confirm': confirm
      }),
    );
    return HttpResponse(response);
  }
}
