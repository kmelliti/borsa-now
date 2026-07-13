import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/cart/pages/payment_result.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_page/data/models/deal_product_model.dart';
import '../widgets/pickup_address.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key, required this.isToClearCart});
  final bool isToClearCart;

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {

  final HomePageController _controller = getIt();
  ValueNotifier<List<DealProductModel>> tempCard = ValueNotifier([]);

  @override
  void initState() {

    if(Get.arguments != null){
      tempCard.value = Get.arguments;
    }
    super.initState();
  }


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
              PickupAddress(cartProducts: tempCard.value,),
              SizedBox(height: 20,),
              // Container(),
              Text("use_borsa_credit".tr),
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

                   if(_controller.cartProducts.value.length != _controller.items.length){
                     showErrorDialog(context, "${"select_products_pickup".tr} ");
                     return ;
                   }

                   bool passed = true;
                   for(int i = 0 ; i < _controller.items.length ; i++){
                     if(!_controller.items[i].containsKey("location_id")){
                       showErrorDialog(context, "${"select_product_pickup".tr} ${_controller.cartProducts.value.firstWhere((e)=> e.id == _controller.items[i]['retail_listing_id']).product.name}");
                       passed = false;
                       break;

                     }
                   }

                   if(!passed){
                     return;
                   }

                   print("_controler locations ${_controller.items}");




                    Get.off(()=>PaymentResult(isToClearCart: widget.isToClearCart, orderContent: _controller.cartProducts.value, items: _controller.items,) );

                  },
                  title: Text("use_credit".tr, style:
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

            ],
          ),
        ),
      ),
    );
  }
}
