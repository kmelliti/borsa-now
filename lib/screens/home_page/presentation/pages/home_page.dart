import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/lookup_model.dart';
import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/deal_product_model.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/single_item_shopping_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/di/di.dart';
import '../../../../core/widgets/filters.dart';
import '../widgets/brands_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/deal_details.dart';
import '../widgets/promos_widget.dart';
import '../widgets/single_item_shopping_list.dart';

ValueNotifier<bool> promosLoading = ValueNotifier(false);
ValueNotifier<bool> categoriesLoading = ValueNotifier(false);
ValueNotifier<bool> brandsLoading = ValueNotifier(false);

List promos = [];
List<LookUpModel> categories = [];
List<BrandModel> brands = [];

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = getIt<HomePageController>();

  // ValueNotifier<Map<String,dynamic>> filters = ValueNotifier(Map());
  ValueNotifier<Map<String,dynamic>?> filters = ValueNotifier(null);


  late final _pagingController =  PagingController<int, DealProductModel>(
    // getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _homePageController.getDealProducts(pageKey, filters.value),

  );

  @override

  Future<void> fetchPromos() async {

    promosLoading.value = true;
    promos = await _homePageController.getPromos();
    promosLoading.value = false;

  }

  Future<void> fetchCategories() async {

    categoriesLoading.value = true;
    categories = await _homePageController.getCategories();
    categoriesLoading.value = false;

  }

  Future<void> fetchBrands() async {

    brandsLoading.value = true;
    brands = await _homePageController.getBrands();
    print("brands: $brands");
    brandsLoading.value = false;

  }

  void initState() {


    // Map<String, dynamic> s = {
    //   // "categories": Uri.encodeComponent(jsonEncode([1])),
    //   "categories": jsonEncode([1]),
    // };
    //
    // filters.value = s;


    fetchPromos();
    fetchCategories();
    fetchBrands();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppBar(context,null,(v){
        log("$v");
        filters.value = {
          "product_name":v
        };
        _pagingController.refresh();
      }),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 40),
                  // Animated search bar
                  AnimatedContainer(
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOutQuart,
                    // padding: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: searchArea(),
                  ),
                  SizedBox(height: 20),


                  /**********************************************************************/
                  ValueListenableBuilder(
                      valueListenable: promosLoading,
                      builder: (context, isLoading, _) {
                        return isLoading ?
                        // SizedBox(
                        //     height: 126,
                        //     child: Center(
                        //         child: CircularProgressIndicator()
                        //     )
                        // ) :
                        ShimmerPromoWidget():
                        PromosWidget(promos: promos,);
                      }
                  ),

                  /**********************************************************************/

                  SizedBox(height: 20),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("الفئات", style: Theme.of(context,)
                            .textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          // color: Colors.white,
                        ),),
                        SizedBox(width: 10,),
                        SvgPicture.asset("assets/icons/arrow.svg", width: 14, height: 12),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ValueListenableBuilder(
                      valueListenable: categoriesLoading,
                      builder: (context, isLoading, _) {
                        return isLoading ?
                        ShimmerFilterWidget() :
                        CategoriesWidget(categories: categories, onItemClicked: (idsList) {

                          if (idsList.length > 0) {
                            Map<String, dynamic> s = filters.value ?? Map();
                            s["categories"] = jsonEncode(idsList);

                            filters.value = s;
                          }
                          else {
                            filters.value?.remove('categories');
                          }

                          if (filters.value != null) {
                            if (filters.value!.isEmpty)
                              filters.value = null;
                          }

                          _pagingController.refresh();

                        },);
                      }
                  ),

                  SizedBox(height: 40),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("التجار الرائجون", style: Theme.of(context,)
                            .textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          // color: Colors.white,
                        ),),
                        SizedBox(width: 10,),
                        SvgPicture.asset("assets/icons/arrow.svg", width: 14, height: 12),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ValueListenableBuilder(
                      valueListenable: brandsLoading,
                      builder: (context, isLoading, _) {
                        return isLoading ?
                        ShimmerFilterWidget() :
                        BrandsWidget(brands: brands, onItemClicked: (idsList) {

                          if (idsList.length > 0) {
                            Map<String, dynamic> s = filters.value ?? Map();
                            s["brands"] = jsonEncode(idsList);

                            filters.value = s;
                          }
                          else {
                            filters.value?.remove('brands');
                          }

                          if (filters.value != null) {
                            if (filters.value!.isEmpty)
                              filters.value = null;
                          }

                          _pagingController.refresh();

                        },);
                      }
                  ),




                  /**********************************************************************/

                ],
              ),
            ),




            SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: PagingListener(
                controller: _pagingController,
                builder: (context, state, fetchNext) => PagedSliverGrid<int, DealProductModel>(
                  // Provide state and fetch logic from your controller
                  state: _pagingController.value,
                  fetchNextPage: _pagingController.fetchNextPage,

                  // Define your grid layout (e.g., 2 columns)
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .56,
                  ),

                  // Build your grid tiles
                  builderDelegate: PagedChildBuilderDelegate<DealProductModel>(
                    itemBuilder: (context, item, index) => pushUpAnimation(InkWell(
                        onTap: (){
                          Get.to(DealDetails(dealModel: item));
                        },
                        child: SingleItemShoppingGrid(dealProductModel: item, onFavouriteClicked: () {

                          _homePageController.addDeleteFav({
                            "wholesale_offer_id":item.id,
                          });





                        },))),
                  ),
                ),
              ),
            ),




          ],

        ),
      ),



    );
  }

  Widget searchArea() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: HexColor.fromHex(AppTheme.borderGrey),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search_by_product_name".tr,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ).applyDefaults(Theme.of(context).inputDecorationTheme),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: InkWell(
                            onTap: () {},
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                                key: ValueKey('search_icon'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ValueListenableBuilder(
                  valueListenable: filters,
                  builder: (context,f,_) {
                    return GestureDetector(
                      onTapDown: (details) {
                        // This will be used for the tap effect
                        // if(f!= null){
                        //   filters.value = Map();
                        //   return;
                        // }
                        showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery
                                .of(context)
                                .size
                                .height * 0.9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          context: context,
                          builder: (context) {
                            return Filters(itemsCategory: categories, onFilter: (Map<String, dynamic> f) {


                              filters.value = f;
                              _pagingController.refresh();

                              if (filters.value != null) {
                                if (filters.value!.isEmpty)
                                  filters.value = null;
                              }

                              setState(() {

                              });

                            },);
                          },
                        );
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 1.0 + (value * 0.1),
                            child:f != null ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(AppTheme.primaryColor),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: HexColor.fromHex(AppTheme.borderGrey),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: HexColor.fromHex(
                                      AppTheme.primaryColor,
                                    ).withOpacity(0.2 * (1 - value)),
                                    spreadRadius: 2 * (1 - value),
                                    blurRadius: 6 * (1 - value),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${"reset_filters".tr}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SvgPicture.asset("assets/icons/filters.svg",color: Colors.white,),
                                ],
                              ),
                            ):Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(AppTheme.filledBox),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: HexColor.fromHex(AppTheme.borderGrey),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: HexColor.fromHex(
                                      AppTheme.primaryColor,
                                    ).withOpacity(0.2 * (1 - value)),
                                    spreadRadius: 2 * (1 - value),
                                    blurRadius: 6 * (1 - value),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset("assets/icons/filters.svg"),
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




