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

  Future<HttpResponse> getAll() async {
    final Response response = await client.get(Uri.parse('$endpoint/foods/'));
    return HttpResponse(response);
  }

  Future<HttpResponse> create(Food food) async {
    final Response response = await client.post(
      Uri.parse('$endpoint/foods/'),
      body: jsonEncode(food),
    );
    return HttpResponse(response);
  }

  Future<HttpResponse> update(Food food) async {
    final Response response = await client.put(
      Uri.parse('$endpoint/foods/${food.id}'),
      body: jsonEncode(food),
    );
    return HttpResponse(response);
  }

  Future<HttpResponse> getByCategory(int id) async {
    final Response response = await client.get(
      Uri.parse('$endpoint/categories/$id/foods'),
    );
    return HttpResponse(response);
  }

  Future<List<Food>> search(String query) async {
    final Response res = await client.get(
      Uri.parse('$endpoint/foods/search?q=$query'),
    );
    final response = HttpResponse(res);
    return createFoods(response.content());
  }

  Future<HttpResponse> delete(int id) async {
    final Response response = await client.delete(
      Uri.parse('$endpoint/foods/$id'),
    );
    return HttpResponse(response);
  }
}
