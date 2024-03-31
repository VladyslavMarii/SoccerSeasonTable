import 'package:epl_season_table/screen/epl/epl_table.dart';
// import 'package:epl_season_table/screen/laliga/laliga_table.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeEplTableScreen(),
    );
  }
}
