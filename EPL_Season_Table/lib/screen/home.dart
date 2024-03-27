import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List teams = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPL TABLE'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 64,
              ),
              Expanded(
                child: Text(
                  'Team',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    'G',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: Text(
                    'W',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: Text(
                    'D',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: Text(
                    'L',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: Center(
                  child: Text(
                    'P',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final eplTeams = teams[index];
                  final String team = eplTeams['name'];
                  final games = eplTeams['all-matches']['played'].toString();
                  final lost = eplTeams['all-matches']['lost'].toString();
                  final won = eplTeams['all-matches']['won'].toString();
                  final drawn = eplTeams['all-matches']['drawn'].toString();
                  final points = eplTeams['total-points'].toString();
                  return Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 25, // Adjust the width of the container
                        height: 25, // Adjust the height of the container
                        child: Center(
                          child: Image.asset(
                            'assets/${team.toLowerCase().replaceAll(' ', '_')}.png',
                            fit: BoxFit
                                .cover, // Choose the appropriate fit option
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        team,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        child: Center(child: Text(games)),
                        width: 24,
                      ),
                      SizedBox(
                        child: Center(child: Text(won)),
                        width: 24,
                      ),
                      SizedBox(
                        child: Center(child: Text(drawn)),
                        width: 24,
                      ),
                      SizedBox(
                        child: Center(child: Text(lost)),
                        width: 24,
                      ),
                      SizedBox(
                        child: Center(child: Text(points)),
                        width: 40,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    const String apiKey = '552295a42bmsh86a7f41465d14cbp13261cjsn5a354ed50973';

    final Uri url = Uri.https('football-web-pages1.p.rapidapi.com',
        '/league-table.json', {'comp': '1'});

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
        teams = data['league-table']['teams'];
      });
      if (response.statusCode == 200) {
        // Successful response
        print(response.body);
      } else {
        // Handle other status codes
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }
}
