import 'package:flutter/material.dart';

class DebateStats extends StatefulWidget {
  @override
  _DebateStatsState createState() => _DebateStatsState();
}

class _DebateStatsState extends State<DebateStats> {
  @override
  @override
  Widget build(BuildContext context) {
    //final PostModel postData = InheritedPostModel.of(context).postData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // _ShowStat(
        //   icon: Icons.,
        //   number: 10,
        //   color: Colors.red,
        //),

        _ShowStat(icon: Icons.insert_comment, number: 5, color: Colors.grey),
      ],
    );
  }
}

class _ShowStat extends StatelessWidget {
  final IconData icon;
  final int number;
  final Color color;

  const _ShowStat({
    Key key,
    @required this.icon,
    @required this.number,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: Icon(icon, color: color),
        ),
        Text(number.toString()),
      ],
    );
  }
}
