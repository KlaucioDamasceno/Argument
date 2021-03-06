import 'package:argument/domain/atividade.dart';
//import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'atividade_store.g.dart';

class AtividadeStore = _AtividadeStore with _$AtividadeStore;


abstract class _AtividadeStore with Store {

  @observable
  ObservableList<Atividade> atividades = List<Atividade>().asObservable();
  
  @action
  setAtividades(List<Atividade> atividades){
    for(Atividade atividade in atividades){
      atividades.add(atividade);
    }
  }

  @action
  adicionarAtividade(Atividade atividade) {
    atividades.add(atividade);
  }
  @computed
  int get quantidadeAtividades {
    return atividades.length;
  }
}
