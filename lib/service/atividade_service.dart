import 'package:argument/domain/atividade.dart';
import 'package:argument/stores/atividade_store.dart';

class AtividadeService {

  final AtividadeStore atividadeStore;

  AtividadeService(this.atividadeStore);

  Future<List<Atividade>> buscarAtividades() {
    return Future.value(atividadeStore.atividades);
  }

  Future<Atividade> salvar(Atividade atividade){
    atividadeStore.adicionarAtividade(atividade);
    return Future.value(atividade);
  }
  
  void dispose(){

  }
}
