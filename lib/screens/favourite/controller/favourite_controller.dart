import 'package:borsa_now_bis/screens/favourite/service/my_favourtie_service.dart';

import '../models/favourite_model.dart';

class FavouriteController   {
  final MyFavouriteService _service;

  FavouriteController(this._service) ;


  Future<List<FavouriteModel>> getMyFavourites ()async{
    return await _service.getMyFavourites();
  }
}