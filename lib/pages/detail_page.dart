import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/models/crypto.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  Widget titleAndDetail(String title,String detail, CrossAxisAlignment crossAxisAlignment){
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title,style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),),
        Text(detail,style: const TextStyle(
          fontSize: 18
        ),),
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20
        ),
        child: Consumer<MarketProvider>(
          builder: (context, marketProvider, child){
            CryptoModel currentCrypto = marketProvider.fetchCryptoById(widget.id);
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.getData();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                children: [
                  CircleAvatar(
                    radius: 80,
                    // radius: screenWidth * 0.2,
                    backgroundImage: NetworkImage(currentCrypto.image.toString()),
                  ),
                  const SizedBox(
                    height: 20,
                    // height: screenHeight * 0.03,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${currentCrypto.name.toString()} (${currentCrypto.symbol.toString().toUpperCase()}) " ,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        // fontSize: screenHeight * 0.08
                      ),),
                      Text( "₹ " + currentCrypto.currentPrice.toString() ,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        // fontSize: screenWidth * 0.08,
                        color: Colors.blue,
                      ),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text("Price Change (24h)", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),

                      Builder(
                        builder: (context) {
                          double priceChange = currentCrypto.priceChange24!;
                          double priceChangePercentage = currentCrypto.priceChangePercentage24!;

                          if(priceChange < 0) {
                            // negative
                            return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})", style: const TextStyle(
                                color: Colors.red,
                                fontSize: 23
                            ),);
                          }
                          else {
                            // positive
                            return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})", style: const TextStyle(
                                color: Colors.green,
                                fontSize: 23
                            ),);
                          }
                        },
                      ),

                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail("Market Cap", currentCrypto.marketCap.toString(), CrossAxisAlignment.start),
                      titleAndDetail("Market Cap Rank", "#" + currentCrypto.marketCapRank.toString(), CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      titleAndDetail("Low 24h", "₹ " + currentCrypto.low24!.toStringAsFixed(4), CrossAxisAlignment.start),

                      titleAndDetail("High 24h", "₹ " + currentCrypto.high24!.toStringAsFixed(4), CrossAxisAlignment.end),

                    ],
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toInt().toString(), CrossAxisAlignment.start),

                    ],
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      titleAndDetail("All Time Low", currentCrypto.atl!.toStringAsFixed(4), CrossAxisAlignment.start),

                      titleAndDetail("All Time High", currentCrypto.ath!.toStringAsFixed(4), CrossAxisAlignment.start),

                    ],
                  ),
                ],
              ),
            );
          },

        ),
      ),),
    );
  }
}
