import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/deal_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../payment/presentation/pages/checkout.dart';
import '../../data/models/deal_product_model.dart';

// typedef OnDetailsClicked = void Function();
typedef OnFavouriteClicked = void Function();

class SingleItemShoppingGrid extends StatefulWidget {

  const SingleItemShoppingGrid({super.key, required this.dealProductModel,  this.isRelatedItem = false, /*this.onDetailsClicked,*/ required this.onFavouriteClicked });
  final DealProductModel dealProductModel;
  final bool isRelatedItem ;
  // final OnDetailsClicked? onDetailsClicked ;
  final OnFavouriteClicked onFavouriteClicked ;

  @override
  State<SingleItemShoppingGrid> createState() => _SingleItemShoppingGridState();
}

class _SingleItemShoppingGridState extends State<SingleItemShoppingGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.itemBorderColor)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: header(context, widget.onFavouriteClicked),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 10.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dealProductModel.product.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    // fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    // letterSpacing: 0.2,
                  ),
                ),
                // SizedBox(height: 10),
                // Row(
                //   children: [
                //     getPriceInText(double.parse(dealProductModel.wholesalePrice)),
                //     SizedBox(width: 10),
                //     getDiscountedPriceInText(double.parse(dealProductModel.retailPrice)),
                //   ],
                // ),

                SizedBox(height: 10),

                widget.dealProductModel.product.rates.length > 0 ?
                Row(
                  children: [
                    SizedBox(
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset("assets/icons/star.svg")
                    ),
                    SizedBox(width: 10),
                    Builder(

                      builder: (context) {

                        var rating = 0;
                        widget.dealProductModel.product.rates.forEach((element) {
                          rating += element.rate == null ? 0 : element.rate!;
                          // print("elemmmmm: ${element.comment}");
                        });

                        return Text(

                            (rating/widget.dealProductModel.product.rates.length).toString(),
                          style: TextStyle(
                            color: HexColor.fromHex(AppTheme.textColor),
                            fontSize: 16,
                          ),
                        );
                      }
                    ),
                  ],
                ) :
                Row(
                  children: [
                    SizedBox(
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset("assets/icons/star.svg", colorFilter: const ColorFilter.mode(
                          Colors.black12, // The color you want to apply
                          BlendMode.srcIn, // The blend mode to use
                        ),)
                    ),
                    SizedBox(width: 10),

                    Text("0", style: TextStyle(
                      color: Colors.black12,
                      fontSize: 16,
                    ),
                  )

                  ],
                ),

                SizedBox(height: 10),


                Text(
                  widget.dealProductModel.product.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    // fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex(AppTheme.textColor),


                    // letterSpacing: 0.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),



                // SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () {
                //
                //           isRelatedItem ? onDetailsClicked!() : Get.to(DealDetails(dealModel: dealProductModel));
                //         },
                //         child: Text("details".tr),
                //         style: AppTheme.outlinedButtonStyle,
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     Expanded(
                //       child: Hero(
                //         tag: "buy_now",
                //         child: ElevatedButton(
                //           onPressed: () {
                //             Get.to(Checkout());
                //           },
                //           child: Text("buy_now".tr),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack header(BuildContext context, OnFavouriteClicked onFavouriteClicked) {
    return Stack(
      children: [
        Container(

          height: 178,
          decoration: BoxDecoration(

            shape: BoxShape.rectangle,
            // color: snap.data,
            //color: HexColor.fromHex("#EFEFE3"),
            borderRadius: BorderRadius.circular(30),

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(

              child: ClipRRect(

                  borderRadius: BorderRadius.circular(30),
                  child: Image.network("${baseUrlImage}${widget.dealProductModel.product.productPictures.first.picture}",fit: BoxFit.cover, height: 178,      // Optional: Define a specific height
                    width: double.infinity,)),

            ),
          ),
        ),
        // FutureBuilder(
        //     future: getDominantColorFromImage("${dealProductModel.product.productPictures.first.picture}"),
        //     builder: (context,snap) {
        //       return AspectRatio(
        //         aspectRatio: 1.0,
        //         child: Container(
        //
        //           decoration: BoxDecoration(
        //
        //             shape: BoxShape.rectangle,
        //             color: snap.data,
        //             //color: HexColor.fromHex("#EFEFE3"),
        //             borderRadius: BorderRadius.circular(30),
        //
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Center(
        //
        //               child: ClipRRect(
        //
        //                   borderRadius: BorderRadius.circular(30),
        //                   // child: Image.network("${baseUrlImage}${dealProductModel.product.productPictures.first.picture}",fit: BoxFit.fitWidth,)),
        //                   child: Image.asset("${dealProductModel.product.productPictures.first.picture}",fit: BoxFit.fill,)),
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        // ),
        Positioned(
          top: 20,
          right: 20,
          child: InkWell(
            onTap: () {


              onFavouriteClicked();

              widget.dealProductModel.isFavorite = !widget.dealProductModel.isFavorite;
              setState(() {

              });
            },
            child: Container(
              width: 36,
              height: 36,
              // padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

              ),
              child: Center(
                  child: SizedBox(
                      width: 15,
                      height: 15,
                      child: widget.dealProductModel.isFavorite == true ? SvgPicture.asset("assets/icons/favourite_yes.svg") : SvgPicture.asset("assets/icons/favourite_no.svg")
                  )
              ),
            ),
          ),
        ),

      ],
    );
  }
}
