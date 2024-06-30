import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Function onButtonClickedCallBack;
  CustomButton({required this.buttonText, required this.onButtonClickedCallBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
onButtonClickedCallBack();
    }, child: Text(buttonText));
  }
}
