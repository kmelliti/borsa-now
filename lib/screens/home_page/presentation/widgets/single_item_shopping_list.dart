import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/favouriteIcon.dart';
import '../../data/models/deal_product_model.dart';
import '../manager/home_page_controller.dart';

typedef OnDetailsClicked = void Function(DealProductModel dealProductModel);

class SingleItemYouMayLikeList extends StatelessWidget {
   SingleItemYouMayLikeList({
    super.key,
    required this.dealProductModel,
    this.isRelatedItem = false,
   required this.onDetailsClicked,
  });

  final DealProductModel dealProductModel;
  final bool isRelatedItem;

  final OnDetailsClicked onDetailsClicked;
  final HomePageController _homePageController = getIt<HomePageController>();
  final ValueNotifier<bool> shakeUp = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: shakeUp,
      builder: (context,_,__) {
        return InkWell(
          onTap: (){
            onDetailsClicked(dealProductModel);
          },
          child: Card(
            elevation: 0.1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                //  border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(context),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            getPriceInText(
                              double.parse(dealProductModel.retailPrice),
                              TextStyle(
                                color: HexColor.fromHex(AppTheme.primaryColor),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),14
                            ),
                            // SizedBox(width: 10),
                            // getDiscountedPriceInText(
                            //   double.parse(dealProductModel.retailPrice),
                            //   context,
                            // ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [

                            StarRating(
                              rating: 1,
                              starCount: 1,
                              color: HexColor.fromHex("#FFC120"),
                            ),
                            SizedBox(width: 5,),
                             Text(dealProductModel.product.avgRate == 0 ? "--" :dealProductModel.product.avgRate.toString() ,style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: HexColor.fromHex("#1E1D33"),
                            ),),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          dealProductModel.product.description,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex(AppTheme.textColor),
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Stack header(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: getDominantColor(
            "${baseUrlImage}${dealProductModel.product.productPictures.first.picture}",
          ),
          builder: (context, snap) {
            return Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: snap.data,

                //color: HexColor.fromHex("#EFEFE3"),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "${baseUrlImage}${dealProductModel.product.productPictures.first.picture}",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 20,
          left: 20,
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
        Positioned(
          top: 20,
          right: 20,
          child: FavouriteIcon(itemId: dealProductModel.id),
          // child: InkWell(
          //   onTap: ()async{
          //     if(dealProductModel.isFavorite){
          //
          //       buildRemoveFavourite(context,dealProductModel,(){
          //         dealProductModel.isFavorite = false;
          //         shakeUp.value = !shakeUp.value;
          //       });
          //
          //     }else{
          //        _homePageController.addDeleteFav({
          //         "retail_listing_id":dealProductModel.id,
          //       });
          //       dealProductModel.isFavorite = true;
          //       shakeUp.value = !shakeUp.value;
          //
          //     }
          //
          //
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       shape: BoxShape.circle,
          //     ),
          //     padding: EdgeInsets.all(8),
          //     child: dealProductModel.isFavorite ? SvgPicture.asset(
          //       "assets/icons/fav.svg",
          //       width: 15,
          //     ) : Icon(Icons.favorite_border,color: HexColor.fromHex(AppTheme.textFieldBorder),size: 15,),
          //   ),
          // ),
        )
      ],
    );
  }
}
