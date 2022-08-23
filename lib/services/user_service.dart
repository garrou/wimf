import 'dart:convert';

import 'package:wimf/main.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/interceptor.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class UserService {
  final Client client = InterceptedClient.build(
    interceptors: [
      HttpInterceptor(),
    ],
  );

  Future<HttpResponse> getUser() async {
    final Response response = await client.get(Uri.parse('$endpoint/user'));
    return HttpResponse(response);
  }

  Future<HttpResponse> updateUsername(String username) async {
    final Response response = await client.patch(
      Uri.parse('$endpoint/user/username'),
      body: jsonEncode(
        <String, String>{'username': username},
      ),
    );
    return HttpResponse(response);
  }

  Future<HttpResponse> updatePassword(
      String current, String password, String confirm) async {
    final Response response = await client.patch(
      Uri.parse('$endpoint/user/password'),
      body: jsonEncode(
        <String, String>{
          'current': current,
          'password': password,
          'confirm': confirm,
        },
      ),
    );
    return HttpResponse(response);
  }
}
