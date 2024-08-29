import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/widget/drawer.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.onSurface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Declare _isDarkMode as a member variable
  bool _isDarkMode = false;

  // Method to toggle dark mode
  void onDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle the value
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        textTheme: const TextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 12, 12, 13),
        textTheme: const TextTheme(),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(
        gpa: 0,
        credits: 0,
        onDarkMode: onDarkMode,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}
