import 'dart:async';
import 'package:argument/domain/atividade.dart';
import 'package:argument/screens/atividade/atividade.dart';
import 'package:argument/stores/atividade_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AtividadeService {

  final AtividadeStore atividadeStore;
  final Firestore _firestore;
  List<Atividade> atividades;

  AtividadeService(this.atividadeStore, this._firestore );

  Future<List<Atividade>> buscarAtividades() async{
    Atividade atividade = Atividade();
    _firestore.collection('tarefas').getDocuments().then((snapshots){
      for(var tarefa in snapshots.documents){
        atividade = Atividade.fromMap(tarefa.data, tarefa.documentID);
        atividadeStore.adicionarAtividade(atividade);
      }
    });
    return Future.value(atividadeStore.atividades);
  }
  Future<List<Atividade>> carregarAtividades() async{
    List<Atividade> atividades = List<Atividade>();
    Atividade atividade = Atividade();
    return await _firestore.collection('tarefas')
    .getDocuments()
    // ignore: missing_return
    .then((snapshot){
    for(var tarefa in snapshot.documents){
      atividades.add(Atividade.fromMap(tarefa.data, tarefa.documentID));
      atividade = Atividade.fromMap(tarefa.data, tarefa.documentID);
      atividadeStore.adicionarAtividade(atividade);
      }
    //atividadeStore.setAtividades(atividades);
    });
    // ignore: dead_code
    return atividades;
  }
  

  Future<void> salvar(Atividade atividade){
    atividadeStore.adicionarAtividade(atividade);
  }
  
  Future<void> criarDebate(Atividade atividade) async {
    await _firestore
        .collection("tarefas")
        .document()
        .setData(atividade.toMap());
    atividadeStore.adicionarAtividade(atividade);
  }


  void dispose(){
  }


}
