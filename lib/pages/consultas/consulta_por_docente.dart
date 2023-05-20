import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../services/firebase_service.dart';

class AsistenciaPorDocentePage extends StatefulWidget {
  const AsistenciaPorDocentePage({Key? key}) : super(key: key);

  @override
  _AsistenciaPorDocentePageState createState() => _AsistenciaPorDocentePageState();
}

class _AsistenciaPorDocentePageState extends State<AsistenciaPorDocentePage> {
  String docente = '';
  List asistencias = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Asistencia por Docente'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            CupertinoTextField(
              placeholder: 'Nombre del Docente',
              onChanged: (value) {
                setState(() {
                  docente = value;
                });
              },
            ),
            CupertinoButton(
              child: Text('Consultar'),
              onPressed: () async {
                if (docente.isNotEmpty) {
                  asistencias = await getAsistenciaPorDocente(docente);
                  setState(() {}); // Para refrescar la UI después de obtener los datos.
                }
              },
            ),
            for (var asistencia in asistencias)
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text('Docente: ${asistencia['docente'] ?? 'No disponible'}'),
                    Text('Fecha/Hora: ${DateFormat('yyyy-MM-dd / kk:mm').format(asistencia['fecha/hora'].toDate())}'),
                    Text('Revisor: ${asistencia['revisor'] ?? 'No disponible'}'),
                    // Agrega más campos aquí si es necesario
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
