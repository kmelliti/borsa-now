// import 'package:borsa_now_bis/core/config/app_constants.dart';
// import 'package:borsa_now_bis/core/config/utils.dart';
// import 'package:borsa_now_bis/core/theme/app_theme.dart';
// import 'package:borsa_now_bis/screens/my_account/presentation/manager/my_account_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/di/di.dart';
// import '../../../../core/models/lookup_model.dart';
// import '../../../../core/models/user_model.dart';
//
// class EditAddress extends StatefulWidget {
//   EditAddress({super.key, required this.user});
//
//   final UserModel user;
//
//   @override
//   State<EditAddress> createState() => _EditAddressState();
// }
//
// class _EditAddressState extends State<EditAddress> {
//
//   late UserModel user;
//   TextEditingController buildingNumberController = TextEditingController();
//   TextEditingController subNumberController = TextEditingController();
//   TextEditingController streetController = TextEditingController();
//   TextEditingController neighborhoodController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController postalCodeController = TextEditingController();
//   int? cityId;
//   final ValueNotifier<bool> isLoading = ValueNotifier(false);
//   final MyAccountController _controller = getIt();
//
//   @override
//   void initState() {
//     this.user = widget.user;
//     // buildingNumberController.text = user.investor.buildingNumber;
//     // subNumberController.text = user.investor.unitNumber;
//     // streetController.text = user.investor.street;
//     // neighborhoodController.text = user.investor.district;
//     cityController.text =
//         cities
//             .firstWhereOrNull(
//               (test) => test.id.toString() == user.investor.cityId.toString(),
//             )
//             ?.name ??
//         "";
//     postalCodeController.text = user.investor.postalCode;
//     cityId = cities.firstWhereOrNull(
//               (test) => test.id.toString() == user.investor.cityId.toString(),
//             )?.id;
//     super.initState();
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Building Number
//               Text(
//                 "building_number".tr,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: buildingNumberController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'field_is_required'.tr;
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "enter_building_number".tr,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Sub Number
//               Text(
//                 "sub_number".tr,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: subNumberController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'field_is_required'.tr;
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(hintText: "enter_sub_number".tr),
//               ),
//               const SizedBox(height: 20),
//
//               // Street
//               Text(
//                 "street".tr,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: streetController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'field_is_required'.tr;
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(hintText: "enter_street".tr),
//               ),
//               const SizedBox(height: 20),
//
//               // Neighborhood
//               Text(
//                 "neighborhood".tr,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: neighborhoodController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'field_is_required'.tr;
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(hintText: "enter_neighborhood".tr),
//               ),
//               const SizedBox(height: 20),
//
//               // City
//               Text(
//                 "city".tr,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ButtonTheme(
//                 alignedDropdown: true,
//                 child: Autocomplete<LookUpModel>(
//                   //   initialValue: TextEditingValue(text: cities.isNotEmpty ?cities.first.name :"" ) ,
//                   displayStringForOption: displayStringForOption,
//
//
//                   fieldViewBuilder: (
//                     context,
//                     controller,
//                     focusNode,
//                     onFieldSubmitted,
//                   ) {
//                     return TextFormField(
//                       controller: cityController,
//                       focusNode: focusNode,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'field_is_required'.tr;
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'city'.tr,
//                       ).applyDefaults(Theme.of(context).inputDecorationTheme),
//                     );
//                   },
//
//                   optionsBuilder: (TextEditingValue textEditingValue) {
//                     return cities
//                         .where(
//                           (city) => city.name.toLowerCase().contains(
//                             textEditingValue.text.toLowerCase(),
//                           ),
//                         )
//                         .toList();
//                   },
//                   onSelected: (LookUpModel city) {
//                     cityController.text = city.name;
//                     cityId = city.id;
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Postal Code
//               Text(
//                 "postal_code".tr,
//
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: HexColor.fromHex("#717088"),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'field_is_required'.tr;
//                   }
//                   return null;
//                 },
//                 controller: postalCodeController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(hintText: "enter_postal_code".tr),
//               ),
//               const SizedBox(height: 20),
//               // Save Button
//               ValueListenableBuilder(
//                 valueListenable: isLoading,
//                 builder: (context, val, _) {
//                   return val
//                       ? getLoader()
//                       : ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             isLoading.value = true;
//                             Map<String, dynamic> params = {
//                               "building_number": buildingNumberController.text,
//                               "unit_number": subNumberController.text,
//                               "street": streetController.text,
//                               "district": neighborhoodController.text,
//                               "city_id": cityId,
//                               "postal_code": postalCodeController.text,
//                             };
//                             try {
//                               UserModel newUser = await _controller
//                                   .updateAddress(params);
//                               Get.back(result: newUser);
//                             } catch (e) {
//                               handleException(context, e);
//                             }
//
//                           }
//                           isLoading.value = false;
//                         },
//                         child: Text("save".tr),
//                       );
//                 },
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper function to show edit address dialog
//   // void showEditAddressDialog(BuildContext context) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => Dialog(
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(20),
//   //       ),
//   //       child: SingleChildScrollView(
//   //         child: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Padding(
//   //               padding: const EdgeInsets.all(20.0),
//   //               child: Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                 children: [
//   //                   Text(
//   //                     "edit_address".tr,
//   //                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//   //                           fontWeight: FontWeight.bold,
//   //                         ),
//   //                   ),
//   //                   IconButton(
//   //                     icon: const Icon(Icons.close),
//   //                     onPressed: () => Navigator.of(context).pop(),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //              EditAddress(user: user,),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
