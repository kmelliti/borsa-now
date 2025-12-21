import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/review_list.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/single_item_shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_color_builder/image_color_builder.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../payment/presentation/pages/payment_page.dart';
import '../../data/models/deal_product_model.dart';

class DealDetails extends StatefulWidget {
  DealDetails({super.key, required this.dealModel});

   final DealProductModel dealModel;

  @override
  State<DealDetails> createState() => _DealDetailsState();
}

class _DealDetailsState extends State<DealDetails> {
  final ValueNotifier<int> sliderIndex = ValueNotifier(0);

  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  final HomePageController _homePageController = getIt();

  final ScrollController _controller = ScrollController();
   late DealProductModel dealModel;
   @override
  void initState() {
   dealModel = widget.dealModel;
   isFavorite.value = dealModel.isFavorite;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar2(context),
      bottomNavigationBar: Container(
        height: 180,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              _homePageController.addCartProducts(mockProductModel());
            }, child: Text("add_to_cart".tr),style: AppTheme.outlinedButtonStyle,),

            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){}, child: Text("buy_now".tr)),
          ],
        ),
      ),

      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack(
            //   children: [
            //     SizedBox(
            //       height: 400,
            //       child: PageView(
            //         onPageChanged: (int currentIndex) {
            //           sliderIndex.value = currentIndex;
            //         },
            //         children:
            //             widget.dealModel.product.productPictures.map((im) {
            //               return ImageColorBuilder(
            //                 url: "${baseUrlImage}/${im.picture}",
            //                 fit: BoxFit.cover,
            //                 builder:
            //                     (
            //                       BuildContext context,
            //                       Image? image,
            //                       Color? imageColor,
            //                     ) {
            //                       return Container(
            //
            //                         // padding: EdgeInsets.symmetric(vertical: 20),
            //                         decoration: BoxDecoration(
            //                           color: imageColor,
            //                         ),
            //                         child: image,
            //                       );
            //                     },
            //               );
            //
            //             }).toList(),
            //       ),
            //     ),
            //
            //     Positioned(
            //       top: 60,
            //       right: 20,
            //       left: 20,
            //       child: Row(
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               Get.back();
            //             },
            //             child: Container(
            //               padding: EdgeInsets.all(10),
            //               margin: EdgeInsets.symmetric(horizontal: 5),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 shape: BoxShape.circle,
            //
            //                 border: Border.all(
            //                   color: HexColor.fromHex(AppTheme.borderGrey),
            //                 ),
            //               ),
            //               child: Icon(Icons.arrow_back),
            //             ),
            //           ),
            //           Spacer(),
            //           Container(
            //             width: 50,
            //             height: 50,
            //             padding: EdgeInsets.all(15),
            //             margin: EdgeInsets.symmetric(horizontal: 10),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               shape: BoxShape.circle,
            //
            //               border: Border.all(
            //                 color: HexColor.fromHex(AppTheme.borderGrey),
            //               ),
            //             ),
            //             child: SvgPicture.asset("assets/icons/share.svg"),
            //           ),
            //           InkWell(
            //             onTap: () async{
            //               isFavorite.value = !isFavorite.value;
            //               _homePageController.addDeleteFav({
            //                 "wholesale_offer_id":widget.dealModel.id,
            //               });
            //
            //             },
            //             child: Container(
            //               width: 50,
            //               height: 50,
            //
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: HexColor.fromHex(AppTheme.borderGrey),
            //                 ),
            //               ),
            //               child: ValueListenableBuilder(
            //                 valueListenable: isFavorite,
            //                 builder: (context,fav,_) {
            //                   return Center(child: Icon(fav ? Icons.favorite :Icons.favorite_border,color: HexColor.fromHex(AppTheme.primaryColor),));
            //                 }
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 20,
            //       left: 0,
            //       right: 0,
            //       child: ValueListenableBuilder(
            //         valueListenable: sliderIndex,
            //         builder: (context, index, _) {
            //           return Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children:
            //                 widget.dealModel.product.productPictures.map((im) {
            //                   return Container(
            //                     width: 10,
            //                     height: 10,
            //                     margin: EdgeInsets.symmetric(horizontal: 3),
            //                     decoration: BoxDecoration(
            //                       color:
            //                           widget.dealModel
            //                                       .product
            //                                       .productPictures[index] ==
            //                                   im
            //                               ? HexColor.fromHex(
            //                                 AppTheme.primaryColor,
            //                               )
            //                               : HexColor.fromHex(
            //                                 AppTheme.secondaryColor,
            //                               ),
            //                       shape: BoxShape.circle,
            //                     ),
            //                   );
            //                 }).toList(),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    widget.dealModel.product.name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      getPriceInText(
                        double.parse(widget.dealModel.wholesalePrice),
                      ),
                      SizedBox(width: 10),
                      getDiscountedPriceInText(
                        double.parse(widget.dealModel.retailPrice),
                      ),
                      SizedBox(width: 10),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#2CB9A3"),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          "${getPercentage(double.parse(widget.dealModel.retailPrice), double.parse(widget.dealModel.wholesalePrice)).ceil().toString()} %",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ReadMoreText(
                    widget.dealModel.product.description,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'show_more'.tr,
                    trimExpandedText: 'show_less'.tr,
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //available_pcs
                              Text(
                                "min_quantity".tr,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: HexColor.fromHex(
                                    AppTheme.primaryColor,
                                  ),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),

                              Text(
                                widget.dealModel.minInvestment.toString(),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: HexColor.fromHex(
                                    AppTheme.primaryColor,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              //available_pcs
                              Text(
                                "available_pcs".tr,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: HexColor.fromHex(
                                    AppTheme.primaryColor,
                                  ),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${widget.dealModel.quantity-widget.dealModel.quantitySold}",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: HexColor.fromHex(
                                    AppTheme.primaryColor,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ReviewList(productId: widget.dealModel.id.toString(),),

            SizedBox(height: 10),
            FutureBuilder(
              future: _homePageController.getRelatedDeals(widget.dealModel.id),
              builder: (context,snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: getLoader());
                }
                if(snap.connectionState == ConnectionState.done&&!snap.hasError){
                  List<DealProductModel> relatedDeals = snap.data!;
                  if(relatedDeals.isEmpty){
                    return Container();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "you_may_like".tr,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 20,
                              color: HexColor.fromHex("#1E1D33"),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(20),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: relatedDeals.length,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: SingleItemShoppingList(
                              dealProductModel: relatedDeals[i],
                              isRelatedItem: true,
                              onDetailsClicked: () {
                                setState(() {
                                  dealModel = relatedDeals[i];

                                });
                                _controller.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }


                return Container();
              }
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
