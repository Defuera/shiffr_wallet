
import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget page) => Navigator.push(
  context,
  new MaterialPageRoute(builder: (context) => page),
);