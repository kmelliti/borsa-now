import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:dio/dio.dart';

import '../exception/api_exception.dart';
import '../models/user_model.dart';

class MyAccountServices {
  final Dio _dio;
  final AppServices appServices ;

  MyAccountServices(this._dio, this.appServices);

  Future<UserModel> updatePersonalInfo(
    String? image,
    Map<String, dynamic> params,
  ) async {
    try {
      FormData formData = FormData.fromMap(params);
      if (image != null) {
        formData.files.add(
          MapEntry("picture", await MultipartFile.fromFile(image)),
        );
      }
      final response = await _dio.post(
        "BorsaNow/public/api/v1/investor/information/update/${getLang()}",
        data: formData,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      UserModel userModel = UserModel.fromJson(response.data['data']);
      appServices.setUser(userModel);
      return userModel ;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> updateAddress(Map<String, dynamic> params) async {
    try {
      final response = await _dio.put(
        "BorsaNow/public/api/v1/investor/address/update/${getLang()}",
        data: params,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      // Investor investor = Investor.fromJson(response.data['data']);
       UserModel userModel = appServices.getUser();
      // userModel.investor = investor;
      // appServices.setUser(userModel);
      return userModel ;
    } catch (e) {
      throw e;
    }
  }
  Future<UserModel> updateId(String? doc, String number) async {
    try {
      FormData formData = FormData.fromMap({
        "id_number": number,
      });
      if (doc != null) {
        formData.files.add(
          MapEntry("id_document_path", await MultipartFile.fromFile(doc)),
        );
      }
      final response = await _dio.post(
        "BorsaNow/public/api/v1/investor/identification/update/${getLang()}",
        data: formData,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
    //  Investor investor = Investor.fromJson(response.data['data']);
      UserModel userModel = appServices.getUser();
     // userModel.investor = investor;
      appServices.setUser(userModel);
      return userModel ;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> updateBank(Map<String, dynamic> params) async {
    try {
      final response = await _dio.post(
        "BorsaNow/public/api/v1/investor/bank/update/${getLang()}",
        data: params,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      //Investor investor = Investor.fromJson(response.data['data']);
      UserModel userModel = appServices.getUser();
    //  userModel.investor = investor;
      appServices.setUser(userModel);
      return userModel ;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updatePassword(Map<String, dynamic> params) async {
    try {
      final response = await _dio.put(
        "BorsaNow/public/api/v1/investor/password/change/${getLang()}",
        data: params,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }

    } catch (e) {
      throw e;
    }
  }
  Future<void> updatePersonalInformation(Map<String, dynamic> params) async {
    try {
      final response = await _dio.put(
        "/BorsaNow/public/api/v1/customer/information/update/${getLang()}",
        data: params,
      );
      print("Data ${response.data} ");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }

    } catch (e,s) {
      print("ERrror $e ,$s");
      throw e;
    }
  }
}
