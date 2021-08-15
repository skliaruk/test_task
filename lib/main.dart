import 'package:flutter/material.dart';
import 'package:junior_test/tools/Strings.dart';
import 'package:junior_test/ui/actions/ActionsWidget.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';
import 'package:junior_test/ui/views/appbar/FixedAppBar.dart';
import 'package:junior_test/ui/views/appbar/flexible/FlexAppBar.dart';

void main() {
  runApp(MaterialApp(
      routes: {ActionsItemWidget.TAG: (context) => ActionsItemWidget()},
      home: FlexAppBar(Strings.actions, Text('ds'), ActionsWidget(), false)));
}
