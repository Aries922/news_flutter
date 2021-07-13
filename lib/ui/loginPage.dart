import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_flutter/constants/strings.dart';
import 'package:news_flutter/constants/textStyle.dart';
import 'package:news_flutter/provider/auth.dart';
import 'package:news_flutter/ui/homepage.dart';
import 'package:news_flutter/ui/registerpage.dart';
import 'package:news_flutter/utils/button.dart';
import 'package:news_flutter/utils/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _isLoading = true;
    init();
  }

  bool _validator(BuildContext context) {
    // _isLoading = false;
    String? error;
    if (email.text.isEmpty || password.text.isEmpty) {
      error = "Check Your Credentials";
    } else if (password.text.length < 5) {
      error = "Password should be more then 5 alphabet";
    } else if (!email.text.contains('@')) {
      error = "Invalid Email";
    }
    if (error != null) {

      setState(() {       _isLoading = false;
});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
      ));
      // setState(() {
        
      // });
      
      

      return false;
    }

    return true;
  }

  Future _submit(BuildContext context) async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(email.text, password.text)
          .then((_) {
           
        setState(() {
          _isLoading = false;
        });
        save();

        
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  init() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Image.asset(
          "images/news.jpg",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                  child: Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Text(
                    "Welcome!!",
                    style: MyTextStyle.topText(),
                  ),
                )),
              )),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sign in",
                          style: MyTextStyle.headText(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          hint: "Enter Your Email",
                          contr: email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          hint: "Enter Your Password",
                          contr: password,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                            )),
                        SizedBox(
                          height: 2,
                        ),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : MyButton(
                                onClick: () {
                                  if (_validator(context) == true) {
                                    _submit(context).then((value) =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => HomePage()),
            (context) => false));
                                  }
                                  // setState(() {
                                  //   _isLoading = true;
                                  // });
                                },
                                name: " Sign in ",
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Divider(thickness: 2)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                child: Text(
                                  "Or Sign in with",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 2,
                              )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Image.asset(
                                  'images/google.png',
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Image.asset(
                                  'images/fb.png',
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage())),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Don't have an Account?",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    ));
  }

  save() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print("Saved Email Pasword");
    print(email.text + " password : " + password.text);
    localStorage.setString(EMAILKEY, email.text.toString());
    localStorage.setString(PASSWORDKEY, password.text.toString());
    // String time = DateTime.now().millisecondsSinceEpoch.toString();
    // print(time);
    // // DateTime prevTime = DateTime.parse(time);
    // String nowTime = DateTime.now().millisecondsSinceEpoch.toString();
    
  }
}
