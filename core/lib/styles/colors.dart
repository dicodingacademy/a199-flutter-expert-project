import 'package:flutter/material.dart';

const Color kRichBlack = Color(0xFF000814);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kMikadoYellow = Color(0xFFffc300);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kGrey = Color(0xFF303030);

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryVariant: kMikadoYellow,
  secondary: kPrussianBlue,
  secondaryVariant: kPrussianBlue,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
