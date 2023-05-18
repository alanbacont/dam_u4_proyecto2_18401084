import 'package:flutter/cupertino.dart';
import 'package:dam_u4_proyecto2_18401084/services/firebase_service.dart';


class PaginaAsignaciones extends StatefulWidget {
  const PaginaAsignaciones({Key? key}) : super(key: key);

  @override
  _PaginaAsignacionesState createState() => _PaginaAsignacionesState();
}

class _PaginaAsignacionesState extends State<PaginaAsignaciones> {
  late Future<List> _futureAsignaciones;
  List selectedAsignaciones = [];

  @override
  void initState() {
    super.initState();
    _futureAsignaciones = getAsignaciones();
  }

  Future<void> deleteAsignaciones() async {
    for (var asignacion in selectedAsignaciones) {
       await borrarAsignacion(asignacion['uid']);
    }
    setState(() {
      selectedAsignaciones = [];
      _futureAsignaciones = getAsignaciones();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Gestionar Asignaciones'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: () async {
            await Navigator.pushNamed(context, '/addAsignacion');
            setState(() {
              _futureAsignaciones = getAsignaciones();
            });
          },
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<List>(
              future: _futureAsignaciones,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final asignacion = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/asignacionDetail', arguments: asignacion);
                        },
                        onLongPress: () {
                          setState(() {
                            if (selectedAsignaciones.contains(asignacion)) {
                              selectedAsignaciones.remove(asignacion);
                            } else {
                              selectedAsignaciones.add(asignacion);
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: CupertinoColors.systemGrey, width: 2.0),
                                  left: BorderSide(color: selectedAsignaciones.contains(asignacion) ? CupertinoColors.activeBlue : CupertinoColors.systemGrey, width: 5.0)
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.person_fill, color: CupertinoDynamicColor.resolve(CupertinoColors.label, context), size: 20),
                                        SizedBox(width: 5),
                                        Text('Docente: ${asignacion["docente"]}', style: TextStyle(color: CupertinoDynamicColor.resolve(CupertinoColors.label, context), fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.building_2_fill, color: CupertinoDynamicColor.resolve(CupertinoColors.label, context), size: 20),
                                        SizedBox(width: 5),
                                        Text('Salón: ${asignacion["salon"]} - Materia: ${asignacion["materia"]}', style: TextStyle(color: CupertinoDynamicColor.resolve(CupertinoColors.label, context))),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(CupertinoIcons.arrow_right_circle_fill, color: CupertinoDynamicColor.resolve(CupertinoColors.label, context), size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  String errorDescription = '';
                  print('Error en FutureBuilder: ${snapshot.error}');
                  return Center(
                    child: Text('Error al cargar las asignaciones: $errorDescription'),
                  );
                }
                else {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 40,
                      color: CupertinoColors.activeOrange,
                    ),
                  );
                }
              },
            ),
            if (selectedAsignaciones.isNotEmpty)
              Align(
                alignment: Alignment.center,
                child: CupertinoButton(
                  //alignment: Alignment.center,
                  color: CupertinoColors.destructiveRed,
                  child: Text('Eliminar ${selectedAsignaciones.length}', style: TextStyle(color: CupertinoColors.white),),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text('Eliminar asignaciones'),
                        content: Text('¿Estás seguro de que quieres eliminar las asignaciones seleccionadas?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.pop(context, 'Cancelar');
                            },
                          ),
                          CupertinoDialogAction(
                            textStyle: TextStyle(color: CupertinoColors.systemRed),
                            child: Text('Eliminar'),
                            onPressed: () {
                              Navigator.pop(context, 'Eliminar');
                              deleteAsignaciones();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
