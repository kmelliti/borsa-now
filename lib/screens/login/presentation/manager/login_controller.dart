import 'package:borsa_now_bis/core/services/auth_services.dart';

class LoginController  {


  final AuthService _authService;

  LoginController(this._authService);
  String? code;

  Map<String, dynamic>? params;

  Future<void> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }




  Future<void> resetPassword (Map<String,dynamic> params) async{
    return _authService.resetPassword(params);
  }

  Future<String> sendCodeResetPassword (Map<String,dynamic> params) async{
    return _authService.sendCodeResetPassword(params);
  }
}