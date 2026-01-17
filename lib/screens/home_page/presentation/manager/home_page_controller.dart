import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/models/lookup_model.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:borsa_now_bis/core/services/home_page_service.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/ad_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borsa_now_bis/core/models/product_model.dart' as p;

import '../../data/models/deal_product_model.dart';
import '../../data/models/review_response_model.dart';

final AppServices appServices = getIt();

class HomePageController {

  final HomePageService _homePageService;
  // ValueNotifier<List<p.ProductModel>> cartProducts = ValueNotifier([]);
  ValueNotifier<List<DealProductModel>> cartProducts = ValueNotifier([]);
  
  

  HomePageController(this._homePageService);

  Future<List<DealProductModel>> getDealProducts(int pageKey, Map<String, dynamic>? value) async {

    return await _homePageService.getDealProducts(pageKey,value);
  }

  Future<DealProductModel>getDealDetails(int dealId) async {

    return await _homePageService.getDealDetails(dealId);
  }

  Future<List<AdModel>> getPromos() async {
    return await _homePageService.getPromos();
  }

  Future<List<LookUpModel>> getCategories() async {
    // return await _homePageService.getCategories();

    return await appServices.getProductCategories();

  }

  Future<List<BrandModel>> getBrands() async {
    return await _homePageService.getBrands();
  }

  Future<List<DealProductModel>> getRelatedDeals(int dealId) async {
    return await _homePageService.getRelatedDeals(dealId);
  }

  Future<ReviewResponseModel> getReviews(String productId) async {
    return await _homePageService.getReviews(productId);
  }

  Future<ReviewModel> addReview (List<String?> images , Map<String,dynamic> params) async {
    return await _homePageService.addReview(images, params);
  }

  Future<void> addDeleteFav ( Map<String,dynamic> params) async {
    return await _homePageService.addDeleteFav( params);
  }
  
  void addCartProduct(DealProductModel product) async {


    List<DealProductModel> products = cartProducts.value;

    bool found = false;

    for (int i = 0; i < products.length; i++) {
      if (products[i].id == product.id) {
        products[i].cartQuantity++;
        found = true;
        break;
      }
    };

    if (!found)
      products.add(product);

    cartProducts.value = [...products];
  }

  void removeCartProducts(DealProductModel product) {
    List<DealProductModel> products = cartProducts.value;
    products.remove(product);
    cartProducts.value = [...products];
  }

  void addCartProducts(List<DealProductModel> products) async {
    return await _homePageService.addCartProducts(products);

  }
}