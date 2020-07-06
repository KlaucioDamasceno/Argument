class Atividade {
  static const String TABLE_NAME = "tarefas";
  final String uid;
  final String tema;
  final String titulo;
  final String texto;
  final DateTime dataHoraInicio;
  //final String foto;
  final String usuario;

  Atividade({
    this.uid,
    this.tema,
    this.titulo,
    this.texto,
    this.dataHoraInicio,
    this.usuario,
  });

  Map<String, Object> toJson() {
    return {
      "uid": this.uid,
      "tema": this.tema,
      "texto": this.texto,
      "titulo": this.titulo,
      "dataHoraInicio": this.dataHoraInicio,
      "usuario": this.usuario
    };
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['uid'] = uid;
    map['tema'] = tema;
    map['titulo'] = titulo;
    map['texto'] = texto;
    map['dataHoraInicio'] = dataHoraInicio?.millisecondsSinceEpoch;
    map['usuario'] = usuario;

    return map;
  }

  static Atividade fromMap(Map<String, dynamic> map) {
    return Atividade(
        uid: map["uid"],
        tema: map["tema"],
        texto: map["texto"],
        titulo: map["titulo"],
        dataHoraInicio: map["dataHoraInicio"] != null
            ? DateTime.fromMillisecondsSinceEpoch(map["dataHoraInicio"])
            : null,
        usuario: map["usuario"]);
  }

  static fromJson(Map<String, Object> json) {
    return Atividade(
        uid: json["uid"],
        tema: json["tema"],
        titulo: json["titulo"],
        texto: json["texto"],
        dataHoraInicio: json["dataHoraInicio"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["dataHoraInicio"])
            : null);
  }

  Atividade copyWith({String id}) {
    return Atividade(
        uid: uid,
        tema: this.tema,
        titulo: this.titulo,
        texto: this.texto,
        dataHoraInicio: this.dataHoraInicio,
        usuario: this.usuario);
  }
}
