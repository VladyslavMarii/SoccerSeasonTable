import 'package:flutter/material.dart';

///[HomeInfoContent] class that shows home info
///(matches played, wins, loses, drawn, goals for/against)
///for specific club
class HomeInfoContent extends StatefulWidget {
  ///[someTeam] current team for showing all info
  final Map<String, dynamic> someTeam;

  const HomeInfoContent({Key? key, required this.someTeam}) : super(key: key);

  @override
  _HomeInfoContentState createState() => _HomeInfoContentState();
}

class _HomeInfoContentState extends State<HomeInfoContent> {
  ///[_someTeam] making it easier to call current team
  late Map<String, dynamic> _someTeam;

  ///[initState] initializing of _someTeam
  @override
  void initState() {
    super.initState();
    _someTeam = widget.someTeam;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        top: 15.0,
        right: 25.0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Matches played',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['played']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wins',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['won']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Draws',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['drawn']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Losses',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['lost']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Goals For',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['for']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Goals Against',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_someTeam['home-matches']['against']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
