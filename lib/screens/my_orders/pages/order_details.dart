import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/my_order_model.dart';
import 'package:borsa_now_bis/core/models/order_detail_model.dart';
import 'package:borsa_now_bis/screens/my_orders/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/config/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/data/models/review_response_model.dart';
import '../widgets/rate_product_widget.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late MyOrderModel o;

  final MyOrdersController _controller = getIt();

  @override
  void initState() {
    o = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, true),
      body: FutureBuilder(
        future: _controller.getOrderDetail(o.id),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: getLoader());
          }
          if (snap.connectionState == ConnectionState.done && !snap.hasError) {
            OrderDetailModel? detailModel = snap.data;
            if (detailModel == null) {
              return Container();
            }
            return Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "${"my_orders".tr} / ",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: HexColor.fromHex(AppTheme.hintColor2),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${"request_number".tr} ${detailModel.id}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: HexColor.fromHex(AppTheme.bold1),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: HexColor.fromHex(AppTheme.strokeS3),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  detailModel.status,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(width: 10),
                                Text(
                                  df.format(DateTime.now()),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textDate),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 40),
                            keyValueRow(context, "track_id".tr, "IW3475453455"),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                keyValueRow(
                                  context,
                                  "quantity".tr,
                                  detailModel.items
                                      .map((e) => e.quantity)
                                      .toString(),
                                ),
                                keyValueRow(
                                  context,
                                  "total".tr,
                                  detailModel.amountTotal,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ...detailModel.items.map(
                      (e) => Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: HexColor.fromHex(AppTheme.strokeS3),
                          ),
                        ),
                        child: Container(
                          height: 260,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: HexColor.fromHex("#F4F4F4"),
                                  color: Colors.red,

                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),

                                  child: Image.network(
                                    "$baseUrlImage/${e.retailListing.product.productPictures.first.picture}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  e.retailListing.product.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor.fromHex(AppTheme.textColor),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    getPriceInText(
                                      565.25,
                                      Theme.of(
                                        context,
                                      ).textTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: HexColor.fromHex(
                                          AppTheme.primaryColor,
                                        ),
                                        fontSize: 14,
                                      ),
                                      15,
                                    ),
                                    Spacer(),
                                    Text(
                                      "${"quantity".tr} : ",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.textColor,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      e.quantity.toString(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.primaryColor,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    buildTitle("request_info".tr),
                    SizedBox(height: 30),

                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: HexColor.fromHex(AppTheme.strokeS3),
                        ),
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
                                    Text(
                                      "payment_method".tr,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.textColor,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      detailModel.paymentMethod??"",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayLarge?.copyWith(
                                        color: HexColor.fromHex(
                                          AppTheme.textColor,
                                        ),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  "assets/icons/apple_pay.png",
                                  width: 80,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "total".tr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.textColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                getPriceInText(
                                 double.parse( detailModel.amountTotal),
                                  Theme.of(
                                    context,
                                  ).textTheme.displayLarge?.copyWith(
                                    color: HexColor.fromHex(
                                      AppTheme.primaryColor,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("reorder".tr),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              ReviewModel? review = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (c) {
                                  return RateProductWidget(productId: "");
                                },
                              );
                            },
                            child: Text("leave_comment".tr),
                            style: AppTheme.outlinedButtonStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Row keyValueRow(BuildContext context, String key, String value) {
    return Row(
      children: [
        Text(
          "$key: ",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: HexColor.fromHex("#5B5B5B"),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "$value",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: HexColor.fromHex(AppTheme.textColor),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
