import 'dart:async';

import 'package:argument/domain/atividade.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Atividade>items;


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
            child: Text("Sem atividades para exibir"),
          );
        }
        return ListView(
          children: _atividadeService.atividadeStore.atividades.map((atividade) {
            return Card(
                elevation: 15,
                child: InkWell(
                  child: Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5)
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://image.freepik.com/vetores-gratis/ilustracao-de-debates-politicos_9041-74.jpg"))
                          ),
                        ),
                        Container(
                          height: 200,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(""),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text('Tema: '+atividade.tema,style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)
                                    ),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text('Título: '+atividade.titulo,style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)
                                    ),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text('Texto: '+atividade.texto,style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)
                                    ),),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text("Início: ${DateFormat("dd/MM/yyyy").format(atividade.dataHoraInicio)}",
                                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Observer(
                                        builder: (ctx) {
                                          if (_usuarioService.usuarioStore.usuario.admin) {
                                            return InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(20),
                                                // child: Text("Editar"),
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
                                          //child: Text("Avise-me"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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