import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice1fromdocx/addnewitem.dart';
import 'package:practice1fromdocx/bottom_appbar.dart';
import 'package:practice1fromdocx/segmented_button.dart';
import 'package:practice1fromdocx/segmented_button.dart';
import 'counter.dart';
import 'linear_progressor.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: AddNewItem())),
    ),
  );
}
