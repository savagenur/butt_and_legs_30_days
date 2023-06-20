import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? width;
  final double? fontSize;
  final double paddingAll;

  const MyButtonWidget(
      {super.key,
      required this.text,
      this.onTap,
      this.backgroundColor = Colors.blue,
      this.width = double.infinity,
      this.fontSize = 20, this.paddingAll=10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Padding(
      padding: EdgeInsets.all(paddingAll),

          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
