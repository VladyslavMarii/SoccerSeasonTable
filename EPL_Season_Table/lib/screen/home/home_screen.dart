import 'package:epl_season_table/screen/epl/epl_table.dart';
import 'package:epl_season_table/screen/laliga/laliga_table.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          _buildLeagueTile(context, 'Premier League', HomeEplTableScreen()),
          _buildLeagueTile(context, 'La Liga', HomeLaLigaTableScreen()),
          // Add more league tiles as needed
        ],
      ),
    );
  }

  Widget _buildLeagueTile(
      BuildContext context, String league, Widget leaguePage) {
    return ListTile(
      title: Text(league),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => leaguePage),
        );
      },
    );
  }
}
