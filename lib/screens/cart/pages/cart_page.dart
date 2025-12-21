import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';

class CartPage extends StatelessWidget {
   CartPage({super.key});
  final HomePageController _controller = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar2(context,true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle("my_orders".tr),
            SizedBox(height: 20,),
            ValueListenableBuilder(
              valueListenable: _controller.cartProducts,
              builder: (context,list,_) {
                return ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (c,i){

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: HexColor.fromHex(AppTheme.stroke))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(

                                      flex:2,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: HexColor.fromHex(AppTheme.filledBox),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: FlutterLogo(),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        height: 90,

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text("store name"),

                                            Text("كولد برو بالتوت العليق والكريمة",maxLines: 1,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                                            ),
                                            child: Icon(Icons.delete_outline_outlined,color: Colors.red,),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    getPriceInText(250,Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: HexColor.fromHex(AppTheme.primaryColor),
                                      fontSize: 16
                                    ),12),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                                      ),
                                      child: Icon(Icons.add,color: HexColor.fromHex(AppTheme.primaryColor),),
                                    ),
                                    SizedBox(width: 10,),
                                    Text("1"),
                                    SizedBox(width: 10,),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                                      ),
                                      child: Icon(Icons.remove,color: HexColor.fromHex(AppTheme.primaryColor),),
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                });
              }
            )
          ],
        ),
      ),

    );
  }
}
