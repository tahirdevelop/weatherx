import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPressed;

  const AppButton(this.text, {this.icon, this.onPressed, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      onPressed: onPressed,
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white.withOpacity(0.23),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color.fromRGBO(184, 210, 228, 1)),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null) Icon(icon, size: 30, color: Colors.white),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  offset: Offset(-2, 2),
                  color: Colors.black.withOpacity(.2),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
