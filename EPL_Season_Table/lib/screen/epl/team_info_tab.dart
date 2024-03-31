import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../info/all_info_tab.dart';
import '../info/away_info_tab.dart';
import '../info/home_info.dart';

class TeamInfoScreen extends StatefulWidget {
  final Map<String, dynamic> eplTeam;

  const TeamInfoScreen({Key? key, required this.eplTeam}) : super(key: key);

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> _eplTeam;
  late TabController _tabController;
  late Map<String, dynamic> teamData = {};
  late Future<Map<String, dynamic>> _fetchTeamDataFuture;

  @override
  void initState() {
    super.initState();
    _eplTeam = widget.eplTeam;
    _tabController = TabController(length: 3, vsync: this);
    _fetchTeamDataFuture = fetchTeamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  _eplTeam['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchTeamDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildTeamInfo();
          }
        },
      ),
    );
  }

  Widget buildTeamInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: Center(
                child: Image.asset(
                  'assets/countries/england_flag.png',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'ENGLAND',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 213, 227, 239),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/epl/${_eplTeam['name'].toLowerCase().replaceAll(' ', '_')}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _eplTeam["name"],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Open the website link when tapped
                    launch(teamData['website']);
                  },
                  child: Text(
                    teamData['website'],
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration
                          .underline, // Add underline for hyperlink effect
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.grey.shade200, // Set the color of the divider
          thickness: 1, // Set the thickness of the divider
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
              height: 10,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 213, 227, 239),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Transform.scale(
                  scale: 0.8, // Adjust the scale factor as needed
                  child: Image.asset(
                    'assets/studium.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teamData['ground'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700, // Set color to gray
                  ),
                ),
                Text(
                  'Capacity: ${teamData['capacity']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Set color to gray
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home Info'),
            Tab(text: 'Away Info'),
            Tab(text: 'All Info'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              HomeInfoContent(someTeam: _eplTeam),
              AwayInfoContent(someTeam: _eplTeam),
              AllInfoContent(someTeam: _eplTeam),
            ],
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchTeamData() async {
    const String apiKey = '552295a42bmsh86a7f41465d14cbp13261cjsn5a354ed50973';

    final Uri url = Uri.https(
      'football-web-pages1.p.rapidapi.com',
      '/team.json',
      {
        'team': _eplTeam['id'].toString()
      }, // Convert team ID to string if it's an integer
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host':
              'football-web-pages1.p.rapidapi.com', // Change to the actual host name
        },
      );
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      setState(() {
        teamData = data['team'];
      });
      if (response.statusCode == 200) {
        // Successful response
        print(response.body);
      } else {
        // Handle other status codes
        print('Request failed with status: ${response.statusCode}');
      }
      return data;
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
      throw e;
    }
  }
}
