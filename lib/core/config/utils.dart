import 'dart:developer';
import 'dart:ui';

import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/core/services/auth_services.dart';
import 'package:borsa_now_bis/screens/cart/pages/cart_page.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:borsa_now_bis/screens/notifications_page/presentation/pages/notifications_page.dart';
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

// List of months with translations
final List<String> monthList = [
  'january'.tr,
  'february'.tr,
  'march'.tr,
  'april'.tr,
  'may'.tr,
  'june'.tr,
  'july'.tr,
  'august'.tr,
  'september'.tr,
  'october'.tr,
  'november'.tr,
  'december'.tr,
];

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

bool isValidSaudiPhone(String phone) {
  return phone.startsWith("05") && phone.length == 10;
}

Widget noItemFound(BuildContext c) {
  return Center(child: Text("no_item_found".tr));
}

Widget dateSelector(
  Function(String month) onMonthSelected,
  Function(int year) onYearSelected,
  List<int> listOfYears, [
  bool isMonthSelectable = true,
]) {
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  final ValueNotifier<bool> shakeUp = ValueNotifier(false);

  return ValueListenableBuilder(
    valueListenable: shakeUp,
    builder: (context, _, _) {
      return Row(
        children: [
          isMonthSelectable
              ? Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderGrey),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedMonth,
                      isDense: false,

                      itemHeight: 50,
                      hint: Text("month".tr),
                      icon: Icon(Icons.keyboard_arrow_down),

                      onChanged: (int? newValue) {
                        _selectedMonth = newValue ?? DateTime.now().month;

                        shakeUp.value = !shakeUp.value;
                        onMonthSelected(newValue.toString());
                      },
                      items:
                          <int>[
                            0,
                            1,
                            2,
                            3,
                            4,
                            5,
                            6,
                            7,
                            8,
                            9,
                            10,
                            11,
                          ].map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(monthList[value]),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              )
              : Container(),
          isMonthSelectable ? SizedBox(width: 20) : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: HexColor.fromHex(AppTheme.borderGrey),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isDense: false,

                  value: _selectedYear,

                  itemHeight: 50,
                  hint: Text("year".tr),
                  icon: Icon(Icons.keyboard_arrow_down),

                  onChanged: (int? newValue) {
                    _selectedYear = newValue!;
                    print("Selected yeaaat = $newValue");

                    shakeUp.value = !shakeUp.value;
                    onYearSelected(_selectedYear);
                  },
                  items:
                      listOfYears.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      );
    },
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
      SvgPicture.asset(
        "assets/icons/sar.svg",
        width: pictureWidth ?? 20,
        colorFilter: ColorFilter.mode(
          style != null
              ? style.color!
              : HexColor.fromHex(
                AppTheme.primaryColor,
              ), // The color you want to apply
          BlendMode.srcIn, // The blend mode to use
        ),
      ),
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
              color: HexColor.fromHex(AppTheme.primaryColor),
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

AppBar buildAppBar(
  BuildContext context, [
  bool? autoBack = false,
  Function(String value)? onSearchSubmitted,
]) {
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "$baseUrlImage/${appServices.getUser().picture}",
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
                              if (indexWidget.value != 0) {
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
        valueListenable: _homePageController.cartProducts,
        builder: (context, p, _) {
          return ValueListenableBuilder(
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
                          onTap: () {
                            Get.to(CartPage());
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
                                    color: HexColor.fromHex(
                                      AppTheme.borderGrey,
                                    ),
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
                                  "assets/icons/cart.svg",
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor.fromHex(
                                      AppTheme.primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "${p.length}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    ],
  );
}
List<String> genderList = [
  "male",
  "female"
];

AppBar buildAppBar2() {
  return AppBar(
    backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
    elevation: 0,
    leadingWidth: 80,
    leading: TweenAnimationBuilder<double>(
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
                FocusManager.instance.primaryFocus?.unfocus();
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
    ),
    actions: [
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 600),
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
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(15),
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
                    child: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      TweenAnimationBuilder<double>(
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
                  child: Container(
                    width: 50,
                    height: 50,
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
                    child: SvgPicture.asset("assets/icons/notifications.svg"),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
