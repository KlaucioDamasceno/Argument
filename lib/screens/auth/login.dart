import 'package:argument/animation/FadeAnimation.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UsuarioService _usuarioService;

  bool _showPassword = false;

  String _email;
  String _senha;

  @override
  initState() {
    super.initState();
  }

  _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        _usuarioService.entrarComEmailSenha(_email, _senha).then((usuario) {
          if (usuario == null) {
            showError("Usuário não cadastrado");
          }
        }).catchError((error) {
          print("Errooooooo!!!!!");
          showError("Erro ao fazer login");
        });
      } catch (e) {
        showError("Erro ao fazer login");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(this.context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png')
                            )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png')
                            )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png')
                            )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                            )
                          ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                autofocus: true,
                                validator: (email){
                                  if(email.isEmpty){
                                    return "Informe o email.";
                                  }
                                  return null;
                                },
                                onSaved: (email){
                                  this._email = email;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  icon: Icon(Icons.email, color: Colors.grey[400]),
                                  hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: true,
                                validator: (senha){
                                  if(senha.isEmpty){
                                    return "Informe a senha.";
                                  }
                                  if(senha.length < 6){
                                    return "A senha deve conter mais de 6 caracteres.";
                                  }
                                  return null;
                                },
                                onSaved: (senha){
                                  this._senha = senha;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Senha",
                                  icon: Icon(Icons.lock, color: Colors.grey[400],),
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                                    color: Colors.grey[400], 
                                    onPressed: (){
                                      setState(() {
                                        this._showPassword = !_showPassword;
                                      });
                                    }
                                  ),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ),
                          ],
                        ),
                      )),
                      Container(
                              height: 40,
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                child: Text(
                                  "Recuperar Senha",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.of(context).pushNamed("recover");
                                },
                              ),
                      ),
                      SizedBox(height: 30,),
                      FadeAnimation(2, Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ]
                          )
                        ),
                        child: SizedBox.expand(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            onPressed: (){
                              _login();
                            },
                          ),
                        ),
                      )),
                      SizedBox(height: 50,),
                      Container(
                        height: 40,
                        child: FlatButton(
                          child: Text(
                            "Cadastrar-se", 
                            style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ),
                          ),
                        onPressed: (){
                          Navigator.of(context).pushNamed("register");
                        },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
