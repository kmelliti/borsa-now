import 'package:borsa_now_bis/screens/cart/pages/cart_page.dart';
import 'package:borsa_now_bis/screens/login/presentation/pages/login_page.dart';
import 'package:borsa_now_bis/screens/main_screen/presentation/pages/main_screen.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/widgets/address.dart';
import 'package:borsa_now_bis/screens/my_orders/pages/my_orders.dart';
import 'package:borsa_now_bis/screens/sign_up/presentation/pages/sign_up.dart';
import 'package:borsa_now_bis/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../../reset_password/pages/reset_password.dart';
import '../../screens/my_account/presentation/widgets/bank_info.dart';
import '../../screens/my_account/presentation/widgets/password_page.dart';
import '../../screens/my_account/presentation/widgets/personal_identity.dart';
import '../../screens/my_account/presentation/widgets/personal_info.dart';

class AppRoutes {
  static const String splash = '/';
  static const String mainScreen = '/main';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  static const String login = '/login';
  static const String personalInfo = '/personal_info';
  static const String address = '/address';
  static const String personalIdentity = '/personalIdentity';
  static const String bankInfo = '/bankInfo';
  static const String password = '/password';
  static const String cart = '/cart';
  static const String myOrders = '/my_orders';

  static final routes = [
    GetPage(name: login, page: () =>  LoginPage()),
    GetPage(name: splash, page: () =>  SplashScreen()),
    GetPage(name: mainScreen, page: () =>  MainScreen()),
    GetPage(name: signUp, page: () =>  SignUp()),
    GetPage(name: resetPassword, page: () =>  ResetPassword()),
    GetPage(name: personalInfo, page: () =>  PersonalInfo()),
    GetPage(name: address, page: () =>  Address()),
    GetPage(name: personalIdentity, page: () =>  PersonalIdentity()),
    GetPage(name: bankInfo, page: () =>  BankInfo()),
    GetPage(name: password, page: () =>  PasswordPage()),
    GetPage(name: cart, page: () =>  CartPage()),
    GetPage(name: myOrders, page: () =>  MyOrders()),
  ];
}
