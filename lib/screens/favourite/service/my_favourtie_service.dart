import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:borsa_now_bis/screens/favourite/models/favourite_model.dart';
import 'package:dio/dio.dart';

import '../../../core/config/utils.dart';
import '../../../core/exception/api_exception.dart';

class MyFavouriteService {

  final Dio _dio;

  MyFavouriteService( this._dio);



  Future<List<FavouriteModel>> getMyFavourites ()async{
    final AppServices appServices = getIt();
    try {
      final response = await _dio.get("/api/v1/customer/retail/list/favorites/${getLang()}",queryParameters: {
        "token":appServices.getToken()
      });

      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      List<FavouriteModel> favs = favouriteModelFromJson(jsonEncode(response.data['data']['data']));
      myFavourites = favs.map((e)=>e.id).toList();
      return favs;
    } catch (e, s) {

      log("$e , $s");
      throw e;
    }

  }
}