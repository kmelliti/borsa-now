import 'dart:developer';
import 'dart:ui';

import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/core/services/auth_services.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../di/di.dart';
import '../exception/api_exception.dart';
import '../models/lookup_model.dart';
import '../theme/app_theme.dart';
import 'app_constants.dart';

String displayStringForOption(LookUpModel lookup) => lookup.name;

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

void handleException(BuildContext context, Object e) {
  if (e is ApiException) {
    showErrorDialog(context, e.message);
  } else {
    showErrorDialog(context, null);
  }
}

Widget getDiscountedPriceInText(double price) {
  return Stack(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            price.toStringAsFixed(2),

            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(AppTheme.borderGrey),
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(width: 5),
          SvgPicture.asset(
            "assets/icons/sar.svg",
            width: 20,
            color: HexColor.fromHex(AppTheme.borderGrey),
          ),
        ],
      ),
      Positioned.fill(
        child: Center(
          child: Container(
            color: HexColor.fromHex(AppTheme.primaryColor),
            height: 1,
          ),
        ),
      ),
    ],
  );
}

Future<Color> getDominantColor(String url) async {
  ColorScheme scheme = await ColorScheme.fromImageProvider(
    provider: Image.network(url).image,
  );
  return scheme.primaryContainer;
}

Future<Color> getDominantColorFromImage(String url) async {
  ColorScheme scheme = await ColorScheme.fromImageProvider(
    provider: Image.asset(url).image,
  );
  return scheme.primaryContainer;
}

double getPercentage(double wholeSale, double retail) {
  if (retail <= 0) {
    throw 0.0;
  }

  double discount = retail - wholeSale;
  double discountPercentage = (discount / retail) * 100;

  // Round to 2 decimal places
  return double.parse(discountPercentage.toStringAsFixed(2));
}

Widget getLoader() {
  return LoadingAnimationWidget.threeArchedCircle(
    color: HexColor.fromHex(AppTheme.primaryColor),
    size: 40,
  );
}

Widget getPriceInText(double price, [TextStyle? style, double? pictureWidth]) {
  bool isInt = price % 1 == 0;
  return Row(
    children: [
      Text(
        isInt ? price.toInt().toString() : price.toStringAsFixed(2),
        style:
            style ??
            TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(AppTheme.primaryColor),
              letterSpacing: 0.2,
            ),
      ),
      SizedBox(width: 5),
      SvgPicture.asset("assets/icons/sar.svg", width: pictureWidth ?? 20),
    ],
  );
}

String getLang() => Get.locale?.languageCode ?? "en";

void showErrorDialog(BuildContext context, String? error) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/error.svg"),
            SizedBox(height: 20),
            Text(
              "error_title".tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                fontSize: 20,
              ),
            ),
            Text(
              error ?? "error_body".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: HexColor.fromHex("#717088"),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("ok".tr),
              style: AppTheme.outlinedButtonStyle,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget pushUpAnimation(Widget c) {
  return TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 600),
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(0, (1 - value) * 20),
        child: Opacity(opacity: value, child: c),
      );
    },
  );
}

Widget bounceAnimation({required Widget c}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOutQuart,
    padding: EdgeInsets.only(bottom: 10),
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: c),
        );
      },
    ),
  );
}

TweenAnimationBuilder<double> buildTitle(String title) {
  return TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 600),
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(0, (1 - value) * 20),
        child: Opacity(
          opacity: value,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: HexColor.fromHex(AppTheme.primaryColor)
            ),
          ),
        ),
      );
    },
  );
}

void showLogoutAlert(BuildContext context) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/alert_rect.svg"),
            SizedBox(height: 20),
            Text(
              "logout".tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                fontSize: 20,
              ),
            ),
            Text(
              "alert_logout_body".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: HexColor.fromHex("#717088"),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("stay_logged_in".tr),
              style: AppTheme.outlinedButtonStyle,
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                AuthService authService = getIt();
                authService.signOut();
                Get.offAllNamed(AppRoutes.login);
              },
              child: Text(
                "logout".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex("#E62F29"),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar buildAppBar(BuildContext context, [bool? autoBack = false,Function(String value)? onSearchSubmitted]) {
  final ValueNotifier<double> widthSearchBox = ValueNotifier(57);
  TextEditingController searchController = TextEditingController();
  return AppBar(
    backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
    elevation: 0,
    leadingWidth: 120,
    leading:
        autoBack ?? false
            ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.5 + (value * 0.5),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: HexColor.fromHex(AppTheme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
            : TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.5 + (value * 0.5),
                    child: Hero(
                      tag: "a2",
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",

                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    actions: [
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Material(
                color: Colors.transparent,
                child: ValueListenableBuilder(
                  valueListenable: widthSearchBox,
                  builder: (context, size, _) {
                    return AnimatedContainer(
                      width: size,
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //  shape:size == 200 ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: HexColor.fromHex(AppTheme.borderGrey),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        mainAxisAlignment:
                            size == 250
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (size == 250)
                            Expanded(
                              child: Center(
                                child: TextFormField(
                                  controller: searchController,
                                  onTapOutside: (p) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 6.9,
                                    ),
                                    border: InputBorder.none,

                                    prefixIcon: InkWell(
                                      onTap: () {
                                        searchController.text = "";

                                        widthSearchBox.value = 55;
                                      },
                                      child:
                                          size == 250
                                              ? Container(
                                                padding: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: HexColor.fromHex(
                                                      AppTheme.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 12,
                                                  color: HexColor.fromHex(
                                                    AppTheme.borderGrey,
                                                  ),
                                                ),
                                              )
                                              : null,
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,

                                    hintText: "search".tr,
                                    hintStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: HexColor.fromHex(
                                        AppTheme.borderGrey,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          InkWell(
                            onTap: () {

                              if(indexWidget.value != 0){
                                return;
                              }
                              if (size == 250) {
                                if (searchController.text.isEmpty) {
                                  return;
                                }
                                onSearchSubmitted?.call(searchController.text);
                              } else {
                                widthSearchBox.value = 250;
                              }
                            },
                            child: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      ValueListenableBuilder(
        valueListenable: widthSearchBox,
        builder: (context, size, _) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 20),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: size == 250 ? 0 : 55,
                        height: size == 250 ? 0 : 55,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.borderGrey),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/notifications.svg",
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  );
}

AppBar buildAppBar2(BuildContext context, [bool? autoBack = false,Function(String value)? onSearchSubmitted, List? actions]) {
  final ValueNotifier<double> widthSearchBox = ValueNotifier(57);
  TextEditingController searchController = TextEditingController();
  final HomePageController _homePageController = getIt();
  return AppBar(
    backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
    elevation: 0,
    leadingWidth: 120,
    leading:
    autoBack ?? false
        ? TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.5 + (value * 0.5),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),
              ),
            ),
          ),
        );
      },
    )
        : TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.5 + (value * 0.5),
            child: Hero(
              tag: "a2",
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",

                ),
              ),
            ),
          ),
        );
      },
    ),
    actions: [
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Material(
                color: Colors.transparent,
                child: ValueListenableBuilder(
                  valueListenable: widthSearchBox,
                  builder: (context, size, _) {
                    return AnimatedContainer(
                      width: size,
                      height: 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //  shape:size == 200 ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: HexColor.fromHex(AppTheme.borderGrey),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        mainAxisAlignment:
                        size == 250
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (size == 250)
                            Expanded(
                              child: Center(
                                child: TextFormField(
                                  controller: searchController,
                                  onTapOutside: (p) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 6.9,
                                    ),
                                    border: InputBorder.none,

                                    prefixIcon: InkWell(
                                      onTap: () {
                                        print("indexWidget.value1 : ${indexWidget.value}");
                                        searchController.text = "";

                                        widthSearchBox.value = 55;
                                      },
                                      child:
                                      size == 250
                                          ? Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: HexColor.fromHex(
                                              AppTheme.primaryColor,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 12,
                                          color: HexColor.fromHex(
                                            AppTheme.borderGrey,
                                          ),
                                        ),
                                      )
                                          : null,
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,

                                    hintText: "search".tr,
                                    hintStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: HexColor.fromHex(
                                        AppTheme.borderGrey,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          InkWell(
                            onTap: () {

                              print("indexWidget.value : ${indexWidget.value}");
                              if(indexWidget.value != 0){
                                return;
                              }
                              if (size == 250) {
                                if (searchController.text.isEmpty) {
                                  return;
                                }
                                onSearchSubmitted?.call(searchController.text);
                              } else {
                                widthSearchBox.value = 250;
                              }
                            },
                            child: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      ValueListenableBuilder(
        valueListenable: widthSearchBox,
        builder: (context, size, _) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 20),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Material(
                    color: Colors.transparent,
                    child: ValueListenableBuilder(
                      valueListenable: _homePageController.cartProducts,
                      builder: (context,val,_) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.cart);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: size == 250 ? 0 : 55,
                                height: size == 250 ? 0 : 55,
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: HexColor.fromHex(AppTheme.borderGrey),
                                  ),

                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/cart.svg",
                                ),
                              ),
                              Positioned(

                                  right: 10,
                                  top:0,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor.fromHex(AppTheme.primaryColor)
                                      ),
                                      child: Text("${val.length}",style: TextStyle(color: Colors.white),)))
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  );
}