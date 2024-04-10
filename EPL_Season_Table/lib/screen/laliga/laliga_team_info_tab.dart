import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../info/all_info_tab.dart';
import '../info/away_info_tab.dart';
import '../info/home_info.dart';

///[LaLigaTeamInfoScreen] class that we go to if choose specific team
///we want to see more info of
class LaLigaTeamInfoScreen extends StatefulWidget {
  ///[laligaTeam] info about current team that we choose
  final Map<String, dynamic> laligaTeam;

  const LaLigaTeamInfoScreen({Key? key, required this.laligaTeam})
      : super(key: key);

  @override
  State<LaLigaTeamInfoScreen> createState() => _LaLigaTeamInfoScreen();
}

class _LaLigaTeamInfoScreen extends State<LaLigaTeamInfoScreen>
    with SingleTickerProviderStateMixin {
  ///[_laligaTeam] making it easier to call current team
  late Map<String, dynamic> _laligaTeam;

  ///[_tabController] controlling which info we want to see about choosen team:
  ///all info/away info/home info
  late TabController _tabController;

  ///[teamData] additional data for curent team
  late Map<String, dynamic> teamData = {};

  ///[_fetchTeamDataFuture] future data of current choosen team
  late Future<Map<String, dynamic>> _fetchTeamDataFuture;

  ///[initState]initialization of eplTeam, tabcontroller, calling api and return
  ///team data from api
  @override
  void initState() {
    super.initState();
    _laligaTeam = widget.laligaTeam;
    _tabController = TabController(length: 3, vsync: this);
    _fetchTeamDataFuture = fetchTeamData();
  }

  ///[build]widget that displays loading circle if data is still loading from api
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
                  _laligaTeam['name'],
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
                  'assets/countries/spain_flag.png',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'SPAIN',
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
                  'assets/laliga/${_laligaTeam['name'].toLowerCase().replaceAll(' ', '_')}.png',
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
                  _laligaTeam["name"],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
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
              HomeInfoContent(someTeam: _laligaTeam),
              AwayInfoContent(someTeam: _laligaTeam),
              AllInfoContent(someTeam: _laligaTeam),
            ],
          ),
        ),
      ],
    );
  }

  ///[fetchData] function that calls api. It sends https request to football-web-pages1.p.rapidapi.com
  ///and returns all data that was returned from that call
  Future<Map<String, dynamic>> fetchTeamData() async {
    const String apiKey = '552295a42bmsh86a7f41465d14cbp13261cjsn5a354ed50973';

    final Uri url = Uri.https(
      'football-web-pages1.p.rapidapi.com',
      '/team.json',
      {
        'team': _laligaTeam['id'].toString()
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
