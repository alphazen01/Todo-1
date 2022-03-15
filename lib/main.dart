import 'package:demo/screens/custom_splash.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:HomeScreen()
      home: SplashScreen(),
    )
  );
}


