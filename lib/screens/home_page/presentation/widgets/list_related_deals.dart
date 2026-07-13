import 'package:borsa_now_bis/core/widgets/favouriteIcon.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/single_item_shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/deal_product_model.dart';

enum RelatedDealsType { list, grid }

typedef OnSelected = Function(DealProductModel dealModel);

class RelatedDeals extends StatelessWidget {
  RelatedDeals({
    super.key,
    required this.type,
    this.dealModel,
    required this.onSelected,
  });

  final RelatedDealsType type;
  final DealProductModel? dealModel;
  final HomePageController _homePageController = getIt<HomePageController>();
  final OnSelected onSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          dealModel == null
              ? _homePageController.getDealProducts(1, {"discount": "10"})
              : _homePageController.getRelatedDeals(dealModel!.id),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: getLoader());
        }
        if (snap.connectionState == ConnectionState.done && !snap.hasError) {
          List<DealProductModel> relatedDeals = snap.data!;
          if (relatedDeals.isEmpty) {
            return Container();
          }
          return type == RelatedDealsType.list
              ? listType(context, relatedDeals)
              : gridType(context, relatedDeals);
        }

        return Container();
      },
    );
  }

  Widget listType(BuildContext context, List<DealProductModel> relatedDeals) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "dont_miss_it".tr,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.all(20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: relatedDeals.length,
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SingleItemYouMayLikeList(
                dealProductModel: relatedDeals[i],
                isRelatedItem: true,
                onDetailsClicked: (d) {
                  onSelected(relatedDeals[i]);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget gridType(BuildContext context, List<DealProductModel> relatedDeals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "dont_miss_it".tr,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.all(20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: relatedDeals.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: .62,
          ),
          itemBuilder: (c, i) {
            DealProductModel item = relatedDeals[i];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: pushUpAnimation(
                InkWell(
                  onTap: () {
                    onSelected(item);
                    // Get.to(DealDetails(dealModel: item));
                  },

                  child: Card(
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: HexColor.fromHex("#F3F3F4"),
                        width: 0.5,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 132,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: HexColor.fromHex("#F4F4F4"),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),

                                  child: Center(
                                    child: Image.network(
                                      "$baseUrlImage/${item.product.productPictures.first.picture}",
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 10,
                                right: 10,
                                // child: InkWell(
                                //   onTap: () async {
                                //     if (item.isFavorite) {
                                //       buildRemoveFavourite(
                                //         context,
                                //         item,
                                //         () {},
                                //       );
                                //     } else {
                                //       _homePageController.addDeleteFav({
                                //         "retail_listing_id": item.id,
                                //       });
                                //     }
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       shape: BoxShape.circle,
                                //     ),
                                //     padding: EdgeInsets.all(8),
                                //     child:
                                //         item.isFavorite
                                //             ? SvgPicture.asset(
                                //               "assets/icons/fav.svg",
                                //               width: 15,
                                //             )
                                //             : Icon(
                                //               Icons.favorite_border,
                                //               color: HexColor.fromHex(
                                //                 AppTheme.textFieldBorder,
                                //               ),
                                //             ),
                                //   ),
                                // ),
                                child: FavouriteIcon(itemId: item.id),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item.retailPrice,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor.fromHex(
                                      AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                SvgPicture.asset(
                                  "assets/icons/sar.svg",
                                  width: 15,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: Row(
                              children: [
                                StarRating(
                                  rating: 1,
                                  starCount: 1,
                                  color: HexColor.fromHex("#FFC120"),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  item.product.avgRate == 0
                                      ? "--"
                                      : item.product.avgRate.toString(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: HexColor.fromHex("#1E1D33"),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: Text(
                              item.product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                color: HexColor.fromHex("#1E1D33"),
                              ),
                            ),
                          ),
                        ],
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
