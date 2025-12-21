import 'package:borsa_now_bis/core/config/bottom_navigator.dart';
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
    {'icon': 'assets/icons/account.svg', 'label': 'my_account'.tr},
    {'icon': 'assets/icons/orders.svg', 'label': 'orders'.tr},
    {'icon': 'assets/icons/home.svg', 'label': 'home'.tr},
    {'icon': 'assets/icons/like.svg', 'label': 'favourite'.tr},
    {'icon': 'assets/icons/help.svg', 'label': 'help'.tr},
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexWidget,
        builder: (c,i,_){

          print("Builder");
           switch(i){
            case 0:
              return MyAccount();

            case 1:
              return MyOrders();
            case 2:
              return HomePage(key: Key("home"),);
            case 3:
              return MyFavourites();
            case 4:
              return MyAccount();

            default:
              return HomePage();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNav(items: items, selectedIndex: 2, onItemTapped: (int index) {
        indexWidget.value = index;
      }),
    );
  }
}
