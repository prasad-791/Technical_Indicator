import 'package:flutter/material.dart';
import 'package:technical_indicator/screens/technical_indicator_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  static const Color black = Color(0xFF000000);

  static const MaterialColor blackSwatch = MaterialColor(
    0xffe55f48,
    <int, Color>{
      50:  Color(0xffce5641 ),//10%
      100: Color(0xffb74c3a),//20%
      200: Color(0xffa04332),//30%
      300: Color(0xff89392b),//40%
      400: Color(0xff733024),//50%
      500: Color(0xff5c261d),//60%
      600: Color(0xff451c16),//70%
      700: Color(0xff2e130e),//80%
      800: Color(0xff170907),//90%
      900: Color(0xff000000),//100%
    },
  );

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: blackSwatch,
        primaryColor: Colors.white,
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
      ),
      initialRoute: TechnicalIndicator.routeName,
      routes: {
        TechnicalIndicator.routeName: (context) => const TechnicalIndicator(),
      },
    );
  }
}
