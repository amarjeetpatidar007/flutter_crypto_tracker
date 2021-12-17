import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/pages/detail_page.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoModel market;

  const CryptoListTile({Key? key, required this.market}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(context,listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return DetailPage(id: market.id!);
            }));
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(market.image.toString()),
      ),
      title: Row(children: [
        Flexible(
          child: Text(
              "#${market.marketCapRank.toString()} ${market.name.toString()}",
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(
          width: 8,
        ),
        (market.isFavorite == false)
            ? GestureDetector(
          onTap: () {
            marketProvider.addFavourite(market);
          },
          child: const Icon(
            CupertinoIcons.heart,
            size: 20,
          ),
        )
            : GestureDetector(
            onTap: () {
              marketProvider.removeFavourite(market);
            },
            child: const Icon(
              CupertinoIcons.heart_solid,
              size: 20,
            ))
      ]),
      subtitle: Text(market.symbol.toString().toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + market.currentPrice!.toStringAsFixed(3),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.blue),
          ),
          Builder(
            builder: (context) {
              double priceChange = market.priceChange24!;
              double priceChangePercentage =
              market.priceChangePercentage24!;

              if (priceChange < 0) {
                return Text(
                  "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  "+${priceChangePercentage.toStringAsFixed(2)}%  (+${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.green),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
