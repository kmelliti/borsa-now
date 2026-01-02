import 'dart:collection';
import 'dart:convert';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/lookup_model.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../di/di.dart';
import '../services/app_service.dart';

typedef FilterCallback = void Function(Map<String, dynamic> filters);

class Filters extends StatefulWidget {
  const Filters({super.key, required this.onFilter, required this.itemsCategory});

  final List<LookUpModel> itemsCategory;
  final FilterCallback onFilter;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  // List<LookUpModel> itemsCategory = [];
  RangeValues _currentPriceRangeValues = const RangeValues(0, 100);
  RangeValues _quantityRangeValues = const RangeValues(0, 50);
  RangeValues _reqQuantityRangeValues = const RangeValues(0, 20);
  bool discounted = false;
  // List<LookUpModel> selectedCategory = [];
  final ValueNotifier<HashSet<int>> rates = ValueNotifier(HashSet());
  final AppServices appServices = getIt();

  @override
  void initState() {
    rates.value.add(5);
    super.initState();

    // appServices.getProductCategories().then((v){
    //   // Future.delayed(Duration(milliseconds: 300), () {
    //   print("v: $v");
    //     addItems(v);
    //     print("itemsCategory: $itemsCategory");
    //   // });
    // });
  }

  // void addItems(List<LookUpModel> newItems) {
  //
  //
  //   for (int i = 0; i < newItems.length; i++) {
  //     // Future.delayed(Duration(milliseconds: i * 200), () {
  //       itemsCategory.add(newItems[i]);
  //       _listKey.currentState!.insertItem(itemsCategory.length - 1);
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            priceRange(),
            SizedBox(height: 10),
            quantityRange(),
            SizedBox(height: 10),
            _reqQuantityRange(),
            SizedBox(height: 10),
            getDiscounted(),
            SizedBox(height: 30),
            getCategoryFilter(),
            SizedBox(height: 30),
            pushUpAnimation(getUserRatings()),
          ],
        ),
      ),
    );
  }

  Widget getDiscounted() {
    return pushUpAnimation(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "applied_discount_products".tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: HexColor.fromHex("#1E1D33"),
                fontSize: 16,
              ),
            ),
            CupertinoSwitch(
              activeTrackColor: HexColor.fromHex(AppTheme.primaryColor),
              value: discounted,
              onChanged: (val) {
                setState(() {
                  discounted = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget priceRange() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: pushUpAnimation(
            Row(
              children: [
                Text(
                  "price_range".tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  _currentPriceRangeValues.end.roundToDouble().toStringAsFixed(
                    2,
                  ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(
                  "assets/icons/sar.svg",
                  width: 15,
                  color: HexColor.fromHex("#5B5B5B"),
                ),
                SizedBox(width: 10),
                Text("-"),
                SizedBox(width: 10),
                Text(
                  _currentPriceRangeValues.start
                      .roundToDouble()
                      .toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(
                  "assets/icons/sar.svg",
                  width: 15,
                  color: HexColor.fromHex("#5B5B5B"),
                ),
              ],
            ),
          ),
        ),
        bounceAnimation(
          c: RangeSlider(
            values: _currentPriceRangeValues,
            min: 0,
            max: 100,
            inactiveColor: HexColor.fromHex("#DEDDFF"),
            activeColor: HexColor.fromHex(AppTheme.primaryColor),
            labels: RangeLabels(
              RangeValues(0, 100).start.roundToDouble().toString(),
              RangeValues(0, 100).end.roundToDouble().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _currentPriceRangeValues = values;
              });
              print(
                'RangeSlider values changed: ${values.start.roundToDouble()} -> ${values.end.roundToDouble()}',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget quantityRange() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: pushUpAnimation(
            Row(
              children: [
                Text(
                  "available_quantity".tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  _quantityRangeValues.end.toInt().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),

                SizedBox(width: 10),
                Text("-"),
                SizedBox(width: 10),
                Text(
                  _quantityRangeValues.start.toInt().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
        bounceAnimation(
          c: RangeSlider(
            values: _quantityRangeValues,
            min: 0,
            max: 100,
            inactiveColor: HexColor.fromHex("#DEDDFF"),
            activeColor: HexColor.fromHex(AppTheme.primaryColor),
            labels: RangeLabels(
              RangeValues(0, 100).start.roundToDouble().toString(),
              RangeValues(0, 100).end.roundToDouble().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _quantityRangeValues = values;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _reqQuantityRange() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: pushUpAnimation(
            Row(
              children: [
                Text(
                  "min_req_quantity".tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  _reqQuantityRangeValues.end.toInt().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),

                SizedBox(width: 10),
                Text("-"),
                SizedBox(width: 10),
                Text(
                  _reqQuantityRangeValues.start.toInt().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5B5B5B"),
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
        bounceAnimation(
          c: RangeSlider(
            values: _reqQuantityRangeValues,
            min: 0,
            max: 100,
            inactiveColor: HexColor.fromHex("#DEDDFF"),
            activeColor: HexColor.fromHex(AppTheme.primaryColor),
            labels: RangeLabels(
              RangeValues(0, 100).start.roundToDouble().toString(),
              RangeValues(0, 100).end.roundToDouble().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _reqQuantityRangeValues = values;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget getBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor.fromHex("#F9F8FF"),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ElevatedButton(onPressed: () {

            Map<String,dynamic> filters = {
              // "quantity_min": jsonEncode(_quantityRangeValues.start),
              // "quantity_max": jsonEncode(_quantityRangeValues.end),
              // "price_max": jsonEncode(_currentPriceRangeValues.end),
              // "price_min": jsonEncode(_currentPriceRangeValues.start),
              // "invest_min": jsonEncode(_reqQuantityRangeValues.start),
              // "invest_max": jsonEncode(_reqQuantityRangeValues.end),
              // "discount": jsonEncode(discounted ? 1 :0),
              // "rates": jsonEncode(rates.value.map((r)=>r).toList()),
              // "categories": jsonEncode(widget.itemsCategory.where((s) => s.selected == true).toList().map((lm) => lm.id).toList()),
            };

            List categoriesIds = widget.itemsCategory.where((s) => s.selected == true).toList().map((lm) => lm.id).toList();
            if (categoriesIds.length > 0) {
              Map<String, dynamic> s = filters ?? Map();
              s["categories"] = jsonEncode(categoriesIds);

              filters = s;
            }






            widget.onFilter(filters);
            Get.back();

          }, child: Text("apply_filers".tr)),
          TextButton(
            onPressed: () {},
            child: Text(
              "reset_filters".tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: HexColor.fromHex(AppTheme.primaryColor),
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getCategoryFilter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "category".tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: HexColor.fromHex("#1E1D33"),
              fontSize: 16,
            ),
          ),

          SizedBox(height: 10),
          Container(
            height: 40,

            child: AnimatedList(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              key: _listKey,
              initialItemCount: widget.itemsCategory.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: widget.itemsCategory[index].selected
                              ? HexColor.fromHex("#DEDDFF")
                              : Colors.white,
                      border: Border.all(
                        color: HexColor.fromHex(AppTheme.borderGrey),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: InkWell(
                      onTap: () {
                        setState(() {

                          widget.itemsCategory[index].selected = !widget.itemsCategory[index].selected;

                          // if(selectedCategory.contains(widget.itemsCategory[index]))
                          // selectedCategory.remove(widget.itemsCategory[index]);
                          // else
                          // selectedCategory.add(widget.itemsCategory[index]);
                        });
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.itemsCategory[index].name),
                            SizedBox(width: widget.itemsCategory[index].selected ? 10 : 0,),
                            widget.itemsCategory[index].selected
                                ? Icon(
                                  Icons.check,
                                  color: HexColor.fromHex(
                                    AppTheme.primaryColor,
                                  ),
                                )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserRatings() {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "user_ratings".tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: HexColor.fromHex("#1E1D33"),
              fontSize: 16,
            ),
          ),

          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: rates,
            builder: (context,r,_) {
              return GridView.builder(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 3
                ),
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          HashSet<int> set = HashSet.from(rates.value);
                          set.contains(i+1) ? set.remove(i+1) : set.add(i+1);
                          rates.value = HashSet.from(set);
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: rates.value.contains(i+1) ? HexColor.fromHex(AppTheme.primaryColor) : Colors.white,
                            border: rates.value.contains(i+1) ? Border.all(color: HexColor.fromHex(AppTheme.primaryColor)) : Border.all(color: HexColor.fromHex(AppTheme.textFieldBorder)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: StarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            size: 25,
                            rating: i+1,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
