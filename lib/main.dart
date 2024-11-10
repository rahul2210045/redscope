import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redscope_assignment/screens/gallery/ui/Gallery_Screen.dart';
import 'package:redscope_assignment/screens/home/ui/Home_Screen.dart';
// import 'package:redscope_assignment/screens/home_screen.dart';
import 'screens/Splash_Screen.dart';
// import 'screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // Start with the SplashScreen
      routes: {
        '/home': (context) => HomeScreen(),
        '/gallery': (context) => GalleryPage(),
         // Route to the HomeScreen
      },
    );
  }
}
