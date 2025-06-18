import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomThemeStyle {
  CustomThemeStyle._();
  static TextTheme textThemeCustom(Color color) => TextTheme(
    headlineLarge: TextStyle().copyWith(fontSize: 32.sp, color: color),
    headlineMedium: TextStyle().copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    headlineSmall: TextStyle().copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    titleLarge: TextStyle().copyWith(fontSize: 16.sp, color: color),
    titleMedium: TextStyle().copyWith(fontSize: 16.sp, color: color),
    titleSmall: TextStyle().copyWith(fontSize: 16.sp, color: color),
    bodyLarge: TextStyle().copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: color,
    ),
    bodyMedium: TextStyle().copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: color,
    ),
    bodySmall: TextStyle().copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: color.withValues(alpha: 0.5),
    ),
    labelLarge: TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: color,
    ),
    labelMedium: TextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: color.withValues(alpha: 0.5),
    ),
  );

  static ElevatedButtonThemeData elevationButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: BorderSide(color: Colors.blue),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );

  static AppBarTheme appBarTheme() => AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24.r),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24.r),
    titleTextStyle: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static BottomSheetThemeData bottomSheetTheme(Color color) =>
      BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: color, //light: color white, dark : color black
        modalBackgroundColor: color, //light: color white, dark : color black
        constraints: BoxConstraints(minWidth: double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      );
  static CheckboxThemeData checkboxTheme() => CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : Colors.black;
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.blue
          : Colors.transparent;
    }),
  );
  static ChipThemeData chipTheme(
    Color disabledColor,
    Color labelColor,
  ) => ChipThemeData(
    disabledColor:
        disabledColor, // light: Colors.grey.withValues(alpha: 0.4), dark: Colors.grey
    labelStyle: TextStyle(
      color: labelColor,
    ), //light : Colors.black, dark : Colors.white
    selectedColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
    checkmarkColor: Colors.white,
  );
  static OutlinedButtonThemeData outlinedButtonTheme(
    Color color,
    Color borderColor,
  ) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: color, //light: Colors.black, dark: Colors.white
      side: BorderSide(
        color: borderColor,
      ), //light: Colors.blue, dark : Colors.blueAccent
      textStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: color, //light: Colors.black, dark: Colors.white
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
    ),
  );
  static InputDecorationTheme inputDecorationTheme(
    Color color,
    Color focusColor, {
    bool isDark = false,
  }) => InputDecorationTheme(
    errorMaxLines: isDark ? 2 : 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(
      fontSize: 14.sp,
      color: color,
    ), // is dark color:white, light: color:black
    hintStyle: TextStyle().copyWith(
      fontSize: 14.sp,
      color: color,
    ), // is dark color:white, light: color:black
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(
      color: Colors.black.withValues(alpha: 0.8),
    ),
    border: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(
        width: 1,
        color: focusColor,
      ), // is dark color:white, light: color:black12
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 2, color: Colors.orange),
    ),
  );
}
