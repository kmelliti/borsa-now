import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef OnItemClicked = void Function(List);

class CategoriesWidget extends StatefulWidget {

  final List categories;
  final OnItemClicked onItemClicked ;

  const CategoriesWidget({
    super.key, required this.categories, required this.onItemClicked,
  });

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print("category tapped");



              widget.categories[index].selected = !widget.categories[index].selected;

              List selectedCategories = widget.categories.where((s) => s.selected == true).toList();
              widget.onItemClicked(selectedCategories.map((lm) => lm.id).toList());

              setState(() { // Calling setState triggers a rebuild of the widget

              });
            },
            child: Container(
              // width: 113,
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              // decoration: BoxDecoration(
              //   color: HexColor.fromHex(AppTheme.primaryColor),
              //   borderRadius: BorderRadius.circular(20),
              //   // border: Border.all(color: HexColor.fromHex(AppTheme.borderColor)),
              // ),
              decoration: BoxDecoration(
                color: widget.categories[index].selected ? HexColor.fromHex(AppTheme.primaryColor) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: widget.categories[index].selected ? Colors.transparent : HexColor.fromHex(AppTheme.borderColor)),
              ),
              child:
                  Text(widget.categories[index].name,
                    style:  Theme.of(context,).textTheme.bodySmall?.copyWith(
                      color: widget.categories[index].selected ? Colors.white : HexColor.fromHex(AppTheme.primaryColor),
                      fontWeight: widget.categories[index].selected ? FontWeight.w500 : FontWeight.w100,
                    ),
                  ),

            ),
          );




        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10,);
        },
        itemCount: widget.categories.length,

      ),
    );
  }
}



class ShimmerFilterWidget extends StatefulWidget {
  const ShimmerFilterWidget({super.key});

  @override
  _ShimmerFilterWidgetState createState() => _ShimmerFilterWidgetState();
}

class _ShimmerFilterWidgetState extends State<ShimmerFilterWidget>
    with SingleTickerProviderStateMixin { // required for the AnimationController
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.2, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SizedBox(
        height: 39,
        width: 120,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            // width: 113,
            padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            // decoration: BoxDecoration(
            //   color: HexColor.fromHex(AppTheme.primaryColor),
            //   borderRadius: BorderRadius.circular(20),
            //   // border: Border.all(color: HexColor.fromHex(AppTheme.borderColor)),
            // ),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),

          ),
        ),
      ),
    );
  }
}