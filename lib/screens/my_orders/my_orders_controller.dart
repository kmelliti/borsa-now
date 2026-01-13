import 'package:borsa_now_bis/core/services/my_orders_services.dart';

import '../../core/models/my_order_model.dart';
import '../../core/models/order_detail_model.dart';

class MyOrdersController {


  final MyOrderServices _services;

  MyOrdersController(this._services);

  Future<List<MyOrderModel>> getMyOrders(int page, String status) async {
    return _services.getMyOrders(page, status);
  }
  Future<OrderDetailModel> getOrderDetail(int orderId) async {
    return _services.getOrderDetail(orderId);
  }
  Future<void> reOrder(int orderId) async {
    return _services.reOrder(orderId);
  }
  Future<Map> getDashboard(int month,int year) async {
    return _services.getDashboard(month, year);
  }





}