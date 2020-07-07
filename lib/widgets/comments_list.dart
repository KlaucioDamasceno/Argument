import 'package:argument/domain/comentario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsListKeyPrefix {
  static final String singleComment = "Comment";
  static final String commentUser = "Comment User";
  static final String commentText = "Comment Text";
  static final String commentDivider = "Comment Divider";
}

class CommentsList extends StatelessWidget {
  final List<Comentario> comentarios;

  const CommentsList({Key key, this.comentarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Comparator<Comentario> priceComparator = (a, b) => a.time.compareTo(b.time);
    comentarios.sort(priceComparator);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.comment),
        title: Text("Comentários  ${comentarios.length}"),
        children: List<Widget>.generate(
          comentarios.length,
          (int index) => _SingleComment(
              key: ValueKey("${CommentsListKeyPrefix.singleComment} $index"),
              index: index,
              comentarios: comentarios),
        ),
      ),
    );
  }
}

class _SingleComment extends StatelessWidget {
  final int index;
  final List<Comentario> comentarios;

  const _SingleComment({Key key, @required this.index, this.comentarios})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Comentario comentario = comentarios[index];
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
                  comentario.username.toUpperCase() +
                      " às ${DateFormat("dd/MM/yyyy HH:mm").format(comentario.time)}",
                  key: ValueKey("${CommentsListKeyPrefix.commentUser} $index"),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                comentario.posicao == 'Concordo'
                    ? Text(
                        comentario.comment,
                        key: ValueKey(
                            "${CommentsListKeyPrefix.commentText} $index"),
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                        textAlign: TextAlign.left,
                      )
                    : Container(),
                comentario.posicao == 'Discordo'
                    ? Text(
                        comentario.comment,
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
