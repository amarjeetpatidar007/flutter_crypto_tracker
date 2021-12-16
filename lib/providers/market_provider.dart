

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/models/api.dart';

class MarketProvider extends ChangeNotifier{

  bool isLoading = true;
  List<CryptoModel> markets = [];

  MarketProvider(){
    getData();
  }

  void getData() async{
    List<dynamic> _markets = await API.getMarkets();

    List<CryptoModel> temp = [];
    for(var market in _markets){
      CryptoModel newCrypto = CryptoModel.fromJSON(market);
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 4), (){
      getData();
    });
  }
}