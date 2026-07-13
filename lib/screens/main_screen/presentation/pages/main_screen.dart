import 'package:borsa_now_bis/core/config/bottom_navigator.dart';
import 'package:borsa_now_bis/screens/contact_page/presentation/pages/contact_page.dart';
import 'package:borsa_now_bis/screens/favourite/pages/favourite_page.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/pages/home_page.dart';
import 'package:borsa_now_bis/screens/my_orders/pages/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_constants.dart';
import '../../../my_account/presentation/pages/my_account.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});



  final items = [
    {'icon': 'assets/icons/home.svg', 'label': 'home'.tr},
    {'icon': 'assets/icons/orders.svg', 'label': 'orders'.tr},
    {'icon': 'assets/icons/like.svg', 'label': 'favourite'.tr},
    {'icon': 'assets/icons/account.svg', 'label': 'my_account'.tr},
    // {'icon': 'assets/icons/help.svg', 'label': 'help'.tr},
  ];

  final listScreens = [
    HomePage(key: Key("home"),),
    MyOrders(),
    MyFavourites(),
    MyAccount(),
    // ContactPage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexWidget,
        builder: (c,i,_) {
          if(i == 2){
            return MyFavourites();
          }
          return IndexedStack(index: indexWidget.value, children: listScreens);
        }
      ),
      bottomNavigationBar: CustomBottomNav(items: items, selectedIndex: 0, onItemTapped: (int index) {
        // FocusScope.of(context).unfocus();
        indexWidget.value = index;
      }),
    );
  }
}
