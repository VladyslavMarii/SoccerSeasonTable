import 'package:epl_season_table/screen/table_wrapper/table_wrapper_page.dart';
import 'package:flutter/material.dart';

///[main] run application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///[TableWrapper] redirect to table wrapper
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TableWrapper(),
    );
  }
}
