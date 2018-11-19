
import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget page) => Navigator.push(
  context,
  new MaterialPageRoute(builder: (context) => page),
);

/// Navigates to given page and removes all the other pages from history
void navigateAsNewRoot(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
}