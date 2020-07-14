class Resposta {
  static const String TABLE_NAME = "respostas";

  final String uid;
  final String comment;
  final String idComentario;
  final String username;
  final String posicao;
  final DateTime time;

  //final String foto;

  Resposta(
      {this.uid,
      this.comment,
      this.idComentario,
      this.username,
      this.posicao,
      this.time});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'comment': comment,
      'idComentario': idComentario,
      'username': username,
      'posicao': posicao,
      //'foto': foto,
      'time': time?.millisecondsSinceEpoch,
    };
  }

  static Resposta fromMap(Map<String, dynamic> map) {
    return Resposta(
      uid: map["uid"],
      comment: map["comment"],
      idComentario: map["idComentario"],
      username: map["username"],
      posicao: map["posicao"],
      time: map["time"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["time"])
          : null,
    );

    //foto: map["foto"]);
  }

  Resposta copyWith({String uid}) {
    return Resposta(
      uid: uid,
      comment: this.comment,
      idComentario: this.idComentario,
      username: this.username,
      posicao: this.posicao,
      time: this.time,
    );
  }
}
