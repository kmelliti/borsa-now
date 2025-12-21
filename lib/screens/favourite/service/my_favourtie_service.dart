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
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/deal/list/favorites/${getLang()}",queryParameters: {
        "token":appServices.getToken()
      });
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }

      return favouriteModelFromJson(jsonEncode(response.data['data']['data']));
    } catch (e, s) {

      log("$e , $s");
      throw e;
    }

  }
}