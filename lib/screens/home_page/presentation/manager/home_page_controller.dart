import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/models/lookup_model.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:borsa_now_bis/core/services/home_page_service.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/ad_model.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borsa_now_bis/core/models/product_model.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/order_submitted_model.dart';
import '../../data/models/deal_product_model.dart';
import '../../data/models/review_response_model.dart';

final AppServices appServices = getIt();

class HomePageController {

  final HomePageService _homePageService;
  // ValueNotifier<List<p.ProductModel>> cartProducts = ValueNotifier([]);
  ValueNotifier<List<DealProductModel>> cartProducts = ValueNotifier([]);

  final SharedPreferences prefs ;

  HomePageController(this._homePageService, this.prefs);

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
  

  void removeCartProduct(DealProductModel product) {
    List<DealProductModel> products = [];
    if(prefs.getString(cart) != null){
      products  = dealProductModelFromJson(prefs.getString(cart)!) ;
    }
    products.remove(product);
    cartProducts.value = [...products];
    prefs.setString(cart, dealProductModelToJson(cartProducts.value));

  }
  void reduceProductQuantity(DealProductModel product){
    List<DealProductModel> products = [];
    if(prefs.getString(cart) != null){
      products  = dealProductModelFromJson(prefs.getString(cart)!) ;
    }
    DealProductModel p = products.firstWhere((element) => element.id == product.id);
    if(p.cartQuantity == 1){
      removeCartProduct(p);
    }else{
      p.cartQuantity--;
      products[products.indexWhere((element) => element.id == product.id)] = p;

    }
    cartProducts.value = [...products];
    prefs.setString(cart, dealProductModelToJson(cartProducts.value));

  }
  void addProductToCart(DealProductModel product) {

    List<DealProductModel> products = [];
    if(prefs.getString(cart) != null){
      products  = dealProductModelFromJson(prefs.getString(cart)!) ;
    }
    if(products.contains(product)){
      int oldProduct = products.indexWhere((element) => element.id == product.id);
      DealProductModel d = products.elementAt(oldProduct);
      d.cartQuantity++;
      products[oldProduct] = d;

    }else{
      products.add(product);
    }

    cartProducts.value = [...products];

    prefs.setString(cart, dealProductModelToJson(cartProducts.value));
  }

  void fetchCartProducts() {


    List<DealProductModel> products = [];
    if(prefs.getString(cart) != null){
      products  = dealProductModelFromJson(prefs.getString(cart)!) ;
    }
    cartProducts.value = [...products];
  }

  Future<OrderSubmittedModel> submitOrder(List<DealProductModel> products) async {

    return await _homePageService.submitOrder(products);

  }
}