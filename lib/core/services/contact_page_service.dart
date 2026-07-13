import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/exception/api_exception.dart';
import 'package:dio/dio.dart';

class ContactPageService {

  final Dio _dio;
  ContactPageService(this._dio);

  Future contactUs(String object, String body) async {

    try {

      final response = await _dio.post("/api/v1/customer/contact/${getLang()}",data: {
        "subject": object,
        "message": body,
      });


      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }


      return true;

    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

}