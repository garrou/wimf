import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/interceptor.dart';
import 'package:wimf/utils/constant.dart';

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
}
