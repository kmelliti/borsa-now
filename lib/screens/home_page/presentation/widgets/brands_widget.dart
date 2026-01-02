import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef OnItemClicked = void Function(List);

class BrandsWidget extends StatefulWidget {

  final List<BrandModel> brands;
  final OnItemClicked onItemClicked ;

  const BrandsWidget({
    super.key, required this.brands, required this.onItemClicked,
  });

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
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
              print("brand tapped");
              widget.brands[index].selected = !widget.brands[index].selected;

              List selectedCategories = widget.brands.where((s) => s.selected == true).toList();
              widget.onItemClicked(selectedCategories.map((lm) => lm.id).toList());

              setState(() { // Calling setState triggers a rebuild of the widget

              });
            },
            child: Container(
              // width: 113,
              padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                color: widget.brands[index].selected ? HexColor.fromHex(AppTheme.primaryColor) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: widget.brands[index].selected ? Colors.transparent : HexColor.fromHex(AppTheme.borderColor)),
              ),
              child: Row(
                children: [
                  widget.brands[index].picture != null ?
                  ClipOval(
                    child: Image.network("${baseUrlImage}${widget.brands[index].picture}",fit: BoxFit.fill,),
                  ) : Container(),
                  SizedBox(width: 10,),
                  Text(widget.brands[index].companyName,
                    style:  Theme.of(context,).textTheme.bodySmall?.copyWith(
                      color: widget.brands[index].selected ? Colors.white : HexColor.fromHex(AppTheme.primaryColor),
                      fontWeight: widget.brands[index].selected ?  FontWeight.w500 : FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
          );




        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10,);
        },
        itemCount: widget.brands.length,

      ),
    );
  }
}