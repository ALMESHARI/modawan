import 'package:flutter/material.dart';

// display for clickable text
//

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    bodyMedium: AppTextStyles.maintextstyle,
    displayMedium: AppTextStyles.clickabletext,
  ),
  brightness: Brightness.light,
  primaryColor: AppColors.darkblue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkblue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
  inputDecorationTheme: inputDecorationTheme,
);

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    bodyMedium: AppTextStyles.maintextstyle
        .copyWith(color: const Color.fromARGB(255, 223, 223, 223)),
    displayMedium:
        AppTextStyles.clickabletext.copyWith(color: AppColors.whiteblue),
  ),
  brightness: Brightness.dark,
  primaryColor: AppColors.darkblue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkblue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: elevatedButtonStyle.copyWith(
      backgroundColor: WidgetStateProperty.all(AppColors.whiteblue),
      foregroundColor: WidgetStateProperty.all(AppColors.darkblue),
    ),
  ),
  inputDecorationTheme: inputDecorationTheme,
);

ButtonStyle elevatedButtonStyle = ButtonStyle(
    shadowColor: WidgetStateProperty.all(mainBoxShadow.color),
    elevation: WidgetStateProperty.all(10),
    minimumSize: const WidgetStatePropertyAll(
      Size(300, 50),
    ),
    foregroundColor: WidgetStateProperty.all(AppColors.whiteblue),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttontextstyle),
    // add gradient color for the background

    backgroundColor: WidgetStateProperty.all(AppColors.darkblue),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // add box shadow
    ));

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  hintStyle: AppTextStyles.maintextstyle
      .copyWith(color: AppColors.inputplaceholdertext),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: AppColors.glasscolor,
  prefixIconColor: AppColors.darkblue,
  


);

class AppColors {
  const AppColors();

  static const Color regulartextcolor = Color(0xff595985);
  static const Color inputplaceholdertext = Color(0xffb1b1c9);
  static const Color darkblue = Color(0xff2a2a42);
  static const Color highlighttextcolor = Color(0xff9b9ad1);
  static const Color mainstroke = Color(0x1ab1b1c9);
  static const Color whiteblue = Color(0xfff9fafc);
  static const Color glasscolor = Color(0x66fafaff);
}

class AppTextStyles {
  const AppTextStyles();

  static TextStyle get maintextstyle => const TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        height: 12 / 12,
        letterSpacing: 0,
        color: AppColors.regulartextcolor,
      );

  static TextStyle get clickabletext => const TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        height: 13 / 13,
        letterSpacing: 0,
        color: AppColors.highlighttextcolor,
      );

  static TextStyle get buttontextstyle => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto-SemiBold',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      );
}

// create box shadow from figma where blur = 20 , spread and x and y = 0 color is 0000000 with 9% opacity
BoxShadow mainBoxShadow = const BoxShadow(
  blurStyle: BlurStyle.outer,
  color: Color.fromARGB(129, 134, 134, 134),
  blurRadius: 5,
  spreadRadius: 0,
  offset: Offset(0, 0),
);
