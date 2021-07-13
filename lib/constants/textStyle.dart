import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  static headText() => TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 44, 87, 1.0));
  static buttonText() => TextStyle(fontSize: 20,);
  static blackButtonText() => TextStyle(fontSize: 20,color: Colors.black);
  static whiteButtonText() => TextStyle(fontSize: 20,color: Colors.white);
  static topText() => TextStyle(fontSize: 40,color:Colors.white );
  static firstPageText() => TextStyle(fontSize: 40,color:Colors.blue[800] );
  static cardTitle() => TextStyle(fontSize: 18,color:Colors.black ,fontWeight: FontWeight.bold);
  static cardSubtitle() => TextStyle(fontSize: 15,color:Colors.black );
  static cardDate() => TextStyle(fontSize: 11,color:Colors.grey );
}