import 'package:argument/domain/reposta.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsListKeyPrefix {
  static final String singleComment = "Comment";
  static final String commentUser = "Comment User";
  static final String commentText = "Comment Text";
  static final String commentDivider = "Comment Divider";
}

class RespostaList extends StatelessWidget {
  final List<Resposta> respostas;

  const RespostaList({Key key, this.respostas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Comparator<Resposta> priceComparator = (a, b) => a.time.compareTo(b.time);
    this.respostas.sort(priceComparator);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.comment),
        title: Text("Respostas  ${respostas.length}"),
        children: List<Widget>.generate(
          respostas.length,
          (int index) => _SingleComment(
              key: ValueKey("${CommentsListKeyPrefix.singleComment} $index"),
              index: index,
              respostas: respostas),
        ),
      ),
    );
  }
}

class _SingleComment extends StatelessWidget {
  final int index;
  final List<Resposta> respostas;
  const _SingleComment({Key key, @required this.index, this.respostas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resposta resposta = respostas[index];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              child: Image.asset("assets/images/avatar.png"),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  resposta.username.toUpperCase() +
                      " às ${DateFormat("dd/MM/yyyy HH:mm").format(resposta.time)}",
                  key: ValueKey("${CommentsListKeyPrefix.commentUser} $index"),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                resposta.posicao == 'Concordo'
                    ? Text(
                        resposta.comment,
                        key: ValueKey(
                            "${CommentsListKeyPrefix.commentText} $index"),
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                        textAlign: TextAlign.left,
                      )
                    : Container(),
                resposta.posicao == 'Discordo'
                    ? Text(
                        resposta.comment,
                        key: ValueKey(
                            "${CommentsListKeyPrefix.commentText} $index"),
                        style: TextStyle(fontSize: 13, color: Colors.red),
                        textAlign: TextAlign.left,
                      )
                    : Container(),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
