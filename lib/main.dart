import 'package:bot_toast/bot_toast.dart';
import 'package:argument/screens/atividade/atividade.dart';
import 'package:argument/screens/auth/login.dart';
import 'package:argument/screens/auth/recover.dart';
import 'package:argument/screens/auth/register.dart';
import 'package:argument/screens/auth/splash.dart';
import 'package:argument/screens/debate/debate.dart';
import 'package:argument/screens/home/home.dart';
import 'package:argument/service/atividade_service.dart';
import 'package:argument/service/usuario_service.dart';
import 'package:argument/stores/atividade_store.dart';
import 'package:argument/stores/usuario_store.dart';
import 'package:argument/utils/navigator_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MultiProvider(
        providers: [
          Provider<UsuarioService>(
            create: (_) => UsuarioService(UsuarioStore(),FirebaseAuth.instance, Firestore.instance),
            dispose: (ctx, usuarioService) {
              usuarioService.dispose();
            },
          ),
          Provider<AtividadeService>(
            create: (_){
              return AtividadeService(AtividadeStore(),Firestore.instance);
            },
            dispose: (ctx, atividadeService) {
              atividadeService.dispose();
            }
          ),
        ],
        child: MaterialApp(
          title: 'Argument',
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          navigatorKey: NavigatorUtils.nav,
          theme: ThemeData(
              primarySwatch: Colors.purple,
              buttonTheme: ButtonThemeData(buttonColor: Colors.purple[300],textTheme: ButtonTextTheme.primary, height: 50)),
          initialRoute: "splash",
          routes: {
            "splash": (context) => Splash(),
            "login": (context) => LoginScreen(),
            "home": (context) => HomeScreen(),
            "register": (context) => RegisterScreen(),
            "recover": (context) => RecoverScreen(),
            "atividade": (context) => AtividadeScreen(),
            "debate": (context) => DebateScreen(),
          },
        ),
      ),
    );
  }
}
