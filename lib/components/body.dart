import 'package:argument/components/category_list.dart';
import 'package:argument/components/debate_card.dart';
import 'package:argument/components/search_box.dart';
import 'package:argument/domain/atividade.dart';
import 'package:argument/screens/debate/debatedetails.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final String tema;
  const Body({
    Key key,
    this.tema,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AtividadeService _atividadeService;
    Atividade _atividade;

    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('tarefas')
                      .where("tema", isEqualTo: tema)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("Carregando..."),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Erro ao carregar debates..."),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => DebateCard(
                          itemIndex: index,
                          atividade: atividade(
                              _atividade, snapshot.data.documents, index),
                          tema: this.tema,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DebateDetails(
                                          atividade: atividade(_atividade,
                                              snapshot.data.documents, index),
                                        )));
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Atividade atividade(
      Atividade _atividade, List<DocumentSnapshot> documents, int index) {
    return _atividade = Atividade(
      uid: documents[index].documentID,
      tema: documents[index].data['tema'],
      titulo: documents[index].data['titulo'],
      texto: documents[index].data['texto'],
      dataHoraInicio: documents[index].data['dataHoraInicio'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              documents[index].data['dataHoraInicio'])
          : null,
    );
  }
}
