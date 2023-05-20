import 'package:flutter/cupertino.dart';
import 'asignaciones.dart';
import 'consultas.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _currentIndex = 0;

  final _tabPages = <Widget>[
    PaginaAsignaciones(),
    Consultas(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 70,
        iconSize: 30,
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        activeColor: CupertinoColors.activeOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Asignaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Consultas',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return _tabPages[_currentIndex];
      },
    );
  }
}
