import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/deal_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../payment/presentation/pages/checkout.dart';
import '../../data/models/deal_product_model.dart';

typedef OnDetailsClicked = void Function();
class SingleItemShoppingList extends StatelessWidget {
  const SingleItemShoppingList({super.key, required this.dealProductModel,  this.isRelatedItem = false, this.onDetailsClicked});
  final DealProductModel dealProductModel;
  final bool isRelatedItem ;
  final OnDetailsClicked? onDetailsClicked ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dealProductModel.product.name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    getPriceInText(double.parse(dealProductModel.retailPrice)),
                    SizedBox(width: 10),
                    getDiscountedPriceInText(double.parse(dealProductModel.retailPrice)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "available_pcs".tr,
                      style: GoogleFonts.cairo(
                        color: HexColor.fromHex("#1E1D33"),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    // Text(
                    //   dealProductModel.quantity.toString(),
                    //   style: TextStyle(
                    //     color: HexColor.fromHex("#5E5D68"),
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      "min_quantity".tr,
                      style: GoogleFonts.cairo(
                        color: HexColor.fromHex("#1E1D33"),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),

                    // Text(
                    //   dealProductModel.minInvestment.toString(),
                    //   style: TextStyle(
                    //     color: HexColor.fromHex("#5E5D68"),
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
        Expanded(
                      child: ElevatedButton(
                        onPressed: () {

                          isRelatedItem ? onDetailsClicked!() : Get.to(DealDetails(dealModel: dealProductModel));
                        },
                        child: Text("details".tr),
                        style: AppTheme.outlinedButtonStyle,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Hero(
                        tag: "buy_now",
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(Checkout());
                          },
                          child: Text("buy_now".tr),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack header(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: getDominantColor("${baseUrlImage}${dealProductModel.product.productPictures.first.picture}"),
          builder: (context,snap) {
            return Container(


              decoration: BoxDecoration(

                color: snap.data,
                //color: HexColor.fromHex("#EFEFE3"),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network("${baseUrlImage}${dealProductModel.product.productPictures.first.picture}",fit: BoxFit.fill,)),
              ),
            );
          }
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Hero(
            tag: "discount",
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#2CB9A3"),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                "${getPercentage(double.parse(dealProductModel.retailPrice), double.parse(dealProductModel.retailPrice)).toString()}% ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: StarRating(rating: 4, color: HexColor.fromHex("#fcc120")),
          ),
        ),
      ],
    );
  }
}
