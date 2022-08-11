import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/interceptor.dart';

class FoodService {
  final Client client = InterceptedClient.build(
    interceptors: [
      HttpInterceptor(),
    ],
  );
}
