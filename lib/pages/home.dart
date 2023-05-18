import 'package:flutter/cupertino.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Asistencia Tec'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido al Registro de Asistencia',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            CupertinoButton.filled(
              child: Text('Gestionar Asignaciones'),
              onPressed: () {
                Navigator.pushNamed(context, '/asignaciones');
              },
            ),
            SizedBox(height: 10),
            CupertinoButton.filled(
              child: Text('Gestionar Asistencias'),
              onPressed: () {
                Navigator.pushNamed(context, '/asistencias');
              },
            ),
            SizedBox(height: 10),
            CupertinoButton.filled(
              child: Text('Ver Reportes'),
              onPressed: () {
                Navigator.pushNamed(context, '/reportes');
              },
            ),
          ],
        ),
      ),
    );
  }
}


