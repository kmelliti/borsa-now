import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/models/order_submitted_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/deal_product_model.dart';
import 'package:borsa_now_bis/screens/my_orders/pages/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/utils.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/presentation/manager/home_page_controller.dart';
import '../../main_screen/presentation/pages/main_screen.dart';

class PaymentResult extends StatefulWidget {
  const PaymentResult({super.key, required this.isToClearCart, required this.orderContent, required this.items});
  final bool isToClearCart;
  final  List<DealProductModel> orderContent;
  final List<Map<String,dynamic>> items;

  @override
  State<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {

  final HomePageController _controller = getIt();
  final SharedPreferences _sharedPreferences = getIt();
  double total = 0;

  @override
  void initState() {

    total = widget.orderContent.fold(
      0.0,
      (total, product) =>
          total + (double.parse(product.retailPrice) * product.cartQuantity),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.submitOrder(widget.orderContent,widget.items),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            OrderSubmittedModel? response = snap.data;
            HomePageController homePageController = getIt();

            if(widget.isToClearCart){
              homePageController.cartProducts.value.clear();
              _sharedPreferences.remove(cart);

            }
            if(snap.hasError){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("error_body".tr),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(() => MainScreen());
                        },
                        child: Text("${"home".tr}"),
                        style: AppTheme.outlinedButtonStyle,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 150),
                    SvgPicture.asset('assets/icons/payment_success.svg'),
                    SizedBox(height: 20),
                    Text(
                      "payment_success".tr,
                      style: TextStyle(
                        color: HexColor.fromHex(AppTheme.primaryColor),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "payment_success_sub".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: HexColor.fromHex(AppTheme.textColor),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: HexColor.fromHex(AppTheme.itemBorderColor),
                          width: 1,
                        ),
                      ),

                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  response?.status ?? "",
                                  style: TextStyle(
                                    color: HexColor.fromHex("#FF7700"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${df.format(DateTime.now())}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textDate),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "${"order_id".tr}:",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color: HexColor.fromHex("#5B5B5B"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "15455544",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textColor),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "${"track_id".tr}:",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color: HexColor.fromHex("#5B5B5B"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "IW3475453455",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textColor),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "${"pickup_location".tr}:",
                                  style: Theme
                                      .of(
                                    context,
                                  )
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    color: HexColor.fromHex("#5B5B5B"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "This is the address",
                                  style: Theme
                                      .of(
                                    context,
                                  )
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textColor),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${"quantity".tr}:",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge?.copyWith(
                                        color: HexColor.fromHex("#5B5B5B"),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      response?.items
                                              .fold(
                                                0,
                                                (previousValue, element) =>
                                                    previousValue +
                                                    element.quantity,
                                              )
                                              .toString() ??
                                          "",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.textColor,
                                        ),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${"total".tr}:",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge?.copyWith(
                                        color: HexColor.fromHex("#5B5B5B"),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      total.toString(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayMedium?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.textColor,
                                        ),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.off(() => MainScreen());
                      },
                      child: Text("${"home".tr}"),
                      style: AppTheme.outlinedButtonStyle,
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
