// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/config/utils.dart';
// import '../../../../core/theme/app_theme.dart';
//
// class Checkout extends StatelessWidget {
//   const Checkout({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80),
//         child: SafeArea(
//           minimum: EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.symmetric(horizontal: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: HexColor.fromHex(AppTheme.borderGrey),
//                     ),
//                   ),
//                   child: Icon(Icons.arrow_back),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Text(
//                 "request_review".tr,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: HexColor.fromHex(AppTheme.primaryColor),
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 0.2,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(20),
//         color: Colors.white,
//         constraints: BoxConstraints(maxHeight: 250),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "sub_total".tr,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                     color: HexColor.fromHex(AppTheme.primaryColor),
//                   ),
//                 ),
//                 getPriceInText(
//                   10000,
//                   TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                     color: HexColor.fromHex(AppTheme.primaryColor),
//                   ),
//                   15,
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Divider(),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "total".tr,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                     color: HexColor.fromHex(AppTheme.primaryColor),
//                   ),
//                 ),
//                 getPriceInText(
//                   10000,
//                   TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: HexColor.fromHex(AppTheme.primaryColor),
//                   ),
//                   15,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: () {},
//               child: Text("complete_payment".tr),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       color: HexColor.fromHex(AppTheme.borderGreyLight),
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               height: 100,
//                               padding: EdgeInsets.symmetric(
//                                 vertical: 10,
//                                 horizontal: 20,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: HexColor.fromHex("#EFEFE3"),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Center(
//                                 child: Image.asset("assets/icons/aa1.png"),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             flex: 2,
//                             child: SizedBox(
//                               height: 100,
//                               child: Column(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "كولد برو بالتوت العليق والكريمة",
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.displayLarge?.copyWith(
//                                         color: HexColor.fromHex(
//                                           AppTheme.primaryColor,
//                                         ),
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   getPriceInText(
//                                     10.0,
//                                     TextStyle(fontSize: 20),
//                                     15,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 20,
//                         ),
//                         decoration: BoxDecoration(
//                           color: HexColor.fromHex(AppTheme.filledBox),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "min_quantity".tr,
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.bodySmall?.copyWith(
//                                 color: HexColor.fromHex(AppTheme.primaryColor),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Text(
//                               "10",
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.bodySmall?.copyWith(
//                                 color: HexColor.fromHex(AppTheme.primaryColor),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 20,
//                         ),
//                         decoration: BoxDecoration(
//                           color: HexColor.fromHex(AppTheme.filledBox),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "available_pcs".tr,
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.headlineSmall?.copyWith(
//                                 color: HexColor.fromHex(AppTheme.primaryColor),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Text(
//                               "10",
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.headlineSmall?.copyWith(
//                                 color: HexColor.fromHex(AppTheme.primaryColor),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     "set_quanity".tr,
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: HexColor.fromHex(AppTheme.primaryColor),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 TextField(),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       SvgPicture.asset("assets/icons/gift.svg"),
//                       SizedBox(width: 10),
//                       Text(
//                         "gift_or_coupon".tr,
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: HexColor.fromHex(AppTheme.primaryColor),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       color: HexColor.fromHex(AppTheme.borderGrey),
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             hintText: "code_coupon".tr,
//                             hintStyle: Theme.of(
//                               context,
//                             ).textTheme.bodySmall?.copyWith(
//                               color: HexColor.fromHex(AppTheme.hintColor2),
//                             ),
//                           ).applyDefaults(
//                             Theme.of(context).inputDecorationTheme,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text("apply".tr),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row header(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Hero(
//             tag: "a2",
//             child: Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: HexColor.fromHex(AppTheme.borderGrey),
//                 ),
//               ),
//               child: Icon(Icons.arrow_back),
//             ),
//           ),
//         ),
//         SizedBox(width: 10),
//         Text(
//           "request_review".tr,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             color: HexColor.fromHex(AppTheme.primaryColor),
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.2,
//             fontSize: 20,
//           ),
//         ),
//       ],
//     );
//   }
// }
