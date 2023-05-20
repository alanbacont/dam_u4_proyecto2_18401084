import 'package:flutter/cupertino.dart';

class Consultas extends StatefulWidget {
  const Consultas({Key? key}) : super(key: key);

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text('Asistencia por Docente'),
              onPressed: () {
                Navigator.pushNamed(context, '/asistenciaPorDocente');
              },
            ),
            CupertinoButton(
              child: Text('Asistencias por Rango de Fechas'),
              onPressed: () {
                Navigator.pushNamed(context, '/asistenciasPorRangoFechas');
              },
            ),
            CupertinoButton(
              child: Text('Asistencias por Rango de Fechas y Edificio'),
              onPressed: () {
                Navigator.pushNamed(context, '/asistenciasPorRangoFechasEdificio');
              },
            ),
            CupertinoButton(
              child: Text('Asistencias por Revisor'),
              onPressed: () {
                Navigator.pushNamed(context, '/asistenciasPorRevisor');
              },
            ),
          ],
        ),
      ),
    );
  }
}

