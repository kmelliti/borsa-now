import 'dart:io';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/review_response_model.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/di/di.dart';
import '../../../../core/theme/app_theme.dart';

class RateProductWidget extends StatelessWidget {
  RateProductWidget({super.key, required this.productId});
  final String productId;

  final ValueNotifier<double> rate = ValueNotifier(5);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<List<XFile?>> images = ValueNotifier([]);
  final HomePageController _homePageController = getIt();

  final  _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "rate_product".tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: rate,
                  builder: (context, value, _) {
                    return StarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      size: 35,
                      rating: value,
                      onRatingChanged: (newRate) {
                        rate.value = newRate;
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "write_comment".tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "write_comment".tr;
                        }
                        return null;
                      },
                      controller: commentController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "write_comment".tr,
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: images,
                    builder: (context, value, _) {
                      return value.isEmpty
                          ? buildBtnImages(context)
                          : Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  List<XFile?> imgs = await _picker.pickMultiImage();
                                  if (imgs.isNotEmpty) {
                                    List<XFile?> oldList = images.value;
                                    oldList.addAll(imgs);
                                    images.value = [...oldList];
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.5),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: HexColor.fromHex("#D9D9D9"),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset("assets/icons/camera.svg", color: HexColor.fromHex(AppTheme.primaryColor),width: 15,),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: _buildImages(),
                                  ),
                                ),
                              )

                            ],
                          );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context,val,_) {
                return val ? Center(child: getLoader()) :ElevatedButton(
                  onPressed: ()async {
                    if (_formKey.currentState!.validate()) {
                      isLoading.value = true;
                      ReviewModel? review;

                      try{
                        review = await _homePageController.addReview(images.value.map((e) => e?.path).toList(), {
                          "product_id":productId,
                          "rate": rate.value,
                          "comment": commentController.text,
                        });
                        Get.back(result:review );
                      }catch(e,s){
                        handleException(context, e);

                      }
                      isLoading.value = false;

                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("publish_comment".tr),
                      SizedBox(width: 10),
                      SvgPicture.asset("assets/icons/send.svg", color: Colors.white),
                    ],
                  ),
                );
              }
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("close".tr),
              style: AppTheme.outlinedButtonStyle,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImages() {
    return images.value.map((e) {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: HexColor.fromHex("#D9D9D9"),
              borderRadius: BorderRadius.circular(5),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.file(File(e!.path), fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: InkWell(
                onTap: () {
                  List<XFile?> oldList = images.value;
                  oldList.remove(e);
                  images.value = [...oldList];


                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset("assets/icons/delete.svg",width: 15,),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget buildBtnImages(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        List<XFile?> imgs = await _picker.pickMultiImage();
        if (imgs.isNotEmpty) {
          images.value = imgs;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "upload_photos".tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: HexColor.fromHex(AppTheme.primaryColor),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10),
          SvgPicture.asset(
            "assets/icons/camera.svg",
            color: HexColor.fromHex(AppTheme.primaryColor),
            width: 15,
          ),
        ],
      ),
      style: AppTheme.filledButtonStyle.copyWith(
        backgroundColor: MaterialStateProperty.all(HexColor.fromHex("#DEDDFF")),
      ),
    );
  }
}
