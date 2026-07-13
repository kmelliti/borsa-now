import 'dart:convert';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/lookup_model.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/core/widgets/favouriteIcon.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/ad_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/deal_product_model.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/widgets/filters.dart';
import '../widgets/brands_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/deal_details.dart';
import '../widgets/list_related_deals.dart';
import '../widgets/promos_widget.dart';

ValueNotifier<bool> promosLoading = ValueNotifier(false);
ValueNotifier<bool> categoriesLoading = ValueNotifier(false);
ValueNotifier<bool> brandsLoading = ValueNotifier(false);

List<AdModel> promos = [];
List<LookUpModel> categories = [];
List<BrandModel> brands = [];

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = getIt<HomePageController>();
  TextEditingController _searchController = TextEditingController();

  // ValueNotifier<Map<String,dynamic>> filters = ValueNotifier(Map());
  final ValueNotifier<Map<String, dynamic>?> filters = ValueNotifier(null);

  late final _pagingController = PagingController<int, DealProductModel>(
    // getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    getNextPageKey:
        (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage:
        (pageKey) =>
            _homePageController.getDealProducts(pageKey, filters.value),
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

  @override
  void initState() {
    // Map<String, dynamic> s = {
    //   // "categories": Uri.encodeComponent(jsonEncode([1])),
    //   "categories": jsonEncode([1]),
    // };
    //
    // filters.value = s;


    getApproxLocation();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((c) {
      fetchPromos();
      fetchCategories();
      fetchBrands();
    });
    final AppServices appServices = getIt();

    print("USer token ${appServices.getToken()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, null, (v) {
        _searchController.text = v;

        if (v.isEmpty) {
          filters.value = null;
          _pagingController.refresh();
          return;
        }
        filters.value = {"product_name": v};
        _pagingController.refresh();
      }),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: SizedBox(
                          height: !isLoading && promos.length > 0 ? null : 0,
                          //  isLoading ? 0 : null,
                          child: PromosWidget(promos: promos),
                        ),
                      );


                    },
                  ),

                  /**********************************************************************/
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "category_list".tr,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            // color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          "assets/icons/arrow.svg",
                          width: 14,
                          height: 12,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ValueListenableBuilder(
                    valueListenable: filters,
                    builder: (context,_,__) {
                      return ValueListenableBuilder(
                        valueListenable: categoriesLoading,
                        builder: (context, isLoading, _) {
                          return isLoading
                              ? ShimmerFilterWidget()
                              : CategoriesWidget(


                                categories: categories,
                                onItemClicked: (idsList) {
                                  if (idsList.length > 0) {
                                    Map<String, dynamic> s = filters.value ?? Map();
                                    s["categories"] = jsonEncode(idsList);

                                    filters.value = s;
                                  } else {
                                    filters.value?.remove('categories');
                                  }

                                  if (filters.value != null) {
                                    if (filters.value!.isEmpty)
                                      filters.value = null;
                                  }

                                  _pagingController.refresh();
                                },
                              );
                        },
                      );
                    }
                  ),

                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "brands".tr,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            // color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          "assets/icons/arrow.svg",
                          width: 14,
                          height: 12,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ValueListenableBuilder(
                    valueListenable: filters,
                    builder: (context,_,__) {
                      return ValueListenableBuilder(
                        valueListenable: brandsLoading,
                        builder: (context, isLoading, _) {
                          return isLoading
                              ? ShimmerFilterWidget()
                              : BrandsWidget(
                                brands: brands,
                                onItemClicked: (idsList) {
                                  if (idsList.length > 0) {
                                    Map<String, dynamic> s = filters.value ?? Map();
                                    s["brands"] = jsonEncode(idsList);

                                    filters.value = s;
                                  } else {
                                    filters.value?.remove('brands');
                                  }

                                  if (filters.value != null) {
                                    if (filters.value!.isEmpty)
                                      filters.value = null;
                                  }

                                  _pagingController.refresh();
                                },
                              );
                        },
                      );
                    }
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: PagingListener(
                controller: _pagingController,
                builder:
                    (context, state, fetchNext) =>
                        PagedGridView<int, DealProductModel>(
                          // Provide state and fetch logic from your controller
                          state: _pagingController.value,
                          fetchNextPage: _pagingController.fetchNextPage,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),

                          // Define your grid layout (e.g., 2 columns)
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: .69,
                              ),

                          // Build your grid tiles
                          builderDelegate:
                              PagedChildBuilderDelegate<DealProductModel>(
                                itemBuilder:
                                    (context, item, index) => pushUpAnimation(
                                      singleITem(item, context),
                                    ),
                                noItemsFoundIndicatorBuilder:
                                    (context) =>
                                        Center(child: Text("noItemFound".tr)),
                              ),
                        ),
              ),
            ),
            SizedBox(height: 10),
            RelatedDeals(
              type: RelatedDealsType.list,
              onSelected: (DealProductModel dealModel) {
                Get.to(() => DealDetails(dealModel: dealModel));
              },
            ),
          ],
        ),
      ),
    );
  }

  InkWell singleITem(DealProductModel item, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => DealDetails(dealModel: item));
      },

      child: Card(
        elevation: 0.1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 132,

                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: HexColor.fromHex("#F4F4F4"),
                      ),
                    ),
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(20),

                      child: Image.network("$baseUrlImage/${item.product.productPictures.first.picture}",fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    // child: InkWell(
                    //   onTap: () async {
                    //     if (item.isFavorite) {
                    //       buildRemoveFavourite(context, item, () {
                    //         _pagingController.refresh();
                    //       });
                    //     } else {
                    //       _homePageController.addDeleteFav({
                    //         "retail_listing_id": item.id,
                    //       });
                    //       _pagingController.refresh();
                    //     }
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     padding: EdgeInsets.all(8),
                    //     child:
                    //         item.isFavorite
                    //             ? SvgPicture.asset(
                    //               "assets/icons/fav.svg",
                    //               width: 15,
                    //             )
                    //             : Icon(
                    //               Icons.favorite_border,
                    //               size: 15,
                    //               color: HexColor.fromHex(
                    //                 AppTheme.textFieldBorder,
                    //               ),
                    //             ),
                    //   ),
                    // ),
                    child: FavouriteIcon(itemId: item.id),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      item.retailPrice,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HexColor.fromHex(AppTheme.primaryColor),
                      ),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      "assets/icons/sar.svg",
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  children: [
                    StarRating(
                      rating: 1,
                      starCount: 1,
                      color: HexColor.fromHex("#FFC120"),
                    ),
                    SizedBox(width: 5),
                    Text(
                      item.product.avgRate == 0
                          ? "--"
                          : item.product.avgRate.toString(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: HexColor.fromHex("#1E1D33"),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: HexColor.fromHex("#1E1D33"),
                  ),
                ),
              ),
            ],
          ),
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
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search_by_product_name".tr,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ).applyDefaults(
                                Theme.of(context).inputDecorationTheme,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: InkWell(
                            onTap: () {
                              if (_searchController.text.isEmpty) {
                                return;
                              }
                              print("Called here with the product name ${_searchController.text}");
                              filters.value = {"product_name": _searchController.text};
                              _pagingController.refresh();
                            },
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
                  builder: (context, f, _) {
                    return GestureDetector(
                      onTapDown: (details) {
                        if (filters.value != null) {
                         categories.forEach((e)=>e.selected = false);
                         brands.forEach((e)=>e.selected = false);


                          filters.value = null;
                          _searchController.text = "";
                          _pagingController.refresh();

                          return;
                        }
                        showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          context: context,
                          builder: (context) {
                            return Filters(
                              itemsCategory: categories,
                              onFilter: (Map<String, dynamic>? f) {

                                if (filters.value != null) {
                                  if (filters.value!.isEmpty)
                                    filters.value = null;
                                }


                                filters.value = f;
                                _pagingController.refresh();

                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 1.0 + (value * 0.1),
                            child:
                                f != null
                                    ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex(
                                          AppTheme.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: HexColor.fromHex(
                                            AppTheme.borderGrey,
                                          ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          SvgPicture.asset(
                                            "assets/icons/filters.svg",
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                    : Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex(
                                          AppTheme.filledBox,
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: HexColor.fromHex(
                                            AppTheme.borderGrey,
                                          ),
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
                                      child: SvgPicture.asset(
                                        "assets/icons/filters.svg",
                                      ),
                                    ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
