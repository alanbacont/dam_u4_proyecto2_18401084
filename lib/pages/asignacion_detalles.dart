import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  void dispose() {
    _salonController.dispose();
    _edificioController.dispose();
    _horarioController.dispose();
    _docenteController.dispose();
    _materiaController.dispose();
    super.dispose();
  }

  void mostrarActualizarAsignacion(BuildContext context, Map<String, dynamic> asignacion) {
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
            await FirebaseFirestore.instance.collection('asignacion').doc(asignacion['id']).update({
              "salon": _salonController.text,
              "edificio": _edificioController.text,
              "horario": _horarioController.text,
              "docente": _docenteController.text,
              "materia": _materiaController.text,
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asignacion = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detalle de Asignación'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.pencil),
          onPressed: () => mostrarActualizarAsignacion(context, asignacion),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.person_fill, color: CupertinoTheme.of(context).primaryColor,),
                      SizedBox(width: 10),
                      Text('Docente: ${asignacion["docente"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(CupertinoIcons.textformat, color: CupertinoTheme.of(context).primaryColor,),
                      SizedBox(width: 10),
                      Text('Salón: ${asignacion["salon"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(CupertinoIcons.building_2_fill, color: CupertinoTheme.of(context).primaryColor,),
                      SizedBox(width: 10),
                      Text('Edificio: ${asignacion["edificio"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(CupertinoIcons.clock, color: CupertinoTheme.of(context).primaryColor,),
                      SizedBox(width: 10),
                      Text('Horario: ${asignacion["horario"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(CupertinoIcons.book_fill, color: CupertinoTheme.of(context).primaryColor,),
                      SizedBox(width: 10),
                      Text('Materia: ${asignacion["materia"]}', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
