import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/deal_product_model.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';


class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final HomePageController _controller = getIt();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  void _removeItem(int index) {
    // Animate the removal of the item
    final removedItem = _controller.cartProducts.value.removeAt(index);

    _listKey.currentState?.removeItem(index, (context, animation) {
        return _buildItem(removedItem, context, animation);
      },
    );

    setState(() {
      _controller.cartProducts.value = [..._controller.cartProducts.value];
    });



  }

  Widget _buildItem(DealProductModel item, BuildContext context, Animation<double> animation) {
    // Fade out the item as it is removed


    return FadeTransition(
      opacity: animation,

      child: Container(
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
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: 92,
                      height: 92,

                      decoration: BoxDecoration(
                        color: HexColor.fromHex(AppTheme.filledBox),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network("${baseUrlImage}${item.product.productPictures.first.picture}",fit: BoxFit.fill,)
                      ),

                      // Image.network("${baseUrlImage}${list[i].product.productPictures.first.picture}", fit: BoxFit.cover),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      // flex: 4,
                      child: Container(
                        height: 90,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(item.product.name),

                            Text(item.product.description ,maxLines: 1,),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // list.removeAt(i);
                        // _controller.cartProducts.value = [...list];

                        item.cartQuantity = 1;
                        _removeItem(_controller.cartProducts.value.indexOf(item));

                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                        ),
                        child: Icon(Icons.delete_outline_outlined,color: Colors.red,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getPriceInText( double.tryParse(item.retailPrice) as double, Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: HexColor.fromHex(AppTheme.primaryColor),
                        fontSize: 16
                    ),12),
                    Spacer(),
                    InkWell(
                      onTap: () {

                        item.cartQuantity++;
                        _controller.cartProducts.value = [..._controller.cartProducts.value];

                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                        ),
                        child: Icon(Icons.add,color: HexColor.fromHex(AppTheme.primaryColor),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(item.cartQuantity.toString()),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: item.cartQuantity > 1 ? () {

                        if (item.cartQuantity > 1) {
                          item.cartQuantity--;
                          _controller.cartProducts.value = [..._controller
                              .cartProducts.value
                          ];
                        }

                      } : null,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: HexColor.fromHex(AppTheme.stroke))
                        ),
                        child: Opacity(
                            opacity: item.cartQuantity > 1 ? 1 : .2,
                            child: Icon(Icons.remove,color: HexColor.fromHex(AppTheme.primaryColor),)
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(context,true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle("my_orders".tr),
              SizedBox(height: 20,),
              ValueListenableBuilder(
                  valueListenable: _controller.cartProducts,
                  builder: (context,list,_) {

                    return AnimatedList(
                      key: _listKey,
                      initialItemCount: list.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index, animation) {
                        return _buildItem(list[index], context, animation);
                      },
                    );

                  }
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Offstage(
        offstage: _controller.cartProducts.value.length == 0,
        child: InkWell(
          onTap: () {
            print("payment");
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: HexColor.fromHex(AppTheme.primaryColor),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:  30.0),
                child: Row(
                  children: [
                    Expanded(child: Text("complete_payment".tr, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 16
                    ),)),
                    Builder(
                        builder: (context) {
                          double total = 0;
                          _controller.cartProducts.value.forEach((DealProductModel item) {
                            total += double.tryParse(item.retailPrice) as double;
                          });
                          // return Text(total.toString());
                          return getPriceInText( total, Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 16
                          ),12);
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
