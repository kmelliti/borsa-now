import 'package:borsa_now_bis/core/models/my_order_model.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/my_orders/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/config/utils.dart';
import '../../../core/di/di.dart';
import '../widgets/single_order.dart';

class MyOrders extends StatefulWidget {
  MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final MyOrdersController _controller = getIt();
  String status = "all";
  late final _pagingController = PagingController<int, MyOrderModel>(
    getNextPageKey:
        (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _controller.getMyOrders(pageKey, status),
  );

  int? _selectedMonth;
  int? _selectedYear;
  final int baseYear = 2025;
  ValueNotifier<bool> shakeUp = ValueNotifier(false);
  ValueNotifier<int> filterIndex = ValueNotifier(1);

  late List<int> listOfYears;

  @override
  void initState() {
    _selectedYear = DateTime.now().year;
    if (DateTime.now().year == baseYear) {
      _selectedYear = baseYear;
    }
    listOfYears = List<int>.generate(
      DateTime.now().year - baseYear + 1,
      (index) => DateTime.now().year - index,
    );

    _selectedMonth = DateTime.now().month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, false),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle("my_orders".tr),
            //  SizedBox(height: 30),
              // dateSelector(
              //   (month) {
              //     _selectedMonth = int.parse(month);
              //     shakeUp.value = !shakeUp.value;
              //   },
              //   (year) {
              //     _selectedYear = year;
              //     shakeUp.value = !shakeUp.value;
              //   },
              //   listOfYears,
              // ),
              // SizedBox(height: 30),
              // dashboard(context),
              SizedBox(height: 20),
              filterRow(context),
              SizedBox(height: 20),
              PagingListener(
                controller: _pagingController,
                builder:
                    (context, state, fetchNextPage) =>
                        PagedListView<int, MyOrderModel>(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          state: state,
                          fetchNextPage: fetchNextPage,

                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: noItemFound,
                            itemBuilder:
                                (context, item, index) =>
                                    SingleOrder(order: item),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder<int> filterRow(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filterIndex,
      builder: (c, val, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  filterIndex.value = 1;
                  status = "all";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 1
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,
                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "all".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 1
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  filterIndex.value = 2;
                  status = "pending";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 2
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,

                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "pending".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 2
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  filterIndex.value = 3;
                  status = "paid";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 3
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,

                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "paid".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 3
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  filterIndex.value = 4;
                  status = "fulfilled";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 4
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,

                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "fulfilled".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 4
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  filterIndex.value = 5;
                  status = "cancelled";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 5
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,

                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "cancelled".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 5
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  filterIndex.value = 6;
                  status = "refunded";
                  _pagingController.refresh();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  constraints: BoxConstraints(minWidth: 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        val == 6
                            ? HexColor.fromHex(AppTheme.primaryColor)
                            : Colors.white,

                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.borderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "refunded".tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            val == 6
                                ? Colors.white
                                : HexColor.fromHex(AppTheme.primaryColor),

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dashboard(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: shakeUp,
      builder: (context, v, _) {
        return FutureBuilder(
          future: _controller.getDashboard(_selectedMonth!, _selectedYear!),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: getLoader());
            }
            if (snap.connectionState == ConnectionState.done &&
                !snap.hasError) {
              if (snap.data == null) {
                return Container();
              }
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor.fromHex(AppTheme.filledBox),
                        border: Border.all(
                          color: HexColor.fromHex(AppTheme.strokeS3),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "total_orders".tr,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),

                          getPriceInText(
                            double.parse(snap.data!['totalAmount'].toString()),
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor.fromHex(AppTheme.filledBox),
                        border: Border.all(
                          color: HexColor.fromHex(AppTheme.strokeS3),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "total_products".tr,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            snap.data!['totalItems'].toString(),

                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: HexColor.fromHex(AppTheme.primaryColor),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
