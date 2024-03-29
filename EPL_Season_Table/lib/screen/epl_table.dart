import 'dart:convert';

import 'package:epl_season_table/screen/team_info_tab.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeEplTableScreen extends StatefulWidget {
  const HomeEplTableScreen({super.key});

  @override
  State<HomeEplTableScreen> createState() => _HomeEplTableScreenState();
}

class _HomeEplTableScreenState extends State<HomeEplTableScreen> {
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
        leading: Image.asset('assets/epl.png'),
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
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: teams.length + 1,
                itemBuilder: (context, index) {
                  if (index == teams.length) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 22,
                              height: 32,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                                "Вихід - Ліга чемпіонів (Груповий етап: )")
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 22,
                              height: 32,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(217, 130, 5, 5),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text("Вихід - Ліга Європи (Груповий етап: )")
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 22,
                              height: 32,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 254, 17, 0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text("Пониження - Чемпіоншип")
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 32,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Text(
                                  'Якщо команди завершують сезон із однаковою кількістю очок, перевагу отримує команда із кращою різницею голів.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 86, 86, 86)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        )
                      ],
                    );
                  }
                  final eplTeams = teams[index];
                  final String team = eplTeams['name'];
                  final games = eplTeams['all-matches']['played'].toString();
                  final lost = eplTeams['all-matches']['lost'].toString();
                  final won = eplTeams['all-matches']['won'].toString();
                  final drawn = eplTeams['all-matches']['drawn'].toString();
                  final points = eplTeams['total-points'].toString();
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TeamInfoScreen(eplTeam: eplTeams)),
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        CircleAvatar(
                          backgroundColor: (index + 1) < 5
                              ? Colors.blue
                              : (index + 1) == 5
                                  ? const Color.fromARGB(217, 130, 5, 5)
                                  : (index + 1 > 17)
                                      ? const Color.fromARGB(255, 254, 17, 0)
                                      : const Color.fromARGB(
                                          255, 244, 210, 251),
                          child: Text(
                            '${index + 1}.',
                            style: TextStyle(
                              color: (index) < 5 || (index) > 16
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Center(
                            child: Image.asset(
                              'assets/${team.toLowerCase().replaceAll(' ', '_')}.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
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
                    ),
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
