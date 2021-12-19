
import 'package:flutter/material.dart';

List<Color> indicatorColors = [
  const Color.fromRGBO(0, 122, 255,1),
  const Color.fromRGBO(0, 122, 255,0.6),
  const Color.fromRGBO(255, 185, 70,1),
  const Color.fromRGBO(255, 46, 80, 0.6),
  const Color.fromRGBO(255, 46, 80, 1),
];

List<String> indicatorLabels = [
  "STRONG BUY",
  "BUY",
  "NEUTRAL",
  "SELL",
  "STRONG SELL",
];

List<int> positions = [
  10,
  30,
  50,
  70,
  90,
];

List<String> timeInstances = [
  "1 MIN",
  "5 MIN",
  "15 MIN",
  "30 MIN",
  "1 HR",
  "5 HR",
  "1 DAY",
  "1 WK",
  "1 MON",
];