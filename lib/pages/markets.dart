import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:flutter_crypto_tracker/widgets/crypto_list_tile.dart';
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
              onRefresh: () async {
                await marketProvider.getData();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoModel market = marketProvider.markets[index];
                    return CryptoListTile(market: market);
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
