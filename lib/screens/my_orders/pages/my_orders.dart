import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/utils.dart';
import '../widgets/single_order.dart';

class MyOrders extends StatefulWidget {
  MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // List of months with translations
  final List<String> monthList = [
    'january'.tr,
    'february'.tr,
    'march'.tr,
    'april'.tr,
    'may'.tr,
    'june'.tr,
    'july'.tr,
    'august'.tr,
    'september'.tr,
    'october'.tr,
    'november'.tr,
    'december'.tr,
  ];
  String? _selectedMonth;
  int? _selectedYear;
  final int baseYear = 2025;
  ValueNotifier<int> filterIndex = ValueNotifier(1);

  @override
  void initState() {
    if (DateTime.now().year == baseYear) {
      _selectedYear = baseYear;
    }
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
              SizedBox(height: 30),
              dateSelector(),
              SizedBox(height: 30),
              dashboard(context),
              SizedBox(height: 20),
              filterRow(context),
              SizedBox(height: 20),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (c,i){
                    return SingleOrder();
                  })
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
                      "delivered".tr,
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
                      "canceled".tr,
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
                      "in_review".tr,
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
            ],
          ),
        );
      },
    );
  }

  Row dashboard(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor.fromHex(AppTheme.filledBox),
              border: Border.all(color: HexColor.fromHex(AppTheme.strokeS3)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "total_orders".tr,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  "20202",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
              border: Border.all(color: HexColor.fromHex(AppTheme.strokeS3)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "total_products".tr,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "20202",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  Row dateSelector() {
    return Row(
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedMonth,
              isDense: false,

              itemHeight: 50,
              hint: Text("month".tr),
              icon: Icon(Icons.keyboard_arrow_down),

              onChanged: (String? newValue) {
                _selectedMonth = newValue;
                setState(() {
                  _selectedYear = DateTime.now().year;
                });
              },
              items:
                  <String>[
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(monthList[int.parse(value)]),
                    );
                  }).toList(),
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isDense: false,

              value: _selectedYear,

              itemHeight: 50,
              hint: Text("year".tr),
              icon: Icon(Icons.keyboard_arrow_down),

              onChanged: (int? newValue) {
                setState(() {
                  _selectedYear = newValue;
                });
              },
              items:
                  List<int>.generate(
                    DateTime.now().year - baseYear + 1,
                    (index) => DateTime.now().year - index,
                  ).map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
