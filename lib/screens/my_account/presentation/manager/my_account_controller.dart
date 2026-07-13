import 'package:borsa_now_bis/core/services/my_account_services.dart';

import '../../../../core/models/user_model.dart';

class MyAccountController {

  final MyAccountServices _myAccountServices;
  MyAccountController(this._myAccountServices);
  Future<UserModel> updatePersonalInfo(String? image ,Map<String,dynamic> params) async {
    return _myAccountServices.updatePersonalInfo(image, params);
  }
  Future<UserModel> updateAddress(Map<String, dynamic> params) async {
    return await _myAccountServices.updateAddress(params);
  }
  Future<UserModel> updateId(String? doc, String number) async {
    return await _myAccountServices.updateId(doc, number);
  }
  Future<UserModel> updateBank(Map<String, dynamic> params) async {
    return _myAccountServices.updateBank(params);
  }
  Future<void> updatePassword(Map<String, dynamic> params) async {
    return _myAccountServices.updatePassword(params);
  }
  Future<UserModel> updatePersonalInformation(Map<String, dynamic> params) async {
    return _myAccountServices.updatePersonalInformation( params);
  }

}