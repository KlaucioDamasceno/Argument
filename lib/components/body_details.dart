import 'package:argument/components/debatepost.dart';
import 'package:argument/components/textcomposer.dart';
import 'package:argument/domain/atividade.dart';
import 'package:argument/domain/comentario.dart';
import 'package:argument/service/comentario_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/stores/hud_store.dart';
import 'package:argument/utils/constants.dart';
import 'package:argument/widgets/comments_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BodyDetails extends StatefulWidget {
  final Atividade atividade;
  const BodyDetails({
    Key key,
    this.atividade,
  }) : super(key: key);

  @override
  _BodyDetailsState createState() => _BodyDetailsState();
}

class _BodyDetailsState extends State<BodyDetails> {
  ComentarioService _comentarioService;
  UsuarioService _usuarioService;
  Comentario _comentario;
  HudStore _hudStore;
  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);
    String tema = widget.atividade.tema;

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: DebatePost(
                    size: size,
                    tema: tema,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Text(
                    "${widget.atividade.titulo}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text(
                  'Data de Início - ${DateFormat("dd/MM/yyyy").format(widget.atividade.dataHoraInicio)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: SelectableText.rich(
                    TextSpan(
                      text: "${widget.atividade.texto}",
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextComposer(sendComment: _sendComment),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: _listarAtividadesStream(),
          ),
        ],
      ),
    );
  }

  void _sendComment(String text) {
    Comentario comentario = Comentario(
      comment: text,
      username: this._usuarioService.usuarioStore.usuario.nome,
      debate: widget.atividade.uid,
      //time: DateTime.now()
    );
    DocumentReference comentarioRef =
        Firestore.instance.collection('comentarios').document();
    Comentario novoComentario =
        comentario.copyWith(uid: comentarioRef.documentID);
    comentarioRef.setData(novoComentario.toMap()).then((_) => novoComentario);
  }

  Comentario comentario(
      Comentario _comentario, List<DocumentSnapshot> documents, int index) {
    return _comentario = Comentario(
      uid: documents[index].data['uid'],
      comment: documents[index].data['comment'],
      debate: documents[index].data['debate'],
      username: documents[index].data['username'],
    );
  }

  _listarAtividadesStream() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('comentarios')
          .where('debate', isEqualTo: widget.atividade.uid)
          .snapshots()
          .map((qsnp) => qsnp.documents.reversed
              .map((document) => Comentario.fromMap(document.data))
              .toList()),
      builder: (context, AsyncSnapshot<List<Comentario>> snp) {
        if (!snp.hasData) {
          return Center(
            child: Text("Carregando..."),
          );
        }

        if (snp.hasError) {
          return Center(
            child: Text("Erro ao carregar atividades..."),
          );
        }

        return CommentsList(comentarios: snp.data);
      },
    );
  }
}
