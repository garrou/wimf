import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/interceptor.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:wimf/utils/constant.dart';

class CategoryService {
  final Client client = InterceptedClient.build(
    interceptors: [
      HttpInterceptor(),
    ],
  );

  Future<HttpResponse> getAll() async {
    final Response response =
        await client.get(Uri.parse('$endpoint/categories/'));
    return HttpResponse(response);
  }
}
