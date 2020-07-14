import 'package:argument/domain/atividade.dart';
import 'package:argument/screens/auth/edit.dart';
import 'package:argument/screens/debate/debate.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UsuarioService _usuarioService;
  List<Atividade> items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Home".toUpperCase(),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Observer(
                builder: (ctx) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    this._usuarioService.usuarioStore.usuario.foto != null
                        ? CachedNetworkImage(
                            imageUrl:
                                this._usuarioService.usuarioStore.usuario.foto,
                            imageBuilder: (_, imageProvider) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill)),
                              );
                            },
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            child: Icon(Icons.person, size: 40),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(this._usuarioService.usuarioStore.usuario.nome,
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings, color: Colors.grey[400]),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Conta",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                        usuario: this._usuarioService.usuarioStore.usuario)));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.featured_play_list, color: Colors.grey[400]),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Meus Debates",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
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
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Contato",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.exit_to_app, color: Colors.grey[400]),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Sair",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
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
//      floatingActionButton: Observer(
//        builder: (ctx) {
//          if (_usuarioService.usuarioStore.usuario.admin) {
//            return FloatingActionButton(
//              onPressed: () {
//                Navigator.of(context).pushNamed("atividade");
//              },
//              child:Icon(Icons.add),
//            );
//          } else {
//            return SizedBox.shrink();
//          }
//        },
//      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Economia',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 70.0,
                        color: Colors.green,
                      ),
                      Text(
                        "Economia",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Filme',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.movie_filter, size: 70.0, color: Colors.cyan),
                      Text(
                        "Filme",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Arte',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.palette,
                          size: 70.0, color: Colors.amberAccent),
                      Text(
                        "Arte",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Transporte',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.departure_board,
                          size: 70.0, color: Colors.teal),
                      Text(
                        "Transporte",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Saúde',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_hospital, size: 70.0, color: Colors.red),
                      Text(
                        "Saúde",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateScreen(
                          ptema: 'Educação',
                        ),
                      ));
                },
                splashColor: Colors.deepPurpleAccent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.book, size: 70.0, color: Colors.blue),
                      Text(
                        "Educação",
                        style: new TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
