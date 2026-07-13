import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../manager/my_account_controller.dart';


class EditPersonalInformation extends StatefulWidget {
  EditPersonalInformation({super.key});

  @override
  State<EditPersonalInformation> createState() =>
      _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {
  final _formKey = GlobalKey<FormState>();

  final MyAccountController _controller = getIt();

  late  UserModel user;

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _birthdayController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final AppServices _appServices = getIt();

  String? gender;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    user = _appServices.getUser();
    _fullNameController.text = user.name;

      _birthdayController.text = df.format(user.birthdate);
    _emailController.text = user.email;
    _phoneNumberController.text = user.phone;
    gender = user.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Scaffold(
           appBar: buildAppBar2("personal_info".tr),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      pushUpAnimation(
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(labelText: 'full_name'
                              .tr),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field_is_required'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      pushUpAnimation(
                        TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,

                            decoration: InputDecoration(labelText: 'email'.tr),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field_is_required'.tr;
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(height: 20),
                      pushUpAnimation(
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(labelText: 'phone_number'
                              .tr),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field_is_required'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      pushUpAnimation(
                        TextFormField(
                          controller: _birthdayController,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'dob'.tr,
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                          ),
                          onTap: () async {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value == null) {
                                return;
                              }
                              _birthdayController.text =
                                  df.format(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field_is_required'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      pushUpAnimation(
                        DropdownButtonFormField<String>(
                          value: gender,
                          decoration: InputDecoration(labelText: 'gender'.tr),
                          items: genderList
                              .map((e) =>
                              DropdownMenuItem(value: e, child: Text("$e".tr)))
                              .toList(),
                          onChanged: (value) {
                            gender = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'field_is_required'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context,v,_) {
                            return v ? Center(child: getLoader()) :pushUpAnimation(
                              ElevatedButton(
                                onPressed: () async{
                                  if (_formKey.currentState!.validate()) {
                                    final Map<String,dynamic> params = {
                                       "name": _fullNameController.text,
                                       "phone": _phoneNumberController.text,
                                       "email": _emailController.text,
                                       "birthdate": _birthdayController.text,
                                       "gender": gender!
                                           };

                                    isLoading.value= true;
                                    try{
                                    UserModel? user =   await _controller.updatePersonalInformation(params);
                                    setState(() {
                                      this.user = user;
                                    });

                                    _appServices.setUser(user);
                                    }catch( e,s){


                                      handleException(context,e);
                                    }
                                    isLoading.value = false;
                                  }
                                },
                                child: Text('save'.tr),
                              ),
                            );
                          }
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
