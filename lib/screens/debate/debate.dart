import 'package:argument/components/body.dart';
import 'package:argument/screens/atividade/atividade.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class DebateScreen extends StatefulWidget {
  final String ptema;

  const DebateScreen({Key key, this.ptema}) : super(key: key);
  @override
  _DebateScreenState createState() => _DebateScreenState();
}

class _DebateScreenState extends State<DebateScreen> {
  UsuarioService _usuarioService;

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      floatingActionButton: Observer(
        builder: (ctx) {
          if (_usuarioService.usuarioStore.usuario.admin) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtividadeScreen(
                        ptema: widget.ptema,
                      ),
                    ));
              },
              child: Icon(Icons.add),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      body: Body(tema: widget.ptema),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          }),
      centerTitle: true,
      title: Text(
        "${widget.ptema}".toUpperCase(),
      ),
    );
  }
}
