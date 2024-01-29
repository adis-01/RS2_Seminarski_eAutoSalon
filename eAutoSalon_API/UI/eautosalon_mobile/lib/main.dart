import 'dart:io';

import 'package:eautosalon_mobile/providers/accessory_provider.dart';
import 'package:eautosalon_mobile/providers/car_provider.dart';
import 'package:eautosalon_mobile/providers/comment_provider.dart';
import 'package:eautosalon_mobile/providers/employee_provider.dart';
import 'package:eautosalon_mobile/providers/news_provider.dart';
import 'package:eautosalon_mobile/providers/review_provider.dart';
import 'package:eautosalon_mobile/providers/test_drive_provider.dart';
import 'package:eautosalon_mobile/providers/transaction_provider.dart';
import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = const String.fromEnvironment('pubKey', defaultValue: pubKey);
  HttpOverrides.global=MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OpremaProvider()),
        ChangeNotifierProvider(create: (_) => TestDriveProvider()),
        ChangeNotifierProvider(create: (_) => KomentarProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider())
      ],
      child: const MyApp(),
    )
  );
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialScreen(),
    );
  }
}


