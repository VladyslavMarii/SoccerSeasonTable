import 'package:epl_season_table/screen/epl/epl_table.dart';
import 'package:epl_season_table/screen/laliga/laliga_table.dart';
import 'package:flutter/material.dart';

class TableWrapper extends StatefulWidget {
  const TableWrapper({super.key});

  @override
  State<TableWrapper> createState() => _TableWrapperState();
}

class _TableWrapperState extends State<TableWrapper> {
  final Map<String, String> dropdownItems = {
    'epl': 'Premier League',
    'laliga': 'La Liga',
  };

  String _currentDropdownElement = 'epl';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              padding:
                  const EdgeInsets.all(9.0), // Adjust the padding as needed
              child: _currentDropdownElement == 'epl'
                  ? Image.asset(
                      'assets/epl/epl.png',
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/laliga/laliga-logo.png'),
            ),
            DropdownButton(
              value: _currentDropdownElement,
              items: dropdownItems.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(dropdownItems[e]!),
                      ))
                  .toList(),
              onChanged: ((value) {
                setState(() {
                  _currentDropdownElement = value ?? 'epl';
                });
              }),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: constraints.maxWidth > 500 ? 500 : double.infinity,
            child: _currentDropdownElement == 'epl'
                ? const HomeEplTableScreen()
                : const HomeLaLigaTableScreen(),
          ),
        );
      }),
    );
  }
}
