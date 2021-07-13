import 'package:flutter/material.dart';
import 'package:news_flutter/constants/textStyle.dart';
import 'package:news_flutter/provider/auth.dart';
import 'package:news_flutter/ui/loginPage.dart';
import 'package:news_flutter/utils/button.dart';
import 'package:news_flutter/utils/textfield.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  bool _isLoading = false;

  Future _submit() async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(email.text, username.text, password.text, password2.text)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("SuccessFully Registered"))));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  bool _validator(BuildContext context) {
    if (email.text.isEmpty ||
        password.text.isEmpty ||
        username.text.isEmpty ||
        password2.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Check Your Credentials"),
      ));
      return false;
    }
    if (!email.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Email"),
      ));
      return false;
    }
    if (password.text.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password should be more then 5 alphabet"),
      ));
      return false;
    }
    return true;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 95,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 95),
                      child: Text(
                        "Welcome!!",
                        style: MyTextStyle.topText(),
                      ),
                    )
                  ],
                ),
              )),
              Expanded(
                  flex: 2,
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
                              "Sign Up",
                              style: MyTextStyle.headText(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              hint: "Email",
                              contr: email,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              hint: "Username",
                              contr: username,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              hint: "Password",
                              contr: password,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              hint: "Re-Type Password",
                              contr: password2,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MyButton(
                                    onClick: () {
                                      if (_validator(context) == true) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _submit().then((value) =>
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage())));
                                      }
                                    },
                                    name: " Sign Up ",
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Divider(thickness: 2)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
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
                                      builder: (context) => LoginPage())),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Already have an Account?",
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                      text: ' Sign in',
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
}
