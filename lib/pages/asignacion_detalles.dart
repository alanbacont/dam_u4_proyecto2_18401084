import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_18401084/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';

import 'asistencias.dart';

class AsignacionDetails extends StatefulWidget {
  const AsignacionDetails({Key? key}) : super(key: key);

  @override
  _AsignacionDetailsState createState() => _AsignacionDetailsState();
}

class _AsignacionDetailsState extends State<AsignacionDetails> {
  final _salonController = TextEditingController();
  final _edificioController = TextEditingController();
  final _horarioController = TextEditingController();
  final _docenteController = TextEditingController();
  final _materiaController = TextEditingController();

  late Map<String, dynamic> asignacion;

  @override
  void dispose() {
    _salonController.dispose();
    _edificioController.dispose();
    _horarioController.dispose();
    _docenteController.dispose();
    _materiaController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> getAsignacion(String uid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('asignacion').doc(uid).get();
      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error al obtener asignación: $e');
      // Devuelve un mapa vacío si no se puede obtener la asignación
      return {};
    }
  }

  void mostrarActualizarAsignacion(BuildContext context) {
    _salonController.text = asignacion['salon'];
    _edificioController.text = asignacion['edificio'];
    _horarioController.text = asignacion['horario'];
    _docenteController.text = asignacion['docente'];
    _materiaController.text = asignacion['materia'];

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Actualizar Asignación'),
        actions: <Widget>[
          CupertinoTextField(
            controller: _salonController,
            placeholder: 'Salón',
          ),
          CupertinoTextField(
            controller: _edificioController,
            placeholder: 'Edificio',
          ),
          CupertinoTextField(
            controller: _horarioController,
            placeholder: 'Horario',
          ),
          CupertinoTextField(
            controller: _docenteController,
            placeholder: 'Docente',
          ),
          CupertinoTextField(
            controller: _materiaController,
            placeholder: 'Materia',
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Actualizar'),
          onPressed: () async {
            await FirebaseFirestore.instance.collection('asignacion').doc(asignacion['uid']).update({
              "salon": _salonController.text,
              "edificio": _edificioController.text,
              "horario": _horarioController.text,
              "docente": _docenteController.text,
              "materia": _materiaController.text,
            });

            // Obtiene la asignación actualizada y refresca la UI
            asignacion = await getAsignacion(asignacion['uid']);
            setState(() {});

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    asignacion = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detalle de Asignación'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.pencil),
          onPressed: () => mostrarActualizarAsignacion(context),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoFormSection(
                header: Text("Detalles de Asignado", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                children: [
                  CupertinoFormRow(
                    child: Text('Docente: ${asignacion["docente"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor),),
                    prefix: Icon(CupertinoIcons.person_fill, color: CupertinoColors.activeOrange,),
                    padding: EdgeInsets.all(11.0),
                  ),
                  CupertinoFormRow(
                    child: Text('Salón: ${asignacion["salon"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor),),
                    prefix: Icon(CupertinoIcons.textformat, color: CupertinoColors.activeOrange,),
                    padding: EdgeInsets.all(11.0),
                  ),
                  CupertinoFormRow(
                    child: Text('Edificio: ${asignacion["edificio"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor),),
                    prefix: Icon(CupertinoIcons.building_2_fill, color: CupertinoColors.activeOrange),
                    padding: EdgeInsets.all(11.0),
                  ),
                  CupertinoFormRow(
                    child: Text('Horario: ${asignacion["horario"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor),),
                    prefix: Icon(CupertinoIcons.clock, color: CupertinoColors.activeOrange),
                    padding: EdgeInsets.all(11.0),
                  ),
                  CupertinoFormRow(
                    child: Text('Materia: ${asignacion["materia"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor),),
                    prefix: Icon(CupertinoIcons.book_fill, color: CupertinoColors.activeOrange,),
                    padding: EdgeInsets.all(11.0),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(40)),
              CupertinoButton.filled(
                pressedOpacity: 0.7,
                child: Text('Ver Asistencias'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PaginaAsistencias(asignacionId: asignacion['uid'].toString())),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}