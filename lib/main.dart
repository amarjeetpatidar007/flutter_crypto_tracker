import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/constants/theme.dart';
import 'package:flutter_crypto_tracker/pages/home_page.dart';
import 'package:flutter_crypto_tracker/providers/market_provider.dart';
import 'package:flutter_crypto_tracker/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'models/local_storage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(theme: currentTheme));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<MarketProvider>(create: (context) => MarketProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider('d'))
    ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child){
          return MaterialApp(
            title: "Crypto Tracker",
            home: const HomePage(),
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
