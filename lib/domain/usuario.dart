class Usuario {
  static const String TABLE_NAME = "usuario";
  final String uid;
  final String nome;
  final String email;
  final String senha;
  final bool admin;

  Usuario({this.uid, this.nome, this.email,this.senha, this.admin = true});

  Map<String, Object> toJson() {
    return {"uid": this.uid, "nome": this.nome, "email": this.email,"senha": this.senha, "admin": this.admin};
  }

  static fromJson(Map<String, Object> json) {
    return Usuario(uid: json["uid"], nome: json["nome"], email: json["email"], admin: json["admin"] ?? false);
  }
  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'nome' : nome,
      'email' : email,
      'senha' : senha,
      'admin' : admin,
    };
  } 
}
