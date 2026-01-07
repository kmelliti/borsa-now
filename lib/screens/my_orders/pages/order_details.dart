import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/config/app_constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/data/models/review_response_model.dart';
import '../widgets/rate_product_widget.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar2(context,true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("${"my_orders".tr} / ",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex(AppTheme.hintColor2),
                    fontSize: 20,
                  ),),
                  Text("${"request_number".tr} 1947034",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: HexColor.fromHex(AppTheme.bold1),
                    fontSize: 20,
                  ),)
                ],
              ),
              SizedBox(height: 20,),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: HexColor.fromHex(AppTheme.strokeS3)),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(

                        children: [
                          Text(
                            "delivered".tr,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          SizedBox(width: 10,),
                          Text(
                            df.format(DateTime.now()),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.textDate),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40,),
                      keyValueRow(context,"track_id".tr, "IW3475453455"),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          keyValueRow(context,"quantity".tr, "2454"),
                          keyValueRow(context,"total".tr, "2.236"),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: HexColor.fromHex(AppTheme.strokeS3)),
                ),
                child: Container(
                  height: 260,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(

                        height: 160,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#F4F4F4"),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("كولد برو بالتوت العليق والكريمة",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex(AppTheme.textColor),
                          fontSize: 16,
                        ),),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            getPriceInText(565.25, Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 14,
                            ),15),
                            Spacer(),
                            Text("${"quantity".tr} : ",style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.textColor),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),),
                            Text("54645",style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              buildTitle("request_info".tr),
              SizedBox(height: 30,),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: HexColor.fromHex(AppTheme.strokeS3)),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("payment_method".tr,style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: HexColor.fromHex(AppTheme.textColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),),
                              Text("Apple Pay",style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: HexColor.fromHex(AppTheme.textColor),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),)
                            ],
                          ),
                          Image.asset("assets/icons/apple_pay.png",width: 80,),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("total".tr,style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: HexColor.fromHex(AppTheme.textColor),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),),
                          getPriceInText(254,Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: HexColor.fromHex(AppTheme.primaryColor),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),15)

                        ],
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){}, child: Text("reorder".tr))),
                  SizedBox(width: 10,),
                  Expanded(child: ElevatedButton(onPressed: ()async{
                    ReviewModel? review = await  showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (c){

                          return RateProductWidget(productId: "",);
                        });
                  }, child: Text("leave_comment".tr),style: AppTheme.outlinedButtonStyle,))
                ],
              ),
              SizedBox(height: 20,),


            ],
          ),
        ),
      ),
    );
  }
  Row keyValueRow(BuildContext context ,String key, String value) {
    return Row(children: [
      Text("$key: ",style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: HexColor.fromHex("#5B5B5B"),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),),
      SizedBox(width: 10,),
      Text("$value",style: Theme.of(context).textTheme.displayLarge?.copyWith(
        color: HexColor.fromHex(AppTheme.textColor),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),),
    ]);
  }
}
