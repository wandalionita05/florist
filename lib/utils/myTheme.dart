import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static final lightTheme1 = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Color(0xff98A2B3),
      secondary: Colors.grey[300]!,
    ),
    primaryColor: const Color.fromARGB(255,224, 132, 154),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xff2382AA),
        selectedItemColor: const Color.fromARGB(255,224, 132, 154),
        unselectedItemColor: Color.fromARGB(255, 176, 176, 176),
        type: BottomNavigationBarType.shifting),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Color.fromARGB(255, 238, 185, 193),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 2, color: Color(0xffF1F1F5))),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(width: 2, color: Color(0xff2382AA)),
      ),
      constraints: BoxConstraints.expand(height: 48),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 2, color: const Color.fromARGB(255,224, 132, 154)),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(
              Color.fromARGB(255, 255, 255, 255)),
        )),
  );

  static final darkTheme2 = ThemeData(
    canvasColor: Color(0xff1A3848),
    primaryColor: const Color(0xff2382AA),
    colorScheme: ColorScheme.dark(
        surface: Color(0xff0D1F29),
        primary: Color.fromARGB(255, 236, 163, 178),
        secondary: Colors.grey[800]!),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff2382AA),
      selectedItemColor:
          Color.fromARGB(255, 255, 255, 255), // Selected item color
      unselectedItemColor: Colors.grey, // Unselected item color
    ),
    cardColor: Color.fromARGB(255, 236, 163, 178),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      surfaceTintColor: Color(0xff2382AA),
      shadowColor: Color(0xff2382AA),
      backgroundColor: Color(0xff0D1F29),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff1A3848),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: BoxConstraints.expand(height: 48),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 2, color: Color(0xff2382AA)),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
        ),
        menuStyle: MenuStyle(
          backgroundColor:
              WidgetStatePropertyAll<Color>(Color.fromARGB(255, 26, 56, 72)),
        )),
  );
}
