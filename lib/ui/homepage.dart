import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_flutter/constants/strings.dart';
import 'package:news_flutter/constants/textStyle.dart';
import 'package:news_flutter/provider/news.dart';
import 'package:news_flutter/utils/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showLike = false;
  bool buttonColor = false;
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    NewsProvider newsprovider =
        Provider.of<NewsProvider>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      newsprovider.getListNewsOnline();
    });
    print(newsprovider.newsList.data?.length);
    initData();
    _initializeTimer();
  }
 void _initializeTimer() {
  Timer.periodic(const Duration(seconds: 700), (_) => _logOut);
  }
  initData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    list = sharedPreferences.containsKey(FAVNEWS)
        ? sharedPreferences.getStringList(FAVNEWS)!
        : [];
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider newsprovider = Provider.of<NewsProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          newsprovider.newsList.data?.length == 0
              ? Expanded(
                  child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ))
              : Expanded(
                  child: ListView.builder(
                      itemCount: newsprovider.newsList.data?.length,
                      itemBuilder: (context, index) {
                        bool itemFav = list.contains(
                            newsprovider.newsList.data![index].id.toString());
                        if (showLike && !itemFav) return Container();

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 1, bottom: 1, right: 8, left: 8),
                          child: Card(
                            elevation: 3,
                            child:      ListTile(
                              // title: Text("Hello"),
                                  leading: GestureDetector(
                                    child: itemFav
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 35,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 35,
                                          ),
                                    onTap: () {
                                      savedFav(newsprovider
                                          .newsList.data![index].id!);
                                      setState(() {});
                                    },
                                  ),
                                  title: Text(
                                    "${newsprovider.newsList.data?[index].title}",
                                    style: MyTextStyle.cardTitle(),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${newsprovider.newsList.data?[index].summary}",
                                        style: MyTextStyle.cardSubtitle(),
                                      ),
                                      Text(
                                                  "${newsprovider.newsList.data![index].published}",
                                                  style: MyTextStyle.cardDate(),
                                                ),
                                    ],
                                  ),
                                ),
                                    
                                         // Container(
                                        //   width: 200,
                                        //   child: Column(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //       Flexible(
                                        //         flex: 2,
                                        //         child: Text(
                                        //           "${newsprovider.newsList.data?[index].title}",
                                        //           style: MyTextStyle.cardTitle(),
                                        //         ),
                                        //       ),
                                        //       Flexible(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "${newsprovider.newsList.data?[index].summary}",
                                        //           style: MyTextStyle.cardSubtitle(),
                                        //         ),
                                        //       ),
                                        //       Flexible(
                                        //         flex:1,
                                        //         child: Text(
                                        //           "${newsprovider.newsList.data![index].published}",
                                        //           style: MyTextStyle.cardDate(),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // )
                                     
                          ),
                        );
                      }),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeButton(
                box: SizedBox(
                  width: 14,
                ),
                onClick: () {
                  setState(() {
                    showLike = false;

                    print("fav");
                  });
                },
                name: "News",
                icon: showLike
                    ? Icon(
                        Icons.list,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                color: showLike ? Colors.white : Colors.blue,
                textStyle: showLike
                    ? MyTextStyle.blackButtonText()
                    : MyTextStyle.whiteButtonText(),
              ),
              SizedBox(width: 10,),
              HomeButton(
                box: SizedBox(
                  width: 0,
                ),
                onClick: () {
                  setState(() {
                    showLike = true;
                  });
                },
                name: "Favourite",
                icon: showLike
                    ? Icon(
                        Icons.favorite_sharp,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.favorite_sharp,
                        color: Colors.red,
                      ),
                color: showLike ? Colors.blue : Colors.white,
                textStyle: showLike
                    ? MyTextStyle.whiteButtonText()
                    : MyTextStyle.blackButtonText(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _logOut()async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print("Saved Email Pasword");
    localStorage.setString(EMAILKEY, "");
    localStorage.setString(PASSWORDKEY,"");
 
    
  }

  savedFav(int id) async {
    if (list.contains(id.toString()))
      list.remove(id.toString());
    else
      list.add(id.toString());
    print(list);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(FAVNEWS, list);
  }
}


