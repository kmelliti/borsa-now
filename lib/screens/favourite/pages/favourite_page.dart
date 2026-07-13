import 'package:borsa_now_bis/core/widgets/favouriteIcon.dart';
import 'package:borsa_now_bis/screens/favourite/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/presentation/manager/home_page_controller.dart';
import '../../home_page/presentation/widgets/deal_details.dart';
import '../controller/favourite_controller.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  final FavouriteController controller = getIt<FavouriteController>();
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);
  final HomePageController _homePageController = getIt<HomePageController>();

  @override
  void didChangeDependencies() {
    print("didChange state called for fav");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    print("Init state called for fav");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, false),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 600),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: Opacity(
                    opacity: value,
                    child: Text(
                      "wish_list_and_favorites".tr,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: controller.getMyFavourites(),
              builder: (c, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: getLoader());
                }
                if (snap.connectionState == ConnectionState.done &&
                    !snap.hasError) {
                  List<FavouriteModel> favs = snap.data ?? [];
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.63,
                      ),
                      itemCount: favs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Get.to(() => DealDetails(dealId: favs[index].id));
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
                                  buildImageColorBuilder(favs, index),

                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          favs[index].retailPrice,
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
                                          favs[index].product.avgRate == 0
                                              ? "--"
                                              : favs[index].product.avgRate
                                                  .toString(),
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
                                      favs[index].product.name,
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
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            ValueListenableBuilder(
              valueListenable: isPageLoading,
              builder: (c, v, _) {
                if (v) {
                  return Expanded(child: Center(child: getLoader()));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageColorBuilder(List<FavouriteModel> favs, int index) {
    return Stack(
      children: [
        Container(
          height: 132,

          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: HexColor.fromHex("#F4F4F4")),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: Center(
              child: Image.network(
                "$baseUrlImage/${favs[index].product.productPictures.first.picture}",
              ),
            ),
          ),
        ),

        Positioned(
          top: 10,
          right: 10,
          child: FavouriteIcon(itemId: favs[index].id),
          // child: InkWell(
          //   onTap: (){
          //     buildRemoveFavourite(index);
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //    shape: BoxShape.circle,
          //     ),
          //     padding: EdgeInsets.all(8),
          //     child: SvgPicture.asset(
          //       "assets/icons/fav.svg",
          //       width: 15,
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  void buildRemoveFavourite(List<FavouriteModel> favs, int index) {
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

    Get.defaultDialog(
      backgroundColor: HexColor.fromHex("#F3F3F4"),

      titlePadding: EdgeInsets.zero,
      title: "",
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/remove_fav.svg",
              width: 50,
              height: 50,
            ),
            SizedBox(height: 30),
            Text(
              "are_you_sure_you_want_to_remove_this_favourite".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: HexColor.fromHex(AppTheme.primaryColor),
              ),
            ),
            SizedBox(height: 40),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, v, child) {
                return v
                    ? Center(child: getLoader())
                    : ElevatedButton(
                      onPressed: () async {
                        isLoading.value = true;

                        try {
                          _homePageController.addDeleteFav({
                            "retail_listing_id": favs[index].id,
                          });
                          isLoading.value = false;
                          Get.back();
                          setState(() {
                            favs.removeAt(index);
                          });
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar("error".tr, e.toString());
                        }
                      },
                      child: Text("yes_remove".tr),
                    );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("no_keep".tr),
              style: AppTheme.outlinedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
