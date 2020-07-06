import 'package:argument/components/body_details.dart';
import 'package:argument/domain/atividade.dart';
import 'package:argument/utils/constants.dart';
import 'package:flutter/material.dart';

class DebateDetails extends StatefulWidget {
  final Atividade atividade;
  const DebateDetails({
    Key key,
    this.atividade,
  }) : super(key: key);

  @override
  _DebateDetailsState createState() => _DebateDetailsState();
}

class _DebateDetailsState extends State<DebateDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: BodyDetails(atividade: widget.atividade),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          padding: EdgeInsets.only(left: kDefaultPadding),
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          }),
      centerTitle: true,
      title: Text(
        "Voltar".toUpperCase(),
      ),
    );
  }
}
