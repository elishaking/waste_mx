import 'package:flutter/material.dart';

double getSize(BuildContext context, final double default_1440) {
  return (default_1440 / 14) * (0.0027 * MediaQuery.of(context).size.width + 10.136);
}