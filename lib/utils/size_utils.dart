import 'package:flutter/widgets.dart';

double px(double value, BuildContext context) =>
    value * MediaQuery.of(context).devicePixelRatio;
