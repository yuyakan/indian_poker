import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indian_poker/IndianPokerView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
