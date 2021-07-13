import 'package:flutter/material.dart';

class 
MyTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? contr;
  MyTextField({ Key? key,this.hint , this.contr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9,right: 9),
      child: Container(
        decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: TextField(
                              cursorColor: Colors.brown,
                              controller: contr,
                                decoration:
                                    InputDecoration(hintText: "${hint}",border: InputBorder.none)),
                          ),
      ),
    );
  }
}