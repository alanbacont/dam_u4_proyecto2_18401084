import 'package:flutter/cupertino.dart';
import 'add_asignacion.dart';
import 'asignacion_detalles.dart';
import 'asignaciones.dart';
import 'asistencias.dart';
import 'consultas.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        activeColor: CupertinoColors.activeOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Asignaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.check_mark_circled),
            label: 'Asistencias',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Consultas',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              routes: {
                '/': (context) => PaginaAsignaciones(),
                '/asignacionDetail': (context) => AsignacionDetails(),
                '/addAsignacion': (context) => AddAsignacion(),
              },
            );
          case 1:
            return CupertinoTabView(
              routes: {
                '/': (context) => PaginaAsistencias(),
                // agrega aquí las demás rutas que necesites en esta vista
              },
            );
          case 2:
            return CupertinoTabView(
              routes: {
                '/': (context) => Consultas(),
                // agrega aquí las demás rutas que necesites en esta vista
              },
            );
          default:
            return CupertinoTabView(builder: (context) {
              return Center(child: Text('Página no encontrada'));
            });
        }
      },
    );
  }
}
