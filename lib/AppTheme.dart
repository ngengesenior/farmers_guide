import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black,
  onPrimary: Colors.white,
  secondary: Colors.grey,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
  primaryContainer: Colors.grey[300]!,
  onPrimaryContainer: Colors.black,
  secondaryContainer: Colors.grey[200]!,
  onSecondaryContainer: Colors.black,
  surfaceContainerHighest: Colors.grey[100]!,
  onSurfaceVariant: Colors.black,
  outline: Colors.grey[700]!,
);

final ThemeData appTheme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  textTheme: GoogleFonts.outfitTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: colorScheme.surface,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.surface,
    iconTheme: IconThemeData(color: colorScheme.onSurface),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: colorScheme.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
    ),
  ),
);