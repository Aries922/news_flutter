import 'package:flutter/material.dart';
import 'package:news_flutter/constants/textStyle.dart';

class MyButton extends StatelessWidget {
  final Function? onClick;

  final String name;
  const MyButton({
    Key? key,
    this.name = "",
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onClick!();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${name}",
          style: MyTextStyle.buttonText(),
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(8, 177, 228, 1.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    );
  }
}

class HomeButton extends StatelessWidget {
  final SizedBox? box;
  final Function? onClick;
  final Icon? icon;
  final Color? color;
  final String name;
  final TextStyle? textStyle;
  const HomeButton(
      {Key? key,
      this.name = "",
      @required this.onClick,
      this.icon,
      this.color,
      this.textStyle,
      this.box})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onClick!();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              children: [
                box!,
                icon!,
                Padding(padding: EdgeInsets.all(3)),
                Text(
                  "${name}",
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color!),
        ),
      ),
    );
  }
}
