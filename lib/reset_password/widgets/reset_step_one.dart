import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/login/presentation/manager/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/di/di.dart';
import '../../core/theme/app_theme.dart';

typedef OnNextTap = void Function();
class ResetStepOne extends StatelessWidget {
  ResetStepOne({super.key, required this.onNextTap});
  final OnNextTap onNextTap;

  final LoginController _controller = getIt();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: 60,),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: "email".tr
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: Divider(color: HexColor.fromHex("#CDCCE0"),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("or".tr,style:  Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                  fontWeight: FontWeight.bold
              ),),
            ),
            Expanded(child: Divider(color: HexColor.fromHex("#CDCCE0"),)),

          ],
        ),
        SizedBox(height: 20,),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              hintText: "mobile".tr
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        ),


        Spacer(),
        ElevatedButton(onPressed: ()async{
          try {
            if(_emailController.text.isEmpty && _phoneController.text.isEmpty){
              showErrorDialog(context, "enter_mobile_email".tr);
              return;
            }
            Map<String,dynamic> params = {
              "email":_emailController.text,
              "phone":_phoneController.text,
            };
            _controller.params = params;
            _controller.code = await _controller.sendCodeResetPassword(params);
            onNextTap();
          }catch(e){
            handleException(context, e);
          }

        }, child: Text("next".tr)),
      ],
    );
  }
}
