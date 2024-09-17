import 'package:flutter/material.dart';
import 'package:allen/home_page.dart';
import 'package:allen/pallete.dart';
//import 'package:gemini_flutter/gemini_flutter.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  runApp(const MyApp());
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCSDDBMB4f6dU2Hdfvt16fLKgnz_ihRvf0');
  final content = [Content.text('Write a story about a AI and magic')];
  final response = await model.generateContent(content);
  print(response.text);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Pallete.whiteColor,
          )),
      title: 'Allen',
      home: const HomePage(),
    );
  }
}
