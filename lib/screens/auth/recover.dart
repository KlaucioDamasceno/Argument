import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverScreen extends StatefulWidget {
  @override
  RecoverScreenState createState() => RecoverScreenState();
}

class RecoverScreenState extends State<RecoverScreen> {
  final _formKey = GlobalKey<FormState>();
  UsuarioService _usuarioService;

  
  
  String _email;
  FocusNode _focusEmail;


  @override
  void initState() {
    super.initState();
    this._focusEmail = FocusNode();
  }

  @override
  void dispose() {
    this._focusEmail.dispose();
    super.dispose();
  }

  _recover() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _usuarioService.recuperarSenha(_email).then((result) {
        showInfo("Senha enviada com sucesso!");
        Navigator.of(context).pop();
      }).catchError((error) {
        print("Errooooooo!!!!!");
        showError("Erro ao fazer login");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
          ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
             children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/images/forgot.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Esqueceu sua senha?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(143, 148, 251, 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Por favor, informe o E-mail associado a sua conta que enviaremos a sua senha.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _focusEmail,
              textInputAction: TextInputAction.send,
              validator: (email) {
                if (email.isEmpty) {
                  return "Informe o email.";
                }
                return null;
              },
              onFieldSubmitted: (nome) {
                this._focusEmail.unfocus();
              },
              onSaved: (email) {
                this._email = email;
              },
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize:20, color: Colors.deepPurple),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                   ],
                  ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Text(
                    "Enviar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ), 
                  onPressed: (){
                    _recover();
                  },
                  ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
