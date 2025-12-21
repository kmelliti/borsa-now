import 'package:borsa_now_bis/core/config/dio_inizializer.dart';
import 'package:borsa_now_bis/core/services/auth_services.dart';
import 'package:borsa_now_bis/core/services/home_page_service.dart';
import 'package:borsa_now_bis/core/services/my_account_services.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/manager/my_account_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/favourite/controller/favourite_controller.dart';
import '../../screens/favourite/service/my_favourtie_service.dart';
import '../../screens/home_page/presentation/manager/home_page_controller.dart';
import '../../screens/login/presentation/manager/login_controller.dart';
import '../../screens/sign_up/presentation/controller/sign_up_controller.dart';
import '../services/app_service.dart';


final getIt = GetIt.instance;

Future<void> setup() async {
  assert(!getIt.isRegistered<SharedPreferences>(), 'Service locator already initialized');


  // Initialize SharedPreferences asynchronously
  final sharedPrefs = await SharedPreferences.getInstance();

  // Register it as a singleton
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  await getIt.allReady();

  getIt.registerLazySingleton(()=> DioInitializer.getDio());
  getIt.registerLazySingleton(()=>AuthService(getIt()));
  getIt.registerLazySingleton(()=>SignUpController(getIt()));
  getIt.registerLazySingleton(()=>LoginController(getIt()));

  getIt.registerLazySingleton(()=>AppServices(getIt(),getIt()));
  getIt.registerLazySingleton(()=>HomePageService(getIt()));
  getIt.registerLazySingleton(()=>HomePageController(getIt()));
  getIt.registerLazySingleton(()=>MyAccountServices(getIt(),getIt()));
  getIt.registerLazySingleton(()=>MyAccountController(getIt()));
  getIt.registerLazySingleton(()=>MyFavouriteService(getIt()));
  getIt.registerLazySingleton(()=>FavouriteController(getIt()));

}