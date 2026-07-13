
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:borsa_now_bis/core/models/lookup_model.dart';
final ValueNotifier<int> indexWidget = ValueNotifier(0);

final String spUser = "user";
final String spToken = "token";
final String cart = "cart";
final String baseUrl = "https://borsanow.com.sa/";
final String baseUrlImage = baseUrl;
final DateFormat df = DateFormat("yyyy-MM-dd");
List<LookUpModel> cities = [];
List<LookUpModel> banks = [];