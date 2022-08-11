import 'package:flutter/material.dart';
import 'package:wimf/styles/style.dart';

class AppButton extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;
  const AppButton({Key? key, required this.content, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(content, style: textStyle),
            style: roundedStyle,
          ),
        ),
        padding: const EdgeInsets.all(5),
      );
}
