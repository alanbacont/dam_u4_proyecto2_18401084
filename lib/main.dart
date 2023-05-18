import 'package:dam_u4_proyecto2_18401084/pages/asignaciones.dart';
import 'package:dam_u4_proyecto2_18401084/pages/asistencias.dart';
import 'package:dam_u4_proyecto2_18401084/pages/home.dart';
import 'package:dam_u4_proyecto2_18401084/pages/reportes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaPrincipal(),
        '/asignaciones': (context) => PaginaAsignaciones(),
        '/asistencias': (context) => PaginaAsistencias(),
        '/reportes': (context) => PaginaReportes(),
      },
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(),
      builder: (context, child) {
        final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
        return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          child: child!,
        );
      },
    );
  }
}