import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';

class MarketList extends StatefulWidget {
  const MarketList({Key? key}) : super(key: key);

  @override
  _MarketListState createState() => _MarketListState();
}

class _MarketListState extends State<MarketList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh:() async{
                await marketProvider.getData();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoModel market = marketProvider.markets[index];
                    return ListTile(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return DetailPage(id: market.id!);
                            })
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                        NetworkImage(market.image.toString()),
                      ),
                      title: Text(
                          "#${market.marketCapRank.toString()} ${market.name.toString()}"),
                      subtitle:
                      Text(market.symbol.toString().toUpperCase()),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹ " +
                                market.currentPrice!.toStringAsFixed(3),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue),
                          ),
                          Builder(
                            builder: (context) {
                              double priceChange =
                              market.priceChange24!;
                              double priceChangePercentage =
                              market.priceChangePercentage24!;

                              if (priceChange < 0) {
                                return Text(
                                  "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                                  style: const TextStyle(
                                      color: Colors.red),
                                );
                              } else {
                                return Text(
                                  "+${priceChangePercentage.toStringAsFixed(2)}%  (+${priceChange.toStringAsFixed(4)})",
                                  style: const TextStyle(
                                      color: Colors.green),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return const Text('Data not found');
          }
        }
      },
    );
  }
}
