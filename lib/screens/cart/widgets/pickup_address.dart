import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/config/utils.dart';
import '../../../core/di/di.dart';
import '../../../core/models/product_pick_up_location_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../home_page/data/models/deal_product_model.dart';
import '../../home_page/presentation/manager/home_page_controller.dart';

typedef OnAddressSelected = void Function(int addressId, int productId);
class PickupAddress extends StatelessWidget {
  PickupAddress({super.key, required this.cartProducts});

  final List<DealProductModel> cartProducts;
  final HomePageController _controller = getIt();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: cartProducts.map((e) {
        return singlePickUpOrderLocation(e);
      }).toList(),
    );
  }

  Widget singlePickUpOrderLocation(DealProductModel product) {
    ValueNotifier<bool> shakeUp = ValueNotifier(false);
    int? selectedAddress ;

    return FutureBuilder(
      future: _controller.getPickUpLocations(product.productId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  LoadingAnimationWidget.waveDots(
              color: HexColor.fromHex(AppTheme.primaryColor),
                      size: 40,
                      ),
              ),
            ],
          );
        }
        if (snap.connectionState == ConnectionState.done &&! snap.hasError) {
          final List<ProductPickUpLocation> addresses = snap.data!;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),

            child: Column(
              children: [
                Text("${"select_product_pickup".tr} : ${product.product.name}"),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderGreyLight),
                    ),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: shakeUp,
                    builder: (context, v, child) {
                      return DropdownButton<int>(
                       //  decoration: InputDecoration(labelText: 'address'.tr),

                        value: selectedAddress,
                        hint: Text("address".tr),
                        underline: Container(),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),

                        items: addresses.map((e) {
                          return DropdownMenuItem(value: e.id, child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 200,
                                maxWidth: 200,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.address,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ));
                        }).toList(),
                        onChanged: (value) {
                           selectedAddress = value;
                           _controller.items.firstWhere((e)=> e['retail_listing_id'] == product.id)['location_id'] = value;
                          shakeUp.value = !shakeUp.value;
                        },

                      );
                    }
                  ),
                ),

              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
