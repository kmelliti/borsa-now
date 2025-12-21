import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/utils.dart';
import '../../../core/theme/app_theme.dart';

class SingleOrder extends StatelessWidget {
  const SingleOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Text(
                  "delivered".tr,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
            SizedBox(height: 10,),
            keyValueRow(context,"order_id".tr, "1947034"),
            SizedBox(height: 10,),
            keyValueRow(context,"track_id".tr, "IW3475453455"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                keyValueRow(context,"quantity".tr, "2454"),
                keyValueRow(context,"total".tr, "2.236"),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Text("details".tr),style: AppTheme.outlinedButtonStyle,)
          ],
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
