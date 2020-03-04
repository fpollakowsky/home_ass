import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

// General
const TextStyle H1B = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,decoration: TextDecoration.none);
const TextStyle H1 = TextStyle(fontSize: 24, color: Colors.white,decoration: TextDecoration.none);
const TextStyle H2 = TextStyle(fontSize: 22, color: Colors.white,decoration: TextDecoration.none);
const TextStyle H3 = TextStyle(fontSize: 18, color: Colors.white,decoration: TextDecoration.none);
const TextStyle H4G = TextStyle(fontSize: 14, color: Colors.grey,decoration: TextDecoration.none);

// Setting styles
const TextStyle settingsH1 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, decoration: TextDecoration.none);
const TextStyle settingsH2 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5);
const TextStyle settingsH3 = TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 0.5);
const TextStyle settingsH3B = TextStyle(fontSize: 16, letterSpacing: 0.5);
const TextStyle settingsH4G = TextStyle(fontSize: 14, color: Colors.grey, letterSpacing: 0.5);

const OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  borderSide: BorderSide(width: 2,color: Color(0xffbf360c)),
);

const OutlineInputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  borderSide: BorderSide(width: 1,)
);

// Dashboard styles
const TextStyle dashboardCard2 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5);

// Profile styles
const TextStyle profileH1 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,decoration: TextDecoration.none);
const TextStyle profileH4 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,decoration: TextDecoration.none);
