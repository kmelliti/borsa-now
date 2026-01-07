import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget generalContainer(BuildContext context,String title, String assets,GestureTapCallback onTap) {
  return bounceAnimation(
    c: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.symmetric( horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: HexColor.fromHex("#CDCCE0")),
        ),
        child: Row(
          children: [
            SvgPicture.asset(assets),
            SizedBox(width: 20),
            Expanded(child: Text(title,style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),)),
            Icon(
              Icons.arrow_forward,
              color: HexColor.fromHex(AppTheme.primaryColor),
            ),
          ],
        ),
      ),
    ),
  );
}

class PersonalInfos extends StatefulWidget {
  const PersonalInfos({super.key});

  @override
  State<PersonalInfos> createState() => _PersonalInfosState();
}

class _PersonalInfosState extends State<PersonalInfos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          generalContainer(context,"personal_info".tr, "assets/icons/my_account.svg",(){
            Get.toNamed(AppRoutes.personalInfo);
          }),
          SizedBox(height: 10),
          generalContainer(context,"address".tr, "assets/icons/pin.svg",(){
            Get.toNamed(AppRoutes.address);
          }),
          SizedBox(height: 10),
          generalContainer(context,"identity_info".tr, "assets/icons/badge.svg",(){
            Get.toNamed(AppRoutes.personalIdentity);
          }),
          SizedBox(height: 10),
          generalContainer(context,"bank_info".tr, "assets/icons/bank.svg",(){
            Get.toNamed(AppRoutes.bankInfo);
          }),
          SizedBox(height: 10),
          generalContainer(context,"password".tr, "assets/icons/key.svg",(){
            Get.toNamed(AppRoutes.password);
          }),
          SizedBox(height: 20),
          pushUpAnimation(
            InkWell(
              onTap: (){
                showLogoutAlert(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                margin: EdgeInsets.symmetric( horizontal: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logout.svg"),
                    SizedBox(width: 10),
                    Text("logout".tr,style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
