class Comentario {
  static const String TABLE_NAME = "comentarios";

  final String uid;
  final String comment;
  final String debate;
  final String username;

  //final String foto;

  Comentario({this.uid, this.comment, this.debate, this.username});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'comment': comment,
      'debate': debate,
      'username': username,
      //'foto': foto,
    };
  }

  static Comentario fromMap(Map<String, dynamic> map) {
    return Comentario(
      uid: map["uid"],
      comment: map["comment"],
      debate: map["debate"],
      username: map["username"],
    );

    //foto: map["foto"]);
  }

  Comentario copyWith({String uid}) {
    return Comentario(
      uid: uid,
      comment: this.comment,
      debate: this.debate,
      username: this.username,
    );
  }
}
