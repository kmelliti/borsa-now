
import 'package:get/get.dart';
import 'package:starter/login/presentation/pages/login_page.dart';
import 'package:starter/screens/sign_up/presentation/pages/sign_up.dart';

import '../../screens/main_screen/pages/main_screen.dart';
import '../../screens/reset_password/pages/reset_password.dart';
import '../../splash_screen/splash_screen.dart';



class AppRoutes {
  static const String splash = '/';
  static const String mainScreen = '/main';
  static const String signUp = '/sign-up';
  static const String login = '/login';
  static const String editCompanyInfo = '/edit_company_info';
  static const String products = '/products';
  static const String addProduct = '/new_products';
  static const String dealDetails = '/deal_details';
  static const String editPersonalInfo = '/edit_person_info';
  static const String bankList = '/bank_list';
  static const String contacts = '/contacts';
  static const String resetPassword = '/reset_password';
  static const String locations = '/locations';
  static const String productDetails = '/productDetails';


  static final routes = [
    GetPage(name: login, page: () =>  LoginPage()),
    GetPage(name: splash, page: () =>  SplashScreen()),
     GetPage(name: mainScreen, page: () =>  MainScreen()),
    GetPage(name: signUp, page: () =>  SignUp()),
    GetPage(name: resetPassword, page: () =>  ResetPassword()),

  ];
}
