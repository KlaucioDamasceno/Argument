import 'package:argument/domain/comentario.dart';
import 'package:mobx/mobx.dart';

part 'comentario_store.g.dart';

class ComentarioStore = _ComentarioStore with _$ComentarioStore;

abstract class _ComentarioStore with Store {
  @observable
  ObservableList<Comentario> comentarios = List<Comentario>().asObservable();

  @action
  adicionarComentario(Comentario comentario) {
    comentarios.add(comentario);
  }

  @action
  setComentarios(List<Comentario> comentarios) {
    this.comentarios.clear();
    this.comentarios.addAll(comentarios);
  }

  @computed
  int get quantidadeComentarios {
    return comentarios.length;
  }
}
