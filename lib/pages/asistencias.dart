import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../services/firebase_service.dart';

class PaginaAsistencias extends StatefulWidget {
  final String asignacionId;

  const PaginaAsistencias({Key? key, required this.asignacionId}) : super(key: key);

  @override
  State<PaginaAsistencias> createState() => _PaginaAsistenciasState();
}

class _PaginaAsistenciasState extends State<PaginaAsistencias> {
  late Future<List> _futureAsistencias;

  @override
  void initState() {
    super.initState();
    _futureAsistencias = getAsistencias(widget.asignacionId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Asistencias para la Asignación ${widget.asignacionId}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.plus),
          onPressed: () {
            // Aquí se llama a la función que añade una asistencia
            addAsistencia(context, widget.asignacionId);
            setState(() {
              _futureAsistencias = getAsistencias(widget.asignacionId);
            });
          },
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List>(
          future: _futureAsistencias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final asistencia = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Revisor: ${asistencia['revisor']}'),
                            Text('Fecha/Hora: \n ${DateFormat('dd/MM/yyyy HH:mm').format((asistencia['fecha/hora'] as Timestamp).toDate())}'),
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
                child: Text('Error al cargar las asistencias: $errorDescription'),
              );
            } else {
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

void addAsistencia(BuildContext context, String asignacionId) {
  final _revisorController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: const Text('Agregar Asistencia'),
      message: Column(
        children: [
          CupertinoTextField(
            controller: _revisorController,
            placeholder: 'Revisor',
          ),
          CupertinoButton(
            child: Text('Fecha/Hora: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDate)}'),
            onPressed: () async {
              final DateTime? picked = await showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (context) {
                  return Container(
                    height: 200,
                    color: CupertinoColors.white,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 22.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SafeArea(
                          top: false,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.dateAndTime,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              _selectedDate = newDateTime;
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
              if (picked != null) {
                _selectedDate = picked;
              }
            },
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Agregar'),
        onPressed: () {
          final asistenciaData = {
            "revisor": _revisorController.text,
            "fecha/hora": Timestamp.fromDate(_selectedDate),
          };
          insertarAsistencia(asignacionId, asistenciaData);
          Navigator.pop(context);
        },
      ),
    ),
  );
}
