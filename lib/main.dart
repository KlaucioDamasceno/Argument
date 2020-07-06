import 'package:argument/db/DBhelper.dart';
import 'package:argument/parent.dart';
import 'package:argument/screens/debate/debatedetails.dart';
import 'package:argument/service/comentario_service.dart';
import 'package:argument/stores/comentario_store.dart';
import 'package:argument/stores/hud_store.dart';
import 'package:argument/utils/constants.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DbHelper dbHelper = new DbHelper();
    Firestore.instance.settings(persistenceEnabled: true, cacheSizeBytes: -1);
    return BotToastInit(
      child: MultiProvider(
        providers: [
          Provider<HudStore>(
            create: (_) => HudStore(),
            lazy: false,
          ),
          Provider<UsuarioStore>(
            create: (_) => UsuarioStore(),
            lazy: false,
          ),
          ProxyProvider2<HudStore, UsuarioStore, UsuarioService>(
            update: (_, hudStore, usuarioStore, __) => UsuarioService(
                usuarioStore,
                FirebaseAuth.instance,
                Firestore.instance,
                hudStore),
            lazy: false,
            dispose: (_, usuarioService) {
              usuarioService.dispose();
            },
          ),
          ProxyProvider2<HudStore, UsuarioStore, AtividadeService>(
            update: (_, hudStore, usuarioStore, __) => AtividadeService(
                AtividadeStore(),
                dbHelper,
                Firestore.instance,
                hudStore,
                usuarioStore),
            dispose: (ctx, atividadeService) {
              atividadeService.dispose();
            },
          ),
          ProxyProvider2<HudStore, UsuarioStore, ComentarioService>(
            update: (_, hudStore, usuarioStore, __) => ComentarioService(
                ComentarioStore(), Firestore.instance, hudStore, usuarioStore),
            dispose: (ctx, comentarioService) {
              comentarioService.dispose();
            },
          )
        ],
        child: MaterialApp(
          title: 'Argument',
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          navigatorKey: NavigatorUtils.nav,
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "splash",
          routes: {
            "splash": (context) => Splash(),
            "login": (context) => LoginScreen(),
            "home": (context) => HomeScreen(),
            "register": (context) => RegisterScreen(),
            "recover": (context) => RecoverScreen(),
            "atividade": (context) => AtividadeScreen(),
            "debate": (context) => DebateScreen(),
            "details": (context) => DebateDetails(),
          },
          builder: (ctx, widget) => ParentWidget(widget),
        ),
      ),
    );
  }
}
