

import 'package:cloud_firestore/cloud_firestore.dart';

class Atividade {

  final String id;
  final String tema;
  final String titulo;
  final String texto;
  final DateTime dataHoraInicio;
  //final String foto;
  final String usuario;

  Atividade({this.id, this.tema, this.titulo, this.texto, this.dataHoraInicio, this.usuario});



  Map<String, Object> toJson() {
    return {"id": this.id, "tema": this.tema, "titulo": this.titulo,"dataHoraInicio": this.dataHoraInicio, "usuario": this.usuario};
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['tema'] = tema;
    map['titulo'] = titulo;
    map['texto'] =  texto;
    map['dataHoraInicio'] = dataHoraInicio?.millisecondsSinceEpoch;
    map['usuario'] =  usuario;

    return map;
  }
  static Atividade fromMap(Map<String, dynamic> map, String id) {
    return Atividade(
        id: id,
        tema: map["tema"],
        titulo: map["titulo"],
        dataHoraInicio: map["dataHoraInicio"] != null ? DateTime.fromMillisecondsSinceEpoch(map["dataHoraInicio"]) : null,
        usuario: map["usuario"]);
  }


  static fromJson(Map<String, Object> json) {
    return Atividade(id: json["reference"], tema: json["tema"], titulo: json["titulo"],  dataHoraInicio: json["dataHoraInicio"] != null ? DateTime.fromMillisecondsSinceEpoch(json["dataHoraInicio"]) : null);
  }
}
