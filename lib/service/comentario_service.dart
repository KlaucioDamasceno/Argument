import 'dart:async';
import 'package:argument/domain/comentario.dart';
import 'package:argument/stores/comentario_store.dart';
import 'package:argument/stores/hud_store.dart';
import 'package:argument/stores/usuario_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComentarioService {
  final ComentarioStore comentarioStore;
  final Firestore _firestore;
  final HudStore _hudStore;
  final UsuarioStore _usuarioStore;
  StreamSubscription _comentarioStream;

  ComentarioService(this.comentarioStore, this._firestore, this._hudStore,
      this._usuarioStore) {
    this._comentarioStream = comentariosStream().listen((comentarios) {
      comentarioStore.setComentarios(comentarios);
    });
  }

  Future<List<Comentario>> carregarComentarios(String pdebate) async {
//    return dbHelper.getDatabase().then((db) {
//      return db.query(Atividade.TABLE_NAME)
//          .then((atividadesMap) => atividadesMap.map((map) => Atividade.fromMap(map)).toList())
//          .then((atividades) {
//            atividadeStore.setAtividades(atividades);
//            return atividades;
//      });
//    });

    return _firestore
        .collection('comentarios')
        .where("debate", isEqualTo: pdebate)
        .getDocuments()
        .then((qsnp) => qsnp.documents
            .map((document) => Comentario.fromMap(document.data))
            .toList());
  }

  Stream<List<Comentario>> comentariosStream() {
    return _firestore.collection('comentarios').snapshots().map((qsnp) => qsnp
        .documents
        .map((document) => Comentario.fromMap(document.data))
        .toList());
  }

  Future<Comentario> salvar(Comentario comentario) async {
//    final Database db = await dbHelper.getDatabase();

//    int idAtividade = await db.insert(
//      Atividade.TABLE_NAME,
//      atividade.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.replace,
//    );
    
    DocumentReference comentarioRef =
        _firestore.collection('comentarios').document();
    Comentario novoComentario =
        comentario.copyWith(uid: comentarioRef.documentID);
    comentarioStore.adicionarComentario(novoComentario);

    return comentarioRef
        .setData(novoComentario.toMap())
        .then((_) => novoComentario);
  }

  void dispose() {
    this._comentarioStream.cancel();
  }
}
