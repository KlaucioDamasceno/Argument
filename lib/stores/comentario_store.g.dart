// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comentario_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ComentarioStore on _ComentarioStore, Store {
  Computed<int> _$quantidadeComentariosComputed;

  @override
  int get quantidadeComentarios => (_$quantidadeComentariosComputed ??=
          Computed<int>(() => super.quantidadeComentarios))
      .value;

  final _$comentariosAtom = Atom(name: '_ComentarioStore.comentarios');

  @override
  ObservableList<Comentario> get comentarios {
    _$comentariosAtom.context.enforceReadPolicy(_$comentariosAtom);
    _$comentariosAtom.reportObserved();
    return super.comentarios;
  }

  @override
  set comentarios(ObservableList<Comentario> value) {
    _$comentariosAtom.context.conditionallyRunInAction(() {
      super.comentarios = value;
      _$comentariosAtom.reportChanged();
    }, _$comentariosAtom, name: '${_$comentariosAtom.name}_set');
  }

  final _$_ComentarioStoreActionController =
      ActionController(name: '_ComentarioStore');

  @override
  dynamic adicionarComentario(Comentario comentario) {
    final _$actionInfo = _$_ComentarioStoreActionController.startAction();
    try {
      return super.adicionarComentario(comentario);
    } finally {
      _$_ComentarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setComentarios(List<Comentario> comentarios) {
    final _$actionInfo = _$_ComentarioStoreActionController.startAction();
    try {
      return super.setComentarios(comentarios);
    } finally {
      _$_ComentarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'comentarios: ${comentarios.toString()},quantidadeComentarios: ${quantidadeComentarios.toString()}';
    return '{$string}';
  }
}
