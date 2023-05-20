import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../services/firebase_service.dart';

class AsistenciasPorRevisorPage extends StatefulWidget {
  const AsistenciasPorRevisorPage({Key? key}) : super(key: key);

  @override
  _AsistenciasPorRevisorPageState createState() => _AsistenciasPorRevisorPageState();
}

class _AsistenciasPorRevisorPageState extends State<AsistenciasPorRevisorPage> {
  String revisor = '';
  List<Map<String, dynamic>> asistencias = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Asistencias por Revisor'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            CupertinoTextField(
              placeholder: 'Nombre del Revisor',
              onChanged: (value) {
                setState(() {
                  revisor = value;
                });
              },
            ),
            CupertinoButton(
              child: Text('Consultar'),
              onPressed: () async {
                if (revisor.isNotEmpty) {
                  asistencias = await getAsistenciasPorRevisor(revisor);
                  setState(() {}); // Para refrescar la UI después de obtener los datos.
                }
              },
            ),
            for (var asistencia in asistencias)
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: CupertinoButton(
                  padding: EdgeInsets.all(15),
                  color: CupertinoColors.black,
                  onPressed: () {}, // Implementar acción si es necesario.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Docente: ${asistencia['asignacion']['docente']}'),
                      Text('Fecha/Hora: ${DateFormat('yyyy-MM-dd – kk:mm').format(asistencia['fecha/hora'].toDate())}'),
                      Text('Revisor: ${asistencia['revisor']}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
