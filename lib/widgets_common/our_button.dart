import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
        backgroundColor: color, padding: const EdgeInsets.all(12)),
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
