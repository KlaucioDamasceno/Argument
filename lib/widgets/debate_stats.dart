import 'package:argument/domain/comentario.dart';
import 'package:argument/screens/debate/resposta.dart';
import 'package:flutter/material.dart';

class DebateStats extends StatefulWidget {
  final Comentario comentario;

  const DebateStats({Key key, this.comentario}) : super(key: key);
  @override
  _DebateStatsState createState() => _DebateStatsState();
}

class _DebateStatsState extends State<DebateStats> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RespostaScreen(
                    comentario: widget.comentario,
                  ),
                ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _ShowStat(
              icon: Icons.insert_comment,
              color: Colors.grey,
              number: 5,
            ),
          ),
        ),
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
        //Text(number.toString()),
      ],
    );
  }
}
