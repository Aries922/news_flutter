import 'package:flutter/material.dart';
import 'package:news_flutter/models/newsmodel.dart';
import 'package:news_flutter/provider/auth.dart';
import 'package:news_flutter/provider/news.dart';
import 'package:news_flutter/ui/loginPage.dart';
import 'package:news_flutter/ui/registerpage.dart';
import 'package:news_flutter/ui/splashpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(create: (_)=>NewsProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
      ),
    );
  }
}
