import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../services/firebase_service.dart'; // Asegúrate de que esta importación sea correcta.

class AsistenciasPorRangoFechasPage extends StatefulWidget {
  const AsistenciasPorRangoFechasPage({Key? key}) : super(key: key);

  @override
  _AsistenciasPorRangoFechasPageState createState() => _AsistenciasPorRangoFechasPageState();
}

class _AsistenciasPorRangoFechasPageState extends State<AsistenciasPorRangoFechasPage> {
  DateTime fechaInicio = DateTime.now();
  DateTime fechaFin = DateTime.now();
  List asistencias = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Asistencias por Rango de Fechas'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            CupertinoButton(
              child: Text('Fecha de inicio: ${fechaInicio.toString()}'),
              onPressed: () async {
                final DateTime? selectedDate = await showCupertinoModalPopup<DateTime>(
                  context: context,
                  builder: (BuildContext context) => CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: fechaInicio,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() => fechaInicio = newDateTime);
                    },
                  ),
                );
                if (selectedDate != null) {
                  setState(() => fechaInicio = selectedDate);
                }
              },
            ),
            CupertinoButton(
              child: Text('Fecha final: ${fechaFin.toString()}'),
              onPressed: () async {
                final DateTime? selectedDate = await showCupertinoModalPopup<DateTime>(
                  context: context,
                  builder: (BuildContext context) => CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: fechaFin,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() => fechaFin = newDateTime);
                    },
                  ),
                );
                if (selectedDate != null) {
                  setState(() => fechaFin = selectedDate);
                }
              },
            ),
            CupertinoButton(
              child: Text('Consultar'),
              onPressed: () async {
                asistencias = await getAsistenciasPorRangoFechas(fechaInicio, fechaFin);
                setState(() {}); // Para refrescar la UI después de obtener los datos.
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
                    Text('Docente: ${asistencia['docente'] ?? 'No disponible'}'),
                    Text('Fecha/Hora: ${DateFormat('yyyy-MM-dd – kk:mm').format(asistencia['fecha/hora'].toDate())}'),
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
