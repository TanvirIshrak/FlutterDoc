import 'package:flutter/material.dart';
import 'package:practice1fromdocx/mini_projects/Book_loader_app/screens/homepage.dart';

class BookLoaderApp extends StatelessWidget {
  const BookLoaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Async Book Loader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: BookHomePage(),
    );
  }
}


















