import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AtividadeService _atividadeService;
  UsuarioService _usuarioService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);
    _atividadeService = Provider.of<AtividadeService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text("Home", style: TextStyle(fontSize: 32),),
        centerTitle: true,
        actions: [
          Observer(
            builder: (ctx) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ],
                ),
                ),
              child: Observer(
                builder: (ctx) => Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(this._usuarioService.usuarioStore.usuario.nome, style: TextStyle(color: Colors.white, fontSize: 22)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings, color: Colors.grey[400] ),
                  SizedBox(width: 20,),
                  Text(
                    "Conta",
                    style: TextStyle(
                    color: Colors.black54, fontSize: 22,
                    ),
                  ),
                ],
              ),
              onTap: () {
                //adicionar caminho para profile
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.featured_play_list, color: Colors.grey[400]),
                  SizedBox(width: 20,),
                  Text(
                    "Meus Debates",
                    style: TextStyle(
                    color: Colors.black54, fontSize: 22,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("debate");
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.contacts, color: Colors.grey[400]),
                  SizedBox(width: 20,),
                  Text(
                    "Contato",
                    style: TextStyle(
                    color: Colors.black54, fontSize: 22,
                ),
                  ),
                ],
                ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.exit_to_app, color: Colors.grey[400]),
                  SizedBox(width: 20,),
                  Text(
                    "Sair",
                    style: TextStyle(
                    color: Colors.black54, fontSize: 22,
                ),
                ),
                ], 
                ),
                onTap: () {
                _usuarioService.logout();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (ctx) {
          if (_usuarioService.usuarioStore.usuario.admin) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("atividade");
              },
              child:Icon(Icons.add),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      body: _listaAtividades(),
    );
  }

  _listaAtividades() {
    return Observer(
      builder: (ctx) {
        if (_atividadeService.atividadeStore.atividades.isEmpty) {
          return Center(
            child: Text("Sem Debates para exibir"),
          );
        }
        return ListView(
          children: _atividadeService.atividadeStore.atividades.map((atividade) {
            return Card(
                child: InkWell(
              child: Container(
                height: 370,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                      Container(width: double.maxFinite, height: 150, child: Image.network(ativade.foto, fit: BoxFit.cover)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Text(atividade.tema, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Text(atividade.titulo, style: TextStyle(color: Colors.black54), overflow: TextOverflow.ellipsis, maxLines: 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Text(atividade.texto, style: TextStyle(color: Colors.black54), overflow: TextOverflow.ellipsis, maxLines: 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Text("Início: ${DateFormat("dd/MM/yyyy HH:mm").format(atividade.dataHoraInicio)}",
                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Observer(
                            builder: (ctx) {
                              if (_usuarioService.usuarioStore.usuario.admin) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text("Editar"),
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("Avise-me"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
          }).toList(),
        );
      },
    );
  }
}
