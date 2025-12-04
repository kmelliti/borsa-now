
import 'package:flutter/material.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/screens/main_screen/controller/main_screen_controller.dart';


import '../../../core/config/bottom_navigator.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController _controller = getIt();


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:_controller. indexWidget,
        builder: (c,i,_){

          switch(i){
            case 0:
              return Container();
            case 1:
              return Container();
            case 2:
              return Container();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNav(onItemTapped: (int index) {
        _controller. indexWidget.value = index;
      }),
    );
  }
}
