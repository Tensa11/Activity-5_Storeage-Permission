import 'package:flutter/material.dart';
import 'package:activity5_salas/HomePage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Activity #5 Salas',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const Home_Page(),
  )
  );
}