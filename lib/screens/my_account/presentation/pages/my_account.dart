import 'package:borsa_now_bis/core/routes/app_routes.dart';
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
      appBar: buildAppBar(),
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
                              labelColor: HexColor.fromHex(AppTheme.primaryColor),
                              labelPadding: EdgeInsets.only(left: 40),
                              // labelPadding: EdgeInsets.zero,
                              unselectedLabelColor: HexColor.fromHex(AppTheme.primaryColor),
                              unselectedLabelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              dividerColor: HexColor.fromHex(AppTheme.primaryColor),
                              indicator: CustomTabIndicator(
                                color: Colors.black,
                                height: 1.0,
                              ),
                                indicatorSize: TabBarIndicatorSize.label,
                              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
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
                          Center(child: Text("إعداداتي".tr)),
                          Center(child: Text("المدفوعات".tr)),
                          PersonalInfos()
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



  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
      elevation: 0,
      leadingWidth: 120,
      leading: TweenAnimationBuilder<double>(
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
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Hero(
                  tag: "a4",
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
                child: Hero(
                  tag: "a3",
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
                        child: SvgPicture.asset(
                          "assets/icons/notifications.svg",
                        ),
                      ),
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
}
