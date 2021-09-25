import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key? key,
    this.borderRadius = 8.0,
    this.textColor = Colors.white,
    this.fontSize = 18.0,
    this.color,
    this.onPressed,
    this.text,
    this.height = 50.0,
    this.child,
    this.image,
  }) : super(key: key);
  @required
  final String? text;
  final Color? color;
  final Color textColor;
  @required
  final VoidCallback? onPressed;
  final double borderRadius;
  final double height;
  final double fontSize;
  @required
  final String? image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

class BuildText extends CustomRaisedButton {
  const BuildText({
    Key? key,
    text,
    textColor,
    fontSize = 18.0,
  }) : super(
          key: key,
          text: text,
          textColor: textColor,
          fontSize: fontSize,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }
}

class BuildRow extends CustomRaisedButton {
  const BuildRow({Key? key, text, textColor, fontSize = 18.0, image})
      : super(
          key: key,
          text: text,
          textColor: textColor,
          fontSize: fontSize,
          image: image,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          image!,
        ),
        Text(
          text!,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: Image.asset(
            image!,
          ),
        ),
      ],
    );
  }
}
