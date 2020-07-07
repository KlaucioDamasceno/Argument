class Comentario {
  static const String TABLE_NAME = "comentarios";

  final String uid;
  final String comment;
  final String debate;
  final String username;
  final String posicao;
  final DateTime time;

  //final String foto;

  Comentario(
      {this.uid,
      this.comment,
      this.debate,
      this.username,
      this.posicao,
      this.time});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'comment': comment,
      'debate': debate,
      'username': username,
      'posicao': posicao,
      //'foto': foto,
      'time': time?.millisecondsSinceEpoch,
    };
  }

  static Comentario fromMap(Map<String, dynamic> map) {
    return Comentario(
      uid: map["uid"],
      comment: map["comment"],
      debate: map["debate"],
      username: map["username"],
      posicao: map["posicao"],
      time: map["time"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["time"])
          : null,
    );

    //foto: map["foto"]);
  }

  Comentario copyWith({String uid}) {
    return Comentario(
      uid: uid,
      comment: this.comment,
      debate: this.debate,
      username: this.username,
      posicao: this.posicao,
      time: this.time,
    );
  }
}
