import 'dart:developer';

import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';

import '../../../../core/di/di.dart';
import '../manager/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginController _loginController = getIt();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> obscurePass = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  "assets/logo_cropped.png",
                  height: 90,
                  fit: BoxFit.cover,
                 ),
                  // SvgPicture.asset(
                //   "assets/icons/logo.svg",
                //   height: 90,
                //   fit: BoxFit.cover,
                // ),
                const SizedBox(height: 60),
                Text(
                  "login".tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "username".tr,
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: obscurePass,
                    builder: (context, val, _) {

                      return TextField(
                        controller: passwordController,
                        obscureText: val,
                        decoration: InputDecoration(
                          hintText: "password".tr,
                          suffixIcon: InkWell(
                            onTap: () {
                              obscurePass.value = !obscurePass.value;
                            },
                            child: Icon(
                              val ? Icons.visibility : Icons.visibility_off,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                          ),
                        ).applyDefaults(Theme.of(context).inputDecorationTheme),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.resetPassword);
                      },
                      child: Text(
                        "forgot_password".tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      return value
                          ? Center(child: getLoader())
                          : ElevatedButton(
                            onPressed: () async {
                              if (passwordController.text.isNotEmpty &&
                                  usernameController.text.isNotEmpty) {
                                try {
                                  isLoading.value = true;
                                  await _loginController.signIn(
                                    usernameController.text,
                                    passwordController.text,
                                  );
                                  Get.toNamed(AppRoutes.mainScreen);
                                } catch (e, s) {
                                  log("$e $s");
                                  handleException(context, e);
                                  // showErrorDialog(context, e.toString().replaceRange(0, "Exception: ".length,""));
                                }

                                isLoading.value = false;
                              }
                            },
                            child: Text("login".tr),
                          );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                    style: AppTheme.outlinedButtonStyle,
                    child: Text("create_account".tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
