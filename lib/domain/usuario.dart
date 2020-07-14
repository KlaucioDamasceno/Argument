class Usuario {
  static const String TABLE_NAME = "usuario";
  final String uid;
  final String nome;
  final String email;
  final String senha;
  final bool admin;
  final String foto;

  Usuario(
      {this.uid,
      this.nome,
      this.email,
      this.senha,
      this.admin = true,
      this.foto});

  Map<String, Object> toJson() {
    return {
      "uid": this.uid,
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha,
      "admin": this.admin,
      "foto": this.foto
    };
  }

  static fromJson(Map<String, Object> json) {
    return Usuario(
        uid: json["uid"],
        nome: json["nome"],
        email: json["email"],
        admin: json["admin"] ?? false,
        foto: json["foto"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
      'senha': senha,
      'admin': admin,
      'foto': foto
    };
  }

  Usuario copyWith(
      {String uid, String nome, String email, bool admin, String foto}) {
    return Usuario(
        uid: uid ?? this.uid,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        admin: admin != null ? admin : this.admin,
        foto: foto ?? this.foto);
  }
}
