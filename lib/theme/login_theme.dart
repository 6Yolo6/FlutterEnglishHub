// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const MAIN_COLOR = Color(0xFF303030);
const DARK_COLOR = Color(0xFFBDBDBD);
const BOTTOM_COLORS = [MAIN_COLOR, DARK_COLOR];
const YELLOW = Color(0xfffbed96);
const BLUE = Color(0xffabecd6);
const BLUE_DEEP = Color(0xffA8CBFD);
const BLUE_LIGHT = Color(0xffAED3EA);
const PURPLE = Color(0xffccc3fc);
const SIGNUP_LIGHT_RED = Color(0xffffc2a1);
const SIGNUP_RED = Color(0xffffb1bb);
const RED = Color(0xffF2A7B3);
const GREEN = Color(0xffc7e5b4);
const RED_LIGHT = Color(0xffFFC3A0);
const TEXT_BLACK = Color(0xFF353535);
const TEXT_BLACK_LIGHT = Color(0xFF34323D);

const LinearGradient SIGNUP_BACKGROUND = LinearGradient(
  begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.9], colors: [YELLOW, BLUE],
);

const LinearGradient SIGNUP_CARD_BACKGROUND = LinearGradient(
  tileMode: TileMode.clamp,
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  stops: [0.1, 1.0],
  colors: [SIGNUP_LIGHT_RED, SIGNUP_RED],
);

const LinearGradient SIGNUP_CIRCLE_BUTTON_BACKGROUND = LinearGradient(
  tileMode: TileMode.clamp,
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.4, 1],
  colors: [Colors.black, Colors.black54],
);

TextStyle hintAndValueStyle = const TextStyle(
color: Color(0xff353535),
fontWeight: FontWeight.bold,
fontSize: 14.0,
fontFamily: 'Montserrat'
);
