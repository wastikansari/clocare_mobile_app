import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final FontWeight? fontweights;
  final TextDecoration? decoration;
  double size;
  TextOverflow overFlow;
  SmallText({
    Key? key,
    this.color = Colors.grey,
    required this.text,
    this.size = 13,
    this.overFlow = TextOverflow.ellipsis,
     this.fontweights = FontWeight.normal, this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
         decoration: decoration,
        fontFamily: 'VremenaGroteskBook',
        fontSize: size,
        fontWeight: fontweights,
        color: color,
        
      ),
    );
  }
}
