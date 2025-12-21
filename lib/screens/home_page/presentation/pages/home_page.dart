import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
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
import '../widgets/deal_details.dart';
import '../widgets/promos_widget.dart';
import '../widgets/single_item_shopping_list.dart';

ValueNotifier<bool> promosLoading = ValueNotifier(false);
List promos = [];

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = getIt<HomePageController>();

  ValueNotifier<Map<String,dynamic>?> filters = ValueNotifier(null);

  late final _pagingController =  PagingController<int, DealProductModel>(
    // getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _homePageController.getDealProducts(pageKey,filters.value),
    // fetchPage: (pageKey) async {
    //   final newItems = await _homePageController.getDealProducts(pageKey,filters.value);
    //   return newItems; // Return the list of items directly
    // },
  );

  @override

  Future<void> fetchPromos() async {

    promosLoading.value = true;
    promos = await _homePageController.getPromos();
    promosLoading.value = false;

  }

  void initState() {


    fetchPromos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppBar2(context,null,(v){
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
                        SizedBox(
                            height: 106,
                            child: Center(
                                child: CircularProgressIndicator()
                            )
                        ) :
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

                  /**********************************************************************/
                  SizedBox(
                    height: 39,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // width: 113,
                          padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex(AppTheme.primaryColor),
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(color: HexColor.fromHex(AppTheme.borderColor)),
                          ),
                          child: Row(
                            children: [

                              ClipOval(
                                child: SvgPicture.asset(
                                  'assets/icons/filter1.svg',
                                  width: 20, // Specify width and height
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("التجار الرائجون",
                                style:  Theme.of(context,).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );




                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10,);
                      },
                      itemCount: 3,

                    ),
                  ),
                  /**********************************************************************/


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
                    childAspectRatio: .57,
                  ),

                  // Build your grid tiles
                  builderDelegate: PagedChildBuilderDelegate<DealProductModel>(
                    itemBuilder: (context, item, index) => pushUpAnimation(InkWell(
                        onTap: (){
                          Get.to(DealDetails(dealModel: item));
                        },
                        child: SingleItemShoppingGrid(dealProductModel: item,))),
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
                        if(f!= null){
                          filters.value = null;
                          return;
                        }
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
                            return Filters(onFilter: (Map<String, dynamic> f) {
                              filters.value = f;
                              _pagingController.refresh();
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


