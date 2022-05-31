import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/pages/pages.dart';
import 'package:qr_scanner_sqlite/providers/option_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers:  [
        ChangeNotifierProvider(create: ((context) =>  OptionSelected()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home_screen',
        routes: {
          'home_screen' : (context) => const HomePage(),
          'maps'        : (context) => const MapPage()
        },
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
      ),
    );
  }
}

