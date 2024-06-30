import 'package:flutter/material.dart';

class MyThemeData{
  static const Color lightPrimaryColor = Color(0xFF5D9CEC);
  static const Color darkPrimaryColor = Color(0xFF5D9CEC);
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )

    ),

      bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: lightPrimaryColor,
        unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
            size: 30,
          )
      )
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: Color(0xFF060E1E),
      textTheme: TextTheme(
          titleSmall: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
          labelSmall: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
      ),
      bottomNavigationBarTheme:BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: darkPrimaryColor,
      unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: 30,
          )
  )

  );
}