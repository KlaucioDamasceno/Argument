import 'package:argument/utils/constants.dart';
import 'package:flutter/material.dart';

class DebatePost extends StatefulWidget {
  final Size size;
  final String tema;
  const DebatePost({Key key, this.size, this.tema}) : super(key: key);

  @override
  _DebatePostState createState() => _DebatePostState();
}

class _DebatePostState extends State<DebatePost> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: size.width * 0.8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
            height: size.width * 0.8,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: size.width * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Image.asset(
                  "assets/images/${widget.tema}.jpg",
                  height: size.width * 0.75,
                  width: size.width * 0.75,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
