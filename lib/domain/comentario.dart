class Comentario {
  static const String TABLE_NAME = "comentarios";

  final String id;
  final String comment;
  final String debate;
  final String username;

  //final String foto;

  Comentario({this.id, this.comment, this.debate, this.username});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comment': comment,
      'debate': debate,
      'username': username,
      //'foto': foto,
    };
  }

  static Comentario fromMap(Map<String, dynamic> map) {
    return Comentario(
      id: map["id"],
      comment: map["comment"],
      debate: map["debate"],
      username: map["username"],
    );

    //foto: map["foto"]);
  }

  Comentario copyWith({String id}) {
    return Comentario(
      id: id,
      comment: this.comment,
      debate: this.debate,
      username: this.username,
    );
  }
}
