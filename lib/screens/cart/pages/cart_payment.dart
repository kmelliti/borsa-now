import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/cart/pages/payment_result.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {

  final HomePageController _controller = getIt();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle("payment".tr),
              SizedBox(height: 40,),
              // Container(),
              Text("استخدم رصيد المحفظة الآن"),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color:  HexColor.fromHex("#F3F3F4"),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: HexColor.fromHex(AppTheme.borderGreyLight),
                  ),
                ),
                child: ListTile(
                  onTap: () {

                    print("${_controller.cartProducts.value}");

                    Get.off(()=>PaymentResult(),arguments: _controller.cartProducts.value);

                  },
                  title: Text("استخدم رصيد المحفظة", style:
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: HexColor.fromHex(AppTheme.primaryColor),
                  ),
                    ),
                  subtitle: getPriceInText(
                      0,
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/launcher.png',
                      width: 57,  // Standard Material icon size
                      height: 57,
                    ),
                  ),
                ),
              ),
              // ValueListenableBuilder(
              //     valueListenable: _controller.cartProducts,
              //     builder: (context,list,_) {
              //
              //       return AnimatedList(
              //         key: _listKey,
              //         initialItemCount: list.length,
              //         physics: NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemBuilder: (context, index, animation) {
              //           return _buildItem(list[index], context, animation);
              //         },
              //       );
              //
              //     }
              // )
            ],
          ),
        ),
      ),
    );
  }
}
