import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as admob;
import 'package:indian_poker/Ad/InterstitialAd.dart';
import 'package:indian_poker/IndianPokerView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  admob.MobileAds.instance.initialize();
  InterstitialAd.instance.load();
  SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Indian poker',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const IndianPokerView(),
    );
  }
}
