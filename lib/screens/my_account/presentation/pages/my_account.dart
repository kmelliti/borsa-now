import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/pages/update_my_info.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/widgets/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/address.dart';
import '../widgets/bank_info.dart';
import '../widgets/custom_tabIndicator.dart';
import '../widgets/password_page.dart';
import '../widgets/personal_identity.dart';
import 'personal_infos.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 600),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: Opacity(
                    opacity: value,
                    child: Text(
                      "my_profile".tr,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    // TabBar
                    Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                          ),
                        ),
                        Container(
                          height: 54,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TabBar(
                              padding: EdgeInsets.zero,
                              // tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              labelColor: HexColor.fromHex(
                                AppTheme.primaryColor,
                              ),
                              labelPadding: EdgeInsets.only(left: 40),
                              // labelPadding: EdgeInsets.zero,
                              unselectedLabelColor: HexColor.fromHex(
                                AppTheme.primaryColor,
                              ),
                              unselectedLabelStyle: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              dividerColor: HexColor.fromHex(
                                AppTheme.primaryColor,
                              ),
                              indicator: CustomTabIndicator(
                                color: Colors.black,
                                height: 1.0,
                              ),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              tabs: [
                                Tab(text: "إعداداتي".tr),
                                Tab(text: "المدفوعات".tr),
                                Tab(text: "معلوماتي الشخصية".tr),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // TabBarView
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // LeaveDetailsOrder(),
                          getParams(context),
                          Center(child: Text("المدفوعات".tr)),
                          EditPersonalInformation(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getParams(BuildContext context) {
    print("language ${ Get.locale?.languageCode}");
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              SvgPicture.asset("assets/icons/globe.svg", width: 20),
              SizedBox(width: 10),
              Text(
                "language".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: HexColor.fromHex(AppTheme.borderGrey),
              ),
            ),

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: Get.locale?.languageCode == "en"?"English":"العربية",
                isDense: false,

                itemHeight: 50,

                icon: Icon(Icons.keyboard_arrow_down),

                onChanged: (String? newValue) {
                    Get.updateLocale(Locale(newValue == "English"?"en":"ar"));
                },
                items:
                    <String>["العربية", "English"].map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
          ),

          SizedBox(height: 20),
          Spacer(),
          pushUpAnimation(
            InkWell(
              onTap: () {
                showLogoutAlert(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                margin: EdgeInsets.symmetric(horizontal: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  border: Border.all(
                    color: HexColor.fromHex(AppTheme.borderGrey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logout.svg"),
                    SizedBox(width: 10),
                    Text(
                      "logout".tr,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HexColor.fromHex(AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
