import 'package:blog/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputBorder _border({Color color = AppPallet.borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallet.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(
        color: AppPallet.gradient2.withOpacity(0.6),
      ),
      errorBorder: _border(
        color: AppPallet.errorColor,
      ),
      focusedErrorBorder: _border(
        color: AppPallet.gradient2.withOpacity(0.6),
      ),
      border: _border(),
    ),
  );
}
