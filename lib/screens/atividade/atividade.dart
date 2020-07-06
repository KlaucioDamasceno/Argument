import 'package:argument/domain/atividade.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/constants.dart';
import 'package:argument/utils/message_utils.dart';
import 'package:argument/widgets/form/date_time_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AtividadeScreen extends StatefulWidget {
  final String ptema;

  const AtividadeScreen({Key key, this.ptema}) : super(key: key);

  @override
  AtividadeScreenState createState() => AtividadeScreenState();
}

class AtividadeScreenState extends State<AtividadeScreen> {
  final _formKey = GlobalKey<FormState>();
  UsuarioService _usuarioService;
  AtividadeService _atividadeService;

  List<String> titulos;

  var _selectedLocation = 'Selecione Título';

  String tema;
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
          tema: widget.ptema,
          titulo: this._titulo,
          texto: this._texto,
          dataHoraInicio: this._dataHoraInicio,
          usuario: (this._usuarioService.usuarioStore.usuario.uid).toString());

      this._atividadeService.salvar(_atividade).then((value) {
        showInfo("Debate Criado");
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);
    _atividadeService = Provider.of<AtividadeService>(context);
    var _titulosTema = [];
    _titulosTema = _escolhaTema();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Novo Debate".toUpperCase(),
        ),
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
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 5),
              child: DropdownButtonFormField(
                icon: Icon(Icons.arrow_drop_down),
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                onSaved: (titulo) {
                  this._titulo = _selectedLocation;
                },
                items: _titulosTema.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
                decoration: InputDecoration(
                  hintText: _titulo,
                  labelText: "Título",
                  icon: Icon(Icons.title),
                ),
              ),
              //mudar aqui
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
                decoration: InputDecoration(
                    hintText: "Texto",
                    labelText: "Texto",
                    icon: Icon(Icons.text_fields)),
              ),
            ),
            //
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
                            return "Informe a data início";
                          }
                          return null;
                        },
                        onFieldSubmitted: (tema) {
                          this._focusDataHoraInicio.unfocus();
                        },
                        onSaved: (dataHoraInicio) {
                          this._dataHoraInicio = dataHoraInicio;
                        },
                        inputDecoration: InputDecoration(
                            hintText: "Início", labelText: "Início")),
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
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 5),
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

  _escolhaTema() {
    switch (widget.ptema) {
      case "Economia":
        var _titulosEconomia = [
          "Selecione Título",
          "Economia Geral",
          "Economia Brasil"
        ];
        return _titulosEconomia;
        break;
      case "Filme":
        var _titulosFilmes = [
          "Selecione Título",
          "Filmes Antigos",
          "Ganhadores do Oscar"
        ];
        return _titulosFilmes;
        break;
      case "Arte":
        var _titulosArte = [
          "Selecione Título",
          "Arte Moderna",
          "Arte Barroca",
          "Arte Plásticas"
        ];
        return _titulosArte;
        break;
      case "Transporte":
        var _titulosTransporte = [
          "Selecione Título",
          "Transporte Público",
          "Transporte por Aplicativo"
        ];
        return _titulosTransporte;
        break;
      case "Saúde":
        var _titulosSaude = [
          "Selecione Título",
          "Saúde Idoso",
          "Saúde Pública",
          "Saúde Privada"
        ];
        return _titulosSaude;
        break;
      case "Educação":
        var _titulosEducacao = [
          "Selecione Título",
          "Educação Infantil",
          "Educação Superior"
        ];
        return _titulosEducacao;
        break;
    }
  }
}
