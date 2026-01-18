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
import 'list_related_deals.dart';



class DealDetails extends StatefulWidget {
  DealDetails({super.key, this.dealModel, this.dealId, });

  final DealProductModel? dealModel;

  final int? dealId;

  @override
  State<DealDetails> createState() => _DealDetailsState();
}

class _DealDetailsState extends State<DealDetails> {
  final ValueNotifier<int> sliderIndex = ValueNotifier(0);

  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  final HomePageController _homePageController = getIt();

  final ScrollController _controller = ScrollController();
  late DealProductModel dealModel;

  ValueNotifier<bool> dealLoading = ValueNotifier(false);

  Future getDealModel() async {
    dealLoading.value = true;

    if (widget.dealModel != null) {
      dealModel = widget.dealModel!;
    } else if (widget.dealId != null) {
      dealModel = await _homePageController.getDealDetails(widget.dealId!);
    }

    isFavorite.value = dealModel.isFavorite;

    dealLoading.value = false;
  }

  @override
  void initState() {
    // dealModel = widget.dealModel;
    getDealModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(context,true),
      bottomNavigationBar: Container(
        height: 180,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _homePageController.addProductToCart(dealModel);
              },
              child: Text("add_to_cart".tr),
              style: AppTheme.outlinedButtonStyle,
            ),

            SizedBox(height: 10),

            ElevatedButton(onPressed: () {}, child: Text("buy_now".tr)),
          ],
        ),
      ),

      body: SingleChildScrollView(
        controller: _controller,
        child: ValueListenableBuilder(
          valueListenable: dealLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? Container()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),

                          height: 230,


                          child: PageView(
                            onPageChanged: (int currentIndex) {
                              sliderIndex.value = currentIndex;
                            },
                            children:
                                dealModel.product.productPictures.map((im) {
                                  return ImageColorBuilder(
                                    url: "${baseUrlImage}/${im.picture}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Container(
                                        color: Colors.grey,
                                      );
                                    },
                                    builder: (
                                      BuildContext context,
                                      Image? image,
                                      Color? imageColor,
                                    ) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(vertical: 20),
                                          decoration: BoxDecoration(
                                            color: imageColor,
                                          ),
                                          child: image,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: ValueListenableBuilder(
                            valueListenable: sliderIndex,
                            builder: (context, index, _) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                dealModel.product.productPictures.map((im) {
                                  return Container(
                                    width: 20,
                                    height: 5,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                      dealModel
                                          .product
                                          .productPictures[index] ==
                                          im
                                          ? HexColor.fromHex(
                                        "#393942",
                                      )
                                          : HexColor.fromHex(
                                        AppTheme.textFieldBorder,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            dealModel.product.name,
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              getPriceInText(
                                double.parse(dealModel.retailPrice),
                              ),
                              SizedBox(width: 10),
                              getDiscountedPriceInText(
                                double.parse(dealModel.retailPrice,),context
                              ),
                              SizedBox(width: 10),

                              // Container(
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 10,
                              //     vertical: 7,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: HexColor.fromHex("#2CB9A3"),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //
                              //   child: Text(
                              //     "${getPercentage(double.parse(dealModel.retailPrice), double.parse(dealModel.retailPrice)).ceil().toString()} %",
                              //     style: Theme.of(
                              //       context,
                              //     ).textTheme.bodyMedium?.copyWith(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w700,
                              //       fontSize: 14,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ReadMoreText(
                           dealModel.product.description,
                            trimMode: TrimMode.Line,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'show_more'.tr,
                            trimExpandedText: 'show_less'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: HexColor.fromHex("#5B5B5B"),
                            ),
                            moreStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                          ),

                          SizedBox(height: 20),
                          //
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Container(
                          //         padding: EdgeInsets.all(20),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: HexColor.fromHex(
                          //               AppTheme.borderGrey,
                          //             ),
                          //           ),
                          //           borderRadius: BorderRadius.circular(20),
                          //         ),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             //available_pcs
                          //             Text(
                          //               "min_quantity".tr,
                          //               style: Theme.of(
                          //                 context,
                          //               ).textTheme.bodyMedium?.copyWith(
                          //                 color: HexColor.fromHex(
                          //                   AppTheme.primaryColor,
                          //                 ),
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             SizedBox(height: 10),
                          //
                          //             // Text(
                          //             //   widget.dealModel.minInvestment.toString(),
                          //             //   style: Theme.of(
                          //             //     context,
                          //             //   ).textTheme.bodyMedium?.copyWith(
                          //             //     color: HexColor.fromHex(
                          //             //       AppTheme.primaryColor,
                          //             //     ),
                          //             //     fontWeight: FontWeight.bold,
                          //             //     fontSize: 16,
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(width: 10),
                          //     Expanded(
                          //       child: Container(
                          //         padding: EdgeInsets.all(20),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: HexColor.fromHex(
                          //               AppTheme.borderGrey,
                          //             ),
                          //           ),
                          //           borderRadius: BorderRadius.circular(20),
                          //         ),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //
                          //           children: [
                          //             //available_pcs
                          //             Text(
                          //               "available_pcs".tr,
                          //               style: Theme.of(
                          //                 context,
                          //               ).textTheme.bodyMedium?.copyWith(
                          //                 color: HexColor.fromHex(
                          //                   AppTheme.primaryColor,
                          //                 ),
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             SizedBox(height: 10),
                          //             // Text(
                          //             //   "${widget.dealModel.quantity-widget.dealModel.quantitySold}",
                          //             //   style: Theme.of(
                          //             //     context,
                          //             //   ).textTheme.bodyMedium?.copyWith(
                          //             //     color: HexColor.fromHex(
                          //             //       AppTheme.primaryColor,
                          //             //     ),
                          //             //     fontWeight: FontWeight.bold,
                          //             //     fontSize: 16,
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "ratings".tr,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 20,
                          color: HexColor.fromHex(AppTheme.primaryColor),
                        ),
                      ),
                    ),
                    ReviewList(productId: dealModel.id.toString()),

                    SizedBox(height: 10),
                    RelatedDeals(
                      dealModel: dealModel,
                      type: RelatedDealsType.grid, onSelected: (DealProductModel dealModel) {
                        setState(() {
                          dealModel = dealModel;
                          _controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                    },
                    ),
                    SizedBox(height: 100),
                  ],
                );
          },
        ),
      ),
    );
  }
}
