import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/models/my_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/utils.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';

class SingleOrder extends StatelessWidget {
  const SingleOrder({super.key, required this.order});

  final MyOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: HexColor.fromHex(AppTheme.strokeS3))),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.status.tr,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  df.format(order.createdAt),
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: HexColor.fromHex(AppTheme.textDate), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 10),
            keyValueRow(context, "order_id".tr, order.id.toString()),
            // SizedBox(height: 10,),
            // keyValueRow(context,"track_id".tr, "IW3475453455"),
            SizedBox(height: 10),
           keyValueRow(context, "pickup_location".tr, getLocationString()),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: keyValueRow(context, "quantity".tr, order.items.map((e) => e.quantity).toString())),
                Expanded(child: keyValueRow(context, "total".tr, order.amountTotal)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.orderDetails, arguments: order);
              },
              child: Text("details".tr),
              style: AppTheme.outlinedButtonStyle,
            ),
          ],
        ),
      ),
    );
  }

  Row keyValueRow(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$key: ",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: HexColor.fromHex("#5B5B5B"), fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            "$value",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: HexColor.fromHex(AppTheme.textColor),
              fontSize: 14,
              overflow: TextOverflow.ellipsis,

              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  String getLocationString() {
    if (order.items.length == 1) {
      return "${order.items.first.location?.address ?? "not_found".tr}";
    }
    return "multiple_locations".tr;
  }
}
