

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/models/api.dart';
import 'package:flutter_crypto_tracker/models/local_storage.dart';

class MarketProvider extends ChangeNotifier{

  bool isLoading = true;
  List<CryptoModel> markets = [];

  MarketProvider(){
    getData();
  }

  Future<void> getData() async{
    List<dynamic> _markets = await API.getMarkets();
    List<String> favourites = await LocalStorage.fetchFav();

    List<CryptoModel> temp = [];
    for(var market in _markets){
      CryptoModel newCrypto = CryptoModel.fromJSON(market);
      if (favourites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 2), (){
    //   getData();
    // });

  }
   CryptoModel fetchCryptoById(String id){
    CryptoModel crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
   }

   void addFavourite(CryptoModel crypto) async{
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFav(crypto.id!);
    notifyListeners();
   }

   void removeFavourite(CryptoModel crypto) async{
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFav(crypto.id!);
    notifyListeners();
   }

}