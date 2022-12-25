import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData LightAppTheme() => ThemeData(
      primaryColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.black),
      appBarTheme: const AppBarTheme(
 
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        color: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(size: 15),
      ),
      textTheme: const TextTheme(
        
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
ThemeData DarkAppTheme() => ThemeData(
       primaryColor: Colors.white,
      dividerColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        color: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 15),
          unselectedItemColor: Colors.blueGrey),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
