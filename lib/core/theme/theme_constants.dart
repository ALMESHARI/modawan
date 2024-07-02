import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// display for clickable text
//

ThemeData lightTheme = ThemeData(
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.whiteblue,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.whiteblue,
      systemNavigationBarIconBrightness: Brightness.dark,

      // Status bar color
      statusBarColor: AppColors.whiteblue,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
  ),
  scaffoldBackgroundColor: AppColors.whiteblue,
  fontFamily: 'Roboto-Regular',
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color.fromARGB(255, 61, 61, 61)),
  textButtonTheme: textButtonTheme,
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
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.darkBackground,
      systemNavigationBarIconBrightness: Brightness.light,

      // Status bar color
      statusBarColor: AppColors.darkBackground,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
    ),
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  fontFamily: 'Roboto-Regular',
  textButtonTheme: textButtonTheme,
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: AppColors.whiteblue),
  textTheme: TextTheme(
    bodyMedium: AppTextStyles.maintextstyle
        .copyWith(color: const Color.fromARGB(255, 223, 223, 223)),
    displayMedium:
        AppTextStyles.clickabletext.copyWith(color: AppColors.whiteblue),
  ),
  brightness: Brightness.dark,
  primaryColor: AppColors.whiteblue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkblue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: elevatedButtonStyle.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            AppColors.whiteblue.withOpacity(0.5);
          } else if (states.contains(WidgetState.disabled)) {
            return AppColors.whiteblue.withOpacity(0.6);
          }
          return AppColors.whiteblue
              .withOpacity(1); // Use the component's default.
        },
      ),
      foregroundColor: WidgetStateProperty.all(AppColors.darkblue),
    ),
  ),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    prefixIconColor: AppColors.whiteblue,
  ),
);

ButtonStyle elevatedButtonStyle = ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(
      Size(470, 50),
    ),
    foregroundColor: WidgetStateProperty.all(AppColors.whiteblue),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttontextstyle),
    // add gradient color for the background

    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          AppColors.darkblue.withOpacity(0.5);
        } else if (states.contains(WidgetState.disabled)) {
          return AppColors.darkblue.withOpacity(0.6);
        }
        return AppColors.darkblue
            .withOpacity(1); // Use the component's default.
      },
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: 15,
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
  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),

  hintStyle: AppTextStyles.maintextstyle
      .copyWith(color: AppColors.inputplaceholdertext),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
  // filled: true,
  // fillColor: AppColors.glasscolor,
  prefixIconColor: AppColors.darkblue,
);

TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: AppColors.highlighttextcolor,
    textStyle: AppTextStyles.clickabletext,
  ),
);

class AppColors {
  AppColors();
  //radial gradient from FFFFF to F9FAFF
  static const lightBackgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      AppColors.whiteblue,
      Colors.white,
      AppColors.whiteblue,

      // AppColors.darkblue,
      // Color.fromARGB(255, 255, 255, 255),
      // AppColors.darkblue,
    ],
    stops: <double>[0.0, 0.5, 1],
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color.fromARGB(255, 17, 17, 31),
      Color.fromARGB(255, 30, 30, 48)
    ],
    stops: <double>[1, 1.0],
  );

  static const Color regulartextcolor = Color(0xff595985);
  static const Color inputplaceholdertext = Color(0xffb1b1c9);
  static const Color darkblue = Color(0xff2a2a42);
  static const Color highlighttextcolor = Color(0xff9b9ad1);
  static const Color mainstroke = Color(0x1ab1b1c9);
  static const Color whiteblue = Color.fromARGB(255, 244, 246, 255);
  static const Color glasscolor = Color(0x66fafaff);
  static const Color darkBackground = Color.fromARGB(255, 17, 17, 31);
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
BoxShadow mainBoxShadow = BoxShadow(
  blurStyle: BlurStyle.outer,
  color: Colors.black26.withOpacity(0.1),
  blurRadius: 15,
  spreadRadius: 0,
  offset: const Offset(0, 0),
);
