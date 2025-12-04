import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/config/dio_inizializer.dart';
import 'package:starter/core/services/app_service.dart';

import '../../screens/main_screen/controller/main_screen_controller.dart';
import '../../screens/reset_password/controller/reset_password_controller.dart';
import '../../screens/sign_up/presentation/controller/sign_up_controller.dart';
import '../services/auth_services.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  assert(!getIt.isRegistered<SharedPreferences>(), 'Service locator already initialized');


  // Initialize SharedPreferences asynchronously
  final sharedPrefs = await SharedPreferences.getInstance();

  // Register it as a singleton
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  await getIt.allReady();

  getIt.registerLazySingleton(()=> DioInitializer.getDio());
  getIt.registerLazySingleton(()=> AppServices(getIt(), getIt()));
  getIt.registerLazySingleton(()=> AuthService(getIt()));

  getIt.registerLazySingleton(()=> SignUpController(getIt()));
  getIt.registerLazySingleton(()=> MainScreenController());

  getIt.registerLazySingleton(()=> ResetPasswordController(getIt()));


}