import 'package:flutter/material.dart';

class AwayInfoContent extends StatefulWidget {
  final Map<String, dynamic> eplTeam;

  const AwayInfoContent({Key? key, required this.eplTeam}) : super(key: key);

  @override
  _AwayInfoContentState createState() => _AwayInfoContentState();
}

class _AwayInfoContentState extends State<AwayInfoContent> {
  late Map<String, dynamic> _eplTeam;

  @override
  void initState() {
    super.initState();
    _eplTeam = widget.eplTeam;
    // Add your initialization code here if needed
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
                  '${_eplTeam['away-matches']['played']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wins',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_eplTeam['away-matches']['won']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Draws',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_eplTeam['away-matches']['drawn']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Losses',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_eplTeam['away-matches']['lost']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Goals For',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_eplTeam['away-matches']['for']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Goals Against',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${_eplTeam['away-matches']['against']}',
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
