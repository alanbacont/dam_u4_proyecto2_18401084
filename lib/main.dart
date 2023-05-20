import 'package:dam_u4_proyecto2_18401084/pages/add_asignacion.dart';
import 'package:dam_u4_proyecto2_18401084/pages/asignacion_detalles.dart';
import 'package:dam_u4_proyecto2_18401084/pages/asignaciones.dart';
import 'package:dam_u4_proyecto2_18401084/pages/asistencias.dart';
import 'package:dam_u4_proyecto2_18401084/pages/consultas/asistencia_revisor.dart';
import 'package:dam_u4_proyecto2_18401084/pages/consultas/consulta_por_docente.dart';
import 'package:dam_u4_proyecto2_18401084/pages/consultas/rango_fechas.dart';
import 'package:dam_u4_proyecto2_18401084/pages/home.dart';
import 'package:dam_u4_proyecto2_18401084/pages/reportes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegurar la inicialización del binding
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
        '/reportes': (context) => PaginaReportes(),
        '/addAsignacion': (context) => AddAsignacion(),
        '/asignacionDetail': (context) => AsignacionDetails(),
        '/asistenciaPorDocente': (context) => AsistenciaPorDocentePage(),
        '/asistenciasPorRangoFechas': (context) => AsistenciasPorRangoFechasPage(),
        //'/asistenciasPorRangoFechasEdificio': (context) => AsistenciasPorRangoFechasEdificioPage(),
        '/asistenciasPorRevisor': (context) => AsistenciasPorRevisorPage(),
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