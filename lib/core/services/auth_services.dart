import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/exception/api_exception.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:dio/dio.dart';

import '../../screens/sign_up/model/account_creation_params.dart';
import '../models/user_model.dart';

class AuthService{

  final Dio _dio;
  AuthService(this._dio);
  final AppServices appServices = getIt();

  Future<void> signUp(AccountCreationParams accountCreationParams) async {
    try {

      log(accountCreationParams.toJson().toString());
      FormData formData = FormData.fromMap(accountCreationParams.toJson());

      if(accountCreationParams.picture != null) {
        formData.files.add(MapEntry("picture", await MultipartFile.fromFile(accountCreationParams.picture!)));
      }

      final response = await _dio.post(
        'BorsaNow/public/api/v1/customer/register/${getLang()}',
        data: formData,
      );
      print("Data ${response.data} ");
      if(response.data["result"] == false){
        throw ApiException(response.data["message"]);
      }

      return response.data;
    } catch (e) {

      throw e;
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        'BorsaNow/public/api/v1/customer/login/${getLang()}',
        data: FormData.fromMap({
          "email": email,
          "password": password,
        }),
      );
      print("Data ${response.data} ");
      if(response.data["result"] == false){
        throw Exception(response.data["message"]);
      }

      appServices.setToken(response.data["token"]);
      log("Prentable token ${appServices.getToken()}");


      return await getUser();
    } catch (e,s) {

      log("$s");
      throw e;
    }
  }


  Future<UserModel> getUser() async {
    try {
      final response = await _dio.get(
        'BorsaNow/public/api/v1/customer/${getLang()}',
        queryParameters: {
          "token":appServices.getToken()
        }
      );
      print("Data ${response.data} ");
      if(response.data["result"] == false){
        throw Exception();
      }

      appServices.setUser(userModelFromJson(jsonEncode(response.data['data'])));
      return userModelFromJson(jsonEncode(response.data['data']));
    } catch (e,s) {
      log("$s");
      throw e;
    }
  }


  Future<void> signOut() async {
    try {
      final response = await _dio.get(
        'BorsaNow/public/api/v1/investor/logout/${getLang()}',
      );
      print("Data ${response.data} ");
      if(response.data["result"] == false){
        throw Exception();
      }

     appServices.removeUserAndToken();
    } catch (e) {

      throw e;
    }
  }
}