import 'package:borsa_now_bis/core/services/home_page_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borsa_now_bis/core/models/product_model.dart' as p;

import '../../data/models/deal_product_model.dart';
import '../../data/models/review_response_model.dart';

class HomePageController {

  final HomePageService _homePageService;
  ValueNotifier<List<p.ProductModel>> cartProducts = ValueNotifier([]);
  
  

  HomePageController(this._homePageService);

  Future<List<DealProductModel>> getDealProducts(int pageKey, Map<String, dynamic>? value) async {

    return await _homePageService.getDealProducts(pageKey,value);
  }

  Future<List> getPromos() async {
    return await _homePageService.getPromos();
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
  
  void addCartProducts(p.ProductModel product) {
    List<p.ProductModel> products = cartProducts.value;
    products.add(product);
    cartProducts.value = [...products];
  }
  void removeCartProducts(p.ProductModel product) {
    List<p.ProductModel> products = cartProducts.value;
    products.remove(product);
    cartProducts.value = [...products];
  }
}