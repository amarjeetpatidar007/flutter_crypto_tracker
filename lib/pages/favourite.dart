import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:flutter_crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<MarketProvider>(
      builder: (context, marketProvider,child){
        List<CryptoModel> cryptos = marketProvider.markets.where((element) => element.isFavorite == true).toList();
        if (cryptos.isNotEmpty) {
          return ListView.builder(itemCount: cryptos.length ,
              itemBuilder: (context, index){
                return CryptoListTile(market: cryptos[index]);
              });
        }else{
          return const Center(child: Text('No Favourites Yet!',style: TextStyle(
            color: Colors.grey,
            fontSize: 15
          ),),);
        }

      },
    ));
  }
}
