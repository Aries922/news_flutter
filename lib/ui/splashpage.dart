import 'package:flutter/material.dart';
import 'package:news_flutter/constants/textStyle.dart';
import 'package:news_flutter/provider/auth.dart';
import 'package:news_flutter/ui/homepage.dart';
import 'package:news_flutter/ui/registerpage.dart';
import 'package:news_flutter/utils/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth authProvider = Provider.of(context,listen: false);
    authProvider.autoLogin().then((islOggedIN) {
      Future.delayed(Duration(seconds: 1)).then((_) {

        if (islOggedIN)
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => HomePage()),
              (context) => false);
        else
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => RegisterPage()),
              (context) => false);
      });
    });
    return Scaffold(
      // backgroundColor: Color,
      body: Container(
        child: Center(
          child: Text(
            "News",
            style: MyTextStyle.firstPageText(),
          ),
        ),
      ),
    );
  }
}
