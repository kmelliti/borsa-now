import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../config/utils.dart';
import '../di/di.dart';
import '../theme/app_theme.dart';

class FavouriteIcon extends StatelessWidget {
  FavouriteIcon({super.key, required this.itemId}){

    isFavourite = ValueNotifier(myFavourites.contains(itemId));

  }

  final int itemId;
  late final ValueNotifier<bool> isFavourite ;

  final HomePageController _homePageController = getIt();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: InkWell(
        onTap: () async {

          try {

            if(isFavourite.value){
           bool? res =  await  Get.defaultDialog(
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
                      ElevatedButton(
                        onPressed: () async{

                          Get.back(result: true);
                        },
                        child: Text("yes_remove".tr),
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
           if(res == null || !res)return;

              _homePageController.addDeleteFav({"retail_listing_id": itemId});
              myFavourites.remove(itemId);
              isFavourite.value = false;
            }else{
              _homePageController.addDeleteFav({"retail_listing_id": itemId});
              myFavourites.remove(itemId);
              isFavourite.value = true;
            }

          } catch (e) {
            Get.snackbar("error".tr, e.toString());
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          width: 35,
          height: 35,
          child:
              ValueListenableBuilder(
               valueListenable: isFavourite,
                builder: (context, val,_) {
                  return val
                      ? Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset("assets/icons/fav.svg", width: 15,height: 10,),
                      )
                      : Icon(
                        Icons.favorite_border,
                        color: HexColor.fromHex(AppTheme.textFieldBorder),
                        size: 25,
                      );
                }
              ),
        ),
      ),
    );
  }
}
