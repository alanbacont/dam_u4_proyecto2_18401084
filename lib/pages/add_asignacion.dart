import 'package:flutter/cupertino.dart';
import 'package:dam_u4_proyecto2_18401084/services/firebase_service.dart';

class AddAsignacion extends StatefulWidget {
  const AddAsignacion({Key? key}) : super(key: key);

  @override
  State<AddAsignacion> createState() => _AddAsignacionState();
}

class _AddAsignacionState extends State<AddAsignacion> {
  TextEditingController salonController = TextEditingController();
  TextEditingController edificioController = TextEditingController();
  TextEditingController horarioController = TextEditingController();
  TextEditingController docenteController = TextEditingController();
  TextEditingController materiaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Agregar Asignacion'),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Salon', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  CupertinoTextField(controller: salonController, placeholder: 'Ingrese el salon', prefix: Padding(padding: EdgeInsets.all(4), child: Icon(CupertinoIcons.textformat),),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Edificio', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  CupertinoTextField(controller: edificioController, placeholder: 'Ingrese el edificio', prefix: Padding(padding: EdgeInsets.all(4), child: Icon(CupertinoIcons.building_2_fill),),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Horario', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  CupertinoTextField(controller: horarioController, placeholder: 'Ingrese el horario', prefix: Padding(padding: EdgeInsets.all(4), child: Icon(CupertinoIcons.clock),),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Docente', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  CupertinoTextField(controller: docenteController, placeholder: 'Ingrese el docente', prefix: Padding(padding: EdgeInsets.all(4), child: Icon(CupertinoIcons.person_fill),),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Materia', style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  CupertinoTextField(controller: materiaController, placeholder: 'Ingrese la materia', prefix: Padding(padding: EdgeInsets.all(4), child: Icon(CupertinoIcons.book_fill),),),
                ],
              ),
            ),
            CupertinoButton.filled(
              child: Text('Agregar Asignacion'),
              onPressed: () async {
                await insertarAsignacion(
                  salonController.text,
                  edificioController.text,
                  horarioController.text,
                  docenteController.text,
                  materiaController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}