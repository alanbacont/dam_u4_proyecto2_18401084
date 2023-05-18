import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:dam_u4_proyecto2_18401084/services/firebase_service.dart';

class PaginaAsignaciones extends StatefulWidget {
  const PaginaAsignaciones({Key? key}) : super(key: key);

  @override
  _PaginaAsignacionesState createState() => _PaginaAsignacionesState();
}

class _PaginaAsignacionesState extends State<PaginaAsignaciones> {
  late Future<List> _futureAsignaciones;

  @override
  void initState() {
    super.initState();
    _futureAsignaciones = getAsignaciones();
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
        child: FutureBuilder<List>(
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
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: CupertinoColors.systemGrey, width: 2.0),
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
              if (snapshot.error is FirebaseException) {
                errorDescription = (snapshot.error as FirebaseException).message ?? '';
              } else {
                errorDescription = snapshot.error.toString();
              }
              print('Error en FutureBuilder: ${snapshot.error}');
              return Center(
                child: Text('Error al cargar las asignaciones: $errorDescription'),
              );
            }
            else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
