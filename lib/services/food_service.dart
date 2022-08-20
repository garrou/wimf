import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:wimf/main.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/interceptor.dart';

class FoodService {
  final Client client = InterceptedClient.build(
    interceptors: [
      HttpInterceptor(),
    ],
  );

  Future<HttpResponse> create(Food food) async {
    final Response response = await client.post(Uri.parse('$endpoint/foods/'),
        body: jsonEncode(food));
    return HttpResponse(response);
  }
}
