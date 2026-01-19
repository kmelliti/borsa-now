import 'dart:developer';

import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:borsa_now_bis/core/di/di.dart';

import '../core/services/app_service.dart';
import '../screens/home_page/presentation/manager/home_page_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppServices appServices = getIt();
  final HomePageController _controller = getIt();

  @override
  void initState() {

    super.initState();
    try {
      // appServices.getCities();
      // appServices.getBanks();
    } catch (e, s) {
      log("$e , $s");
    }

    _controller.fetchCartProducts();
    log("Prentable token ${appServices.getToken()}");

    bool isLoggedIn = appServices.getToken() != null;
    Future.delayed(Duration(seconds: 4), () {
      if (isLoggedIn) {
        WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.mainScreen);
        });
      } else {
        WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.login);
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/0484aab0c5a24014f17a6bf62f729f73711ad0ed.gif",
          height: 500,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//git@github.com-giga:kmelliti/starter.git
