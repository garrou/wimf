import 'dart:async';

import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/user_service.dart';
import 'package:wimf/utils/storage.dart';

class Guard {
  static checkAuth(StreamController<bool> streamController) async {
    try {
      HttpResponse response = await UserService().getUser();
      streamController.add(response.success());
    } on Exception catch (_) {
      String token = await Storage.getToken();
      streamController.add(token.isNotEmpty);
    }
  }
}
