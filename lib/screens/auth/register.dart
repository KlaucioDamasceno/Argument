import 'dart:io';
import 'package:argument/animation/FadeAnimation.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  final picker = ImagePicker();

  String _imagePath = "";

  UsuarioService _usuarioService;

  bool _showPassword = false;

  String _nome;
  String _email;
  String _senha;

  FocusNode _focusNome;
  FocusNode _focusEmail;
  FocusNode _focusSenha;

  @override
  void initState() {
    super.initState();
    this._focusNome = FocusNode();
    this._focusEmail = FocusNode();
    this._focusSenha = FocusNode();
  }

  @override
  void dispose() {
    this._focusNome.dispose();
    this._focusEmail.dispose();
    this._focusSenha.dispose();

    super.dispose();
  }

  _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _usuarioService
          .criarUsuario(_nome, _email, _senha, File(_imagePath))
          .catchError((error) {
        showError(error.message);
      });
    }
  }

  _selecionarFoto() {
    _scafoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 100,
        child: Column(
          children: [
            Container(
              height: 1,
              width: double.maxFinite,
              color: Colors.grey,
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                final croppedFile = await ImageCropper.cropImage(
                    sourcePath: pickedFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    androidUiSettings: AndroidUiSettings(
                        toolbarTitle: 'Redimensionar',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    iosUiSettings: IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    ));
                setState(() {
                  _imagePath = croppedFile.path;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.blueAccent),
                    Text("Câmera")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.maxFinite,
              color: Colors.grey,
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                final croppedFile = await ImageCropper.cropImage(
                    sourcePath: pickedFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    androidUiSettings: AndroidUiSettings(
                        toolbarTitle: 'Redimensionar',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    iosUiSettings: IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    ));
                setState(() {
                  _imagePath = croppedFile.path;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    Icon(Icons.insert_drive_file, color: Colors.orangeAccent),
                    Text("Galeria")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Cadastrar-se"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 100),
            Center(
              child: InkWell(
                onTap: () {
                  _selecionarFoto();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: _imagePath.isEmpty
                      ? Icon(Icons.camera_alt)
                      : Image.file(
                          File(_imagePath),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                focusNode: this._focusNome,
                                validator: (nome) {
                                  if (nome.isEmpty) {
                                    return "Informe o nome.";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (nome) {
                                  this._focusNome.unfocus();
                                  this._focusEmail.requestFocus();
                                },
                                onSaved: (nome) {
                                  this._nome = nome;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Nome",
                                    icon: Icon(Icons.face,
                                        color: Colors.grey[400]),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _focusEmail,
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                validator: (email) {
                                  if (email.isEmpty) {
                                    return "Informe o email.";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (nome) {
                                  this._focusEmail.unfocus();
                                  this._focusSenha.requestFocus();
                                },
                                onSaved: (email) {
                                  this._email = email;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    icon: Icon(Icons.email,
                                        color: Colors.grey[400]),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.send,
                                focusNode: _focusSenha,
                                autofocus: true,
                                validator: (senha) {
                                  if (senha.isEmpty) {
                                    return "Informe a senha.";
                                  }
                                  if (senha.length < 6) {
                                    return "A senha deve conter mais de 6 caracteres.";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (nome) {
                                  this._focusSenha.unfocus();
                                  _register();
                                },
                                onSaved: (senha) {
                                  this._senha = senha;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Senha",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.grey[400],
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  suffixIcon: IconButton(
                                      icon: Icon(_showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      color: Colors.grey[400],
                                      onPressed: () {
                                        setState(() {
                                          this._showPassword = !_showPassword;
                                        });
                                      }),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: SizedBox.expand(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Enviar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _register();
                            },
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
