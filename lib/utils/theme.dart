import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: black,
    brightness: Brightness.dark,
      primaryColor: kPrimaryColor,


  );
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,

  );
}

class ThemeServices{
  final box = GetStorage();
  final key = 'isLightMode';

  bool loadThemeFromBox() =>box.read(key)??false;
  saveThemeToBox(bool isLightMode) => box.write(key, isLightMode);
  ThemeMode get theme => loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  switchTheme(){
    Get.changeThemeMode(loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    bool isDarkTheme = saveThemeToBox(!loadThemeFromBox());
    return isDarkTheme;
  }
  bool ThemeModes(){
    bool isDark= Get.isDarkMode?  true: false;
    return isDark;
  }
}

// Colors and styles

const grey = Color(0xFFEAEAEA);
const Color blueColor = Color(0xFF4e5ae8);
const grey2 = Color(0xFF6D6D6D);
const black = Color(0xFF1C1C1C);
const black2 = Color(0xFF424242);
const redColor = Color(0xFFFDE0A26);
const white = Colors.white;
const kPrimaryColor = blueColor;

var headerNotesStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 45.0,
    color: white,
    fontWeight: FontWeight.bold,
  ),
);
enum EditMode {
  ADD,
  UPDATE,
}
var noNotesStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
  ),
);
var boldPlus = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 30.0,
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
  ),
);
var itemTitle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 20.0,
    color: black,
    fontWeight: FontWeight.bold,
  ),
);
var itemDateStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 12.0,
    color: grey2,
  ),
);
var itemContentStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: grey2,
  ),
);
var viewTitleStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w900,
  fontSize: 28.0,
);
var viewContentStyle = GoogleFonts.roboto(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400);
var createTitle = GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w900,
    ));
var createContent = GoogleFonts.roboto(
  textStyle: TextStyle(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400,
  ),
);

var btnTxtStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: black,
    fontWeight: FontWeight.bold,
  ),
);

var shadow = [
  BoxShadow(
    color: black2,
    blurRadius:30,
    offset: Offset(0,10),
  )
];
