import 'package:argument/components/respostacomposer.dart';
import 'package:argument/components/textcomposer.dart';
import 'package:argument/domain/comentario.dart';
import 'package:argument/domain/reposta.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/constants.dart';
import 'package:argument/widgets/resposta_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RespostaScreen extends StatefulWidget {
  final Comentario comentario;

  const RespostaScreen({Key key, this.comentario}) : super(key: key);

  @override
  _RespostaScreenState createState() => _RespostaScreenState();
}

class _RespostaScreenState extends State<RespostaScreen> {
  UsuarioService _usuarioService;
  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        bottom: false,
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
                          widget.comentario.username.toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.comentario.comment,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                        Divider(),
                      ],
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
              child: RespostaComposer(sendRespost: _sendRespost),
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
              child: _listarRespostaStream(),
            ),
          ],
        ),
      ),
    );
  }

  void _sendRespost(String text, String posicao) {
    Resposta resposta = Resposta(
      comment: text,
      username: this._usuarioService.usuarioStore.usuario.nome,
      idComentario: widget.comentario.uid,
      posicao: posicao,
      time: DateTime.now(),
    );
    DocumentReference respostaRef =
        Firestore.instance.collection('respostas').document();
    Resposta novaResposta = resposta.copyWith(uid: respostaRef.documentID);
    respostaRef.setData(novaResposta.toMap()).then((_) => novaResposta);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
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

  Resposta resposta(
      Resposta _resposta, List<DocumentSnapshot> documents, int index) {
    return _resposta = Resposta.fromMap(documents[index].data);
  }

  _listarRespostaStream() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('respostas')
          .where('idComentario', isEqualTo: widget.comentario.uid)
          .snapshots()
          .map((qsnp) => qsnp.documents
              .map((document) => Resposta.fromMap(document.data))
              .toList()),
      builder: (context, AsyncSnapshot<List<Resposta>> snp) {
        if (!snp.hasData) {
          return Center(
            child: Text("Carregando..."),
          );
        }

        if (snp.hasError) {
          return Center(
            child: Text("Erro ao carregar respostas..."),
          );
        }

        return RespostaList(respostas: snp.data);
      },
    );
  }
}
