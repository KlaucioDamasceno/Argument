import 'package:argument/domain/atividade.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/message_utils.dart';
import 'package:argument/widgets/form/date_time_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AtividadeScreen extends StatefulWidget {
  @override
  AtividadeScreenState createState() => AtividadeScreenState();
}

class AtividadeScreenState extends State<AtividadeScreen> {
  final _formKey = GlobalKey<FormState>();
  UsuarioService _usuarioService;
  AtividadeService _atividadeService;

  String _tema;
  String _titulo;
  String _texto;
  DateTime _dataHoraInicio;
  

  FocusNode _focusTema;
  FocusNode _focusTitulo;
  FocusNode _focusTexto;
  FocusNode _focusDataHoraInicio;
  

  @override
  void initState() {
    super.initState();
    this._focusTema = FocusNode();
    this._focusTitulo = FocusNode();
    this._focusTexto = FocusNode();
    this._focusDataHoraInicio = FocusNode();
  }

  @override
  void dispose() {
    this._focusTema.dispose();
    this._focusTitulo.dispose();
    this._focusTexto.dispose();

    super.dispose();
  }

  _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Atividade _atividade = Atividade(
          tema: this._tema,
          titulo: this._titulo,
          texto: this._texto,
          dataHoraInicio: this._dataHoraInicio,
          usuario: (this._usuarioService.usuarioStore.usuario.uid).toString());
      
      this._atividadeService.criarDebate(_atividade).then((value) {
        showInfo("Debate Criado");
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);
    _atividadeService = Provider.of<AtividadeService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text("Novo Debate", style: TextStyle(fontSize: 32),),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: true,
                focusNode: this._focusTema,
                validator: (tema) {
                  if (tema.isEmpty) {
                    return "Informe o Tema";
                  }
                  return null;
                },
                onFieldSubmitted: (tema) {
                  this._focusTema.unfocus();
                  this._focusTitulo.requestFocus();
                },
                onSaved: (tema) {
                  this._tema = tema;
                },
                decoration: InputDecoration(hintText: "Tema", labelText: "Tema", icon: Icon(Icons.account_box)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _focusTexto,
                textInputAction: TextInputAction.next,
                minLines: 2,
                maxLines: 4,
                validator: (texto) {
                  if (texto.isEmpty) {
                    return "Informe o Texto Inicial";
                  }
                  return null;
                },
                onFieldSubmitted: (tema) {
                  this._focusTema.unfocus();
                  this._focusTexto.requestFocus();
                },
                onSaved: (texto) {
                  this._texto = texto;
                },
                decoration: InputDecoration(hintText: "Texto", labelText: "Texto", icon: Icon(Icons.text_fields)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _focusTitulo,
                  validator: (titulo) {
                    if (titulo.isEmpty) {
                      return "Informe o Título";
                    }
                    return null;
                  },
                  onFieldSubmitted: (tema) {
                    this._focusTitulo.unfocus();
                    this._focusDataHoraInicio.requestFocus();
                  },
                  onSaved: (titulo) {
                    this._titulo = titulo;
                  },
                  decoration: InputDecoration(hintText: "Título", labelText: "Título", icon: Icon(Icons.assignment))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DateTimeFormField(
                        inputType: Type.date,
                        format: DateFormat("dd/MM/yyyy"),
                        textInputAction: TextInputAction.next,
                        focusNode: _focusDataHoraInicio,
                        style: TextStyle(),
                        validator: (dataHoraInicio) {
                          if (dataHoraInicio == null) {
                            return "Informe a data e hora de início";
                          }
                          return null;
                        },
                        onFieldSubmitted: (tema) {
                          this._focusDataHoraInicio.unfocus();
                        },
                        onSaved: (dataHoraInicio) {
                          this._dataHoraInicio = dataHoraInicio;
                        },
                        inputDecoration: InputDecoration(hintText: "data hora de início", labelText: "data hora de início")),
                  ),
//                  Expanded(
//                    flex: 1,
//                    child: DateTimeFormField(
//                        inputType: Type.time,
//                        format: DateFormat("HH:mm"),
//                        textInputAction: TextInputAction.next,
//                        validator: (dataHoraInicio) {
//                          if (dataHoraInicio == null) {
//                            return "Informe a hora de início";
//                          }
//                          return null;
//                        },
//                        onFieldSubmitted: (nome) {
////                        this._focusDataHoraFim.requestFocus();
//                        },
//                        onSaved: (dataHoraInicio) {
////                        this._dataHoraInicio = dataHoraInicio;
//                        },
//                        inputDecoration: InputDecoration(hintText: "Hora de início", labelText: "hora de início")),
//                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 5),
              child: RaisedButton(
                child: Text("Enviar"),
                onPressed: () {
                  this._save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
