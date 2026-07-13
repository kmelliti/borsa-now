import 'package:borsa_now_bis/core/models/my_order_model.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/my_orders/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';


class MyPayments extends StatefulWidget {
  MyPayments({super.key});

  @override
  State<MyPayments> createState() => _MyPaymentsState();
}

class _MyPaymentsState extends State<MyPayments> {
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
      appBar: buildAppBar2("payments".tr),
      body: Container(
        margin: EdgeInsets.all( 20),
        child:       PagingListener(
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
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                          ),
                          child: ListTile(
                            title: Text("${"order_id".tr} : ${item.id}",style: Theme.of(context).textTheme.bodyLarge,),
                            subtitle: Row(
                              children: [
                                Text("${"date".tr}: ",style: TextStyle(color: Colors.black87),),
                                Text(df.format(item.createdAt)),
                              ],
                            ),
                            trailing: Text
                              ("${item.amountTotal} ${"sar".tr} ${item.paymentMethod??""}",style: TextStyle(color: Colors.green),),
                          ),
                        )
                ),
              ),
        ),
      ),
    );
  }


}
