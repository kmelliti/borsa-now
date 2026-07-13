import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/models/order_detail_model.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:dio/dio.dart';

import '../config/utils.dart';
import '../di/di.dart';
import '../exception/api_exception.dart';
import '../models/my_order_model.dart';

class MyOrderServices {
  final Dio _dio;

  MyOrderServices(this._dio);

  Future<List<MyOrderModel>> getMyOrders(int page, String status) async {
    try {
      final response = await _dio.get(
        "/api/v1/customer/orders/${getLang()}?page=${page}",
        queryParameters: {
          "status":status
        }
      );


      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      return myOrderModelFromJson(jsonEncode(response.data['data']['data']));
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<OrderDetailModel> getOrderDetail(int orderId) async {
    AppServices _services = getIt();
    try {
      final response = await _dio.get(
          "/api/v1/customer/order/$orderId/${getLang()}",
          queryParameters: {
            "token":_services.getToken()
          }
      );

     // print("responseresponse : ${response.data}");

      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      return OrderDetailModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<void> reOrder(int orderId) async {
    AppServices _services = getIt();
    try {
      final response = await _dio.post(
          "/api/v1/customer/order/duplicate/${getLang()}",
          data: {
            "order_id":orderId
          }
      );

      //print("responseresponse : ${response.data}");

      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
   //   return OrderDetailModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
  Future<Map> getDashboard(int month,int year) async {

    try {
      final response = await _dio.get(
          "/api/v1/customer/orders/dashboard/${getLang()}",
          queryParameters: {
            "month":month,
            "year":year
          }
      );

     // print("responseresponse : ${response.data}");

      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
         return response.data['data'];
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
}
