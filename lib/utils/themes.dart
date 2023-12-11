import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
      primaryColorDark: Color.fromARGB(255, 22, 48, 92),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 215, 215, 215),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(
              fontFamily: 'Poppins', fontSize: 25, color: Colors.black),
          menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.amber)),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Color.fromARGB(255, 205, 205, 205),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xFF1C2434))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
          )),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 215, 215, 215),
      cardColor: const Color.fromARGB(255, 205, 205, 205),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Color(0xFF1C2434)),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF1C2434))),
          hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: Color.fromARGB(127, 0, 0, 0)),
          errorStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: Color.fromARGB(255, 180, 24, 13)),
          labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: Color.fromARGB(156, 0, 0, 0)),
          iconColor: const Color(0xFF1C2434),
          prefixIconColor: const Color(0xFF1C2434),
          suffixIconColor: const Color(0xFF1C2434),
          fillColor: const Color.fromARGB(255, 222, 222, 222),
          filled: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFF1C2434)),
              elevation: const MaterialStatePropertyAll(1.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              )),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10)))),
      textTheme: const TextTheme(
        bodyLarge:
            TextStyle(fontFamily: 'Poppins', fontSize: 25, color: Colors.black),
        bodyMedium:
            TextStyle(fontFamily: 'Poppins', fontSize: 17, color: Colors.black),
        bodySmall:
            TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black),
        titleMedium:
            TextStyle(fontFamily: 'Poppins', fontSize: 25, color: Colors.black),
        titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 27,
            color: Colors.black,
            fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w400),
        labelMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        displayLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 90,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1C2434),
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C2434),
          titleSpacing: 1.0,
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0)));
  final darkTheme = ThemeData.dark().copyWith(
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(49, 48, 74, 1),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle:
            TextStyle(fontFamily: 'Poppins', fontSize: 25, color: Colors.white),
        menuStyle:
            MenuStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color.fromARGB(255, 66, 79, 105),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        )),
    cardColor: const Color.fromARGB(255, 20, 25, 37),
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color.fromARGB(255, 66, 79, 105)),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white)),
        hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color.fromARGB(126, 255, 255, 255)),
        errorStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color.fromARGB(255, 180, 24, 13)),
        labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color.fromARGB(156, 255, 255, 255)),
        iconColor: const Color(0xFF1C2434),
        prefixIconColor: const Color(0xFF1C2434),
        suffixIconColor: const Color(0xFF1C2434),
        fillColor: const Color.fromARGB(255, 48, 64, 96),
        filled: true),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1C2434),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 14, 46, 105)),
            elevation: const MaterialStatePropertyAll(1.0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10)))),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      bodyMedium:
          TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Colors.white),
      bodySmall:
          TextStyle(fontFamily: 'Poppins', fontSize: 13, color: Colors.white),
      titleMedium:
          TextStyle(fontFamily: 'Poppins', fontSize: 25, color: Colors.white),
      titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 27,
          color: Colors.white,
          fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 90,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(49, 48, 74, 1),
    primaryColor: const Color(0xFF1C2434),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1C2434),
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1C2434),
        titleSpacing: 1.0,
        titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0)),
  );
}
