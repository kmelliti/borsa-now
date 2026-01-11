import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/review_response_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/home_page/data/models/deal_product_model.dart';
import '../exception/api_exception.dart';

class HomePageService {
  final Dio _dio;
  HomePageService(this._dio);

  Future<List<DealProductModel>> getDealProducts(int pageKey, Map<String, dynamic>? value) async {
    int page = pageKey;


    // if(value != null){
    //   page = 1;
    // }



    try {

      String params ="";
      value?.forEach((key, value) {
        // print('$key: $value');
        params = params+"&"+key+"="+value;
      });

      log("params : ${params}");

      // final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/${getLang()}?page=${page}${params}"/*,queryParameters: value*/);
      final response = await _dio.get("/BorsaNow/public/api/v1/customer/retails/${getLang()}?page=${page}${params}"/*,queryParameters: value*/);

      print("responseresponse : ${response.data['data']['data']}");

      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }

      // return page == 1 ? [
      //   DealProductModel(id: 1, merchantId: 1, productId: 1, quantity: 1, quantitySold: 1, wholesalePrice: "100", retailPrice: "101", minInvestment: null, totalInvested: "100", targetAmount: "targetAmount", status: "status", offerStartAt: null, offerEndAt: null, isDeleted: 0, deletedAt: null, createdBy: 1, updatedBy: 1, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), isFavorite: false, rating: 4.5, product: PModel(id: 1, merchantId: 1, productCategorieId: 1, sku: "sku", name: "59.99 دولار", description: "كولد برو بالتوت العليق والكريمة", costBasis: "costBasis", isDeleted: 0, createdBy: 1, updatedBy: null, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), productPictures: [ProductPicture(id: 1, productId: 1, picture: "assets/icons/a2.png", createdAt: DateTime.now(), updatedAt: DateTime.now())])),
      //   DealProductModel(id: 2, merchantId: 1, productId: 1, quantity: 1, quantitySold: 1, wholesalePrice: "100", retailPrice: "101", minInvestment: null, totalInvested: "100", targetAmount: "targetAmount", status: "status", offerStartAt: null, offerEndAt: null, isDeleted: 0, deletedAt: null, createdBy: 1, updatedBy: 1, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), isFavorite: false, rating: 5,product: PModel(id: 1, merchantId: 1, productCategorieId: 1, sku: "sku", name: "name", description: "description", costBasis: "costBasis", isDeleted: 0, createdBy: 1, updatedBy: null, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), productPictures: [ProductPicture(id: 1, productId: 1, picture: "assets/icons/aa1.png", createdAt: DateTime.now(), updatedAt: DateTime.now())])),
      //   DealProductModel(id: 3, merchantId: 1, productId: 1, quantity: 1, quantitySold: 1, wholesalePrice: "100", retailPrice: "101", minInvestment: null, totalInvested: "100", targetAmount: "targetAmount", status: "status", offerStartAt: null, offerEndAt: null, isDeleted: 0, deletedAt: null, createdBy: 1, updatedBy: 1, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), isFavorite: false, rating: 3.8,product: PModel(id: 1, merchantId: 1, productCategorieId: 1, sku: "sku", name: "name", description: "description", costBasis: "costBasis", isDeleted: 0, createdBy: 1, updatedBy: null, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), productPictures: [ProductPicture(id: 1, productId: 1, picture: "assets/icons/aa1.png", createdAt: DateTime.now(), updatedAt: DateTime.now())])),
      //   DealProductModel(id: 4, merchantId: 1, productId: 1, quantity: 1, quantitySold: 1, wholesalePrice: "100", retailPrice: "101", minInvestment: null, totalInvested: "100", targetAmount: "targetAmount", status: "status", offerStartAt: null, offerEndAt: null, isDeleted: 0, deletedAt: null, createdBy: 1, updatedBy: 1, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), isFavorite: false, rating: 2.1,product: PModel(id: 1, merchantId: 1, productCategorieId: 1, sku: "sku", name: "name", description: "description", costBasis: "costBasis", isDeleted: 0, createdBy: 1, updatedBy: null, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), productPictures: [ProductPicture(id: 1, productId: 1, picture: "assets/icons/a2.png", createdAt: DateTime.now(), updatedAt: DateTime.now())])),
      //   DealProductModel(id: 5, merchantId: 1, productId: 1, quantity: 1, quantitySold: 1, wholesalePrice: "100", retailPrice: "101", minInvestment: null, totalInvested: "100", targetAmount: "targetAmount", status: "status", offerStartAt: null, offerEndAt: null, isDeleted: 0, deletedAt: null, createdBy: 1, updatedBy: 1, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), isFavorite: false, rating: 3,product: PModel(id: 1, merchantId: 1, productCategorieId: 1, sku: "sku", name: "name", description: "description", costBasis: "costBasis", isDeleted: 0, createdBy: 1, updatedBy: null, deletedBy: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), productPictures: [ProductPicture(id: 1, productId: 1, picture: "assets/icons/a2.png", createdAt: DateTime.now(), updatedAt: DateTime.now())])),
      // ] : [];

      return (response.data['data']['data'] as List).map((e) => DealProductModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<List<DealProductModel>> getRelatedDeals(int dealId) async {
    try {
      // final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/${getLang()}?id=$dealId");
      final response = await _dio.get("/BorsaNow/public/api/v1/customer/retail/related/$dealId/${getLang()}");

      return (response.data['data']['data'] as List).map((e) => DealProductModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<List> getPromos() async {

    try {

      await Future.delayed(Duration(seconds: 3));

      return [
        {"title": "لا تفوت فرصة آيفون 17!", "save": "20%", "color": "#E5864C"},
        {"title": "أشهى مشروبات ستاربكس® بانتظارك!", "save": "20%", "color": "#0B6648"},
        {"title": "لا تفوت فرصة آيفون 17!", "save": "20%", "color": "#0000FF"},
      ];
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/general/brands/${getLang()}");
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      return (response.data['data'] as List).map((e) => BrandModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<ReviewResponseModel> getReviews(String productId) async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/products/rates/${getLang()}",queryParameters: {
        "product_id":productId
      });
      log("${response.data}");
      return ReviewResponseModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<ReviewModel> addReview (List<String?> images , Map<String,dynamic> params) async {
    try {
      final response = await _dio.post("/BorsaNow/public/api/v1/investor/products/rate/add/${getLang()}",data: params);
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      log("${response.data}");
      return ReviewModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("erro message $e $s");
      throw e;
    }
  }

  Future<bool> addCartProduct(int productId) async {
    try {

      final response = await _dio.post("/BorsaNow/public/api/v1/customer/order/add/${getLang()}",data: {
        "items": [
          {
            "retail_listing_id": productId,
            "quantity": 1
          }
        ],
        "discount_code": "",
        "payment_method": "cod"
      });


      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }

      log("ezuyryeuzioaryueziy:  ${response.data}");
      return true;

    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }


  Future<void> addDeleteFav ( Map<String,dynamic> params) async {
    try {
      final response = await _dio.post("/BorsaNow/public/api/v1/investor/deal/favorite/toggle/${getLang()}",data: params);
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      log("${response.data}");

    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }


}