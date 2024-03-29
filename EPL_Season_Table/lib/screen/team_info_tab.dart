import 'package:flutter/material.dart';

import 'info/all_info_tab.dart';
import 'info/away_info_tab.dart';
import 'info/home_info.dart';

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

  @override
  void initState() {
    super.initState();
    _eplTeam = widget.eplTeam;
    _tabController = TabController(length: 3, vsync: this);
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
              const Text(
                ' Home Info',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
      body: Column(
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
                    'assets/england_flag.png',
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
                    'assets/${_eplTeam['name'].toLowerCase().replaceAll(' ', '_')}.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                _eplTeam["name"],
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
                HomeInfoContent(eplTeam: _eplTeam),
                AwayInfoContent(eplTeam: _eplTeam),
                AllInfoContent(eplTeam: _eplTeam),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
