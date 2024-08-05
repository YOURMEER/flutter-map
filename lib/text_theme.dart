import 'package:flutter/material.dart';
import 'package:fluttermap/text_strings.dart';

class   TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
  InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      prefixIconColor: tSecondaryColor,
      floatingLabelStyle: TextStyle(color: tSecondaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width:2, color: tSecondaryColor),
      ));


  static  InputDecorationTheme darkInputDecorationTheme =
  InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: tPrimaryColor,
      floatingLabelStyle: TextStyle(color: tPrimaryColor),
      focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(width:2, color: tPrimaryColor)

      ),
  );
}
