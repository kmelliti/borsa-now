import 'package:borsa_now_bis/screens/favourite/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_color_builder/image_color_builder.dart';

import '../../../../core/config/utils.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/presentation/manager/home_page_controller.dart';
import '../controller/favourite_controller.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  List<FavouriteModel> favs = [];
  final FavouriteController controller = getIt<FavouriteController>();
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(false);
  final HomePageController _homePageController = getIt<
      HomePageController>();

  @override
  void initState() {
    isPageLoading.value = true;
    controller.getMyFavourites().then((value) {
      setState(() {
        favs = value;
      });
      isPageLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, true),
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
            ValueListenableBuilder(valueListenable: isPageLoading, builder: (c,v,_){
              if(v){
                return Expanded(
                  child: Center(
                    child: getLoader(),
                  ),
                );
              }else{
                return Container();
              }
            }),
            favs.isNotEmpty
                ? Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.58,
                    ),
                    itemCount: favs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: HexColor.fromHex("#F3F3F4"),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildImageColorBuilder(index),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Text(favs[index].wholesalePrice,style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor.fromHex(AppTheme.primaryColor),
                                    ),),
                                    SizedBox(width: 5),
                                    SvgPicture.asset(
                                      "assets/icons/sar.svg",
                                      width: 15,
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Row(
                                  children: [

                                    StarRating(
                                      rating: 1,
                                      starCount: 1,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("4.5",style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor.fromHex("#1E1D33"),
                                    ),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child:     Text(favs[index].product.name,maxLines :1 , overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor.fromHex("#1E1D33"),
                                ),),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildImageColorBuilder(int index) {
    return Stack(
      children: [
        ImageColorBuilder(
          url: "$baseUrlImage/${favs[index].product.productPictures.first.picture}",
          placeholder: (c,s) {
            return Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: HexColor.fromHex("#F4F4F4"),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
              ),
            );
          },
          builder: (c, image, color) {
            return Container(
              height: 150,
              width: 150,

              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: HexColor.fromHex("#F4F4F4")),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Center(child: image),
              ),
            );
          },
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: (){
              buildRemoveFavourite(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
             shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(
                "assets/icons/fav.svg",
                width: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  void buildRemoveFavourite(int index) {
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
            SizedBox(height: 30,),
            Text("are_you_sure_you_want_to_remove_this_favourite".tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(AppTheme.primaryColor),
            ),),
            SizedBox(height: 40,),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context,v,child) {
                return v ? Center(child: getLoader(),) : ElevatedButton(
                  onPressed: () async{
                    isLoading.value = true;

                    try{
                      await _homePageController.addDeleteFav({
                        "wholesale_offer_id":favs[index].id,
                      });
                      isLoading.value = false;
                      Get.back();
                      setState(() {
                        favs.removeAt(index);
                      });
                    }catch(e){
                      isLoading.value = false;
                      Get.snackbar("error".tr, e.toString());
                    }

                  },
                  child: Text("yes_remove".tr),
                );
              }
            ),
            SizedBox(height: 20,),
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
