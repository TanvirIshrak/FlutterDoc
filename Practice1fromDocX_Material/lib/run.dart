import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice1fromdocx/segmented_button.dart';
import 'package:practice1fromdocx/segmented_button.dart';
import 'counter.dart';
import 'linear_progressor.dart';

void main(){
  runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: ProgressIndicatorExampleApp()
          ),
        ),
      )
  );
}