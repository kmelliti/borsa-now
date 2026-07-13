import 'dart:developer';

import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/review_response_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/time_ago.dart';
import '../../../my_orders/widgets/rate_product_widget.dart';
import '../manager/home_page_controller.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key, required this.productId});
  final String productId;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final HomePageController _homePageController = getIt();
  List<ReviewModel> reviews = [];

  @override
  void initState() {
    log(widget.productId);
    _homePageController.getReviews(widget.productId).then((value) {

      setState(() {
        reviews = value.reviews;
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: reviews.length,
          itemBuilder: (context, index) => singleReview(context,reviews[index]),
        ),


       reviews.isNotEmpty ? Container(
          margin: EdgeInsets.only(top: 10,bottom: 20),
          child: InkWell(
            onTap: () {},
            child: Text(
              "show_more".tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: HexColor.fromHex(AppTheme.primaryColor),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ): SizedBox(height: 20,),

        InkWell(
            onTap: () async {
             ReviewModel? review = await  showModalBottomSheet(context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (c){

                return RateProductWidget(productId: widget.productId,);
              });
             if(review != null){
               setState(() {
                 reviews.add(review);
               });
             }
            },
            child: commentHolder()),

      ],
    );
  }

  Container singleReview(BuildContext context,ReviewModel review) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                "$baseUrlImage/${review.user.picture}",
              ),
            ),
            title: Text(review.user.name,style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: HexColor.fromHex('#1E1D33'),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [StarRating(rating: review.rate.toDouble(), size: 20)],
            ),
            trailing: Text(
              TimeAgo.since(review.createdAt),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: HexColor.fromHex(AppTheme.darkGrey),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            review.comment,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: HexColor.fromHex('#1E1D33'),
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

  Widget commentHolder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "write_comment".tr,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset("assets/icons/attachement.svg"),
          ),

          SizedBox(width: 15),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset("assets/icons/send.svg"),
          ),
        ],
      ),
    );
  }
}
