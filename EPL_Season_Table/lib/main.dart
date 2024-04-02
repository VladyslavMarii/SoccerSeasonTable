import 'package:epl_season_table/screen/table_wrapper/table_wrapper_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TableWrapper(),
    );
  }
}
