import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAsignaciones() async {
  List asignacion = [];
  QuerySnapshot queryAsignacion = await db.collection('asignacion').get();
    for (var doc in queryAsignacion.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final asig = {
        "edificio": data['edificio'],
        "horario": data['horario'],
        "docente": data['docente'],
        "materia": data['materia'],
        "salon": data['salon'],
        "uid":doc.id,
      };
      asignacion.add(asig);
    }
    print(asignacion); // Aquí imprimo los datos obtenidos de Firestore
    await Future.delayed(const Duration(seconds: 1));
    return asignacion;
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


Future<void> insertarAsignacion(String salon, edificio, horario, docente, materia) async{
  await db.collection("asignacion").add({
    "salon":salon,
    "edificio":edificio,
    "horario":horario,
    "docente":docente,
    "materia":materia,
  });
}

Future<void> actualizarAsignacion(String uid, newsalon, newedificio,
    newhorario, newdocente, newmateria) async{
  await db.collection("asignacion").doc(uid).set({
    "salon":newsalon,
    "edificio":newedificio,
    "horario":newhorario,
    "docente":newdocente,
    "materia":newmateria,
  });
}

Future<void> borrarAsignacion(String uid) async{
  await db.collection('asignacion').doc(uid).delete();
}

Future<List> getAsistencias(String asignacionId) async {
  List asistencia = [];
  QuerySnapshot queryAsistencia = await db.collection('asignacion').doc(asignacionId).collection('asistencia').get();
  for(var doc in queryAsistencia.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asis = {
      "fecha/hora": data['fecha/hora'],
      "revisor":data['revisor'],
      "uid":doc.id,
    };
    asistencia.add(asis);
  }
  await Future.delayed(const Duration(seconds: 2));
  return asistencia;
}

Future<void> insertarAsistencia(String asignacionId,
    Map<String, dynamic> asistenciaData) async{
  await db.collection('asignacion').doc(asignacionId).collection('asistencia')
      .add(asistenciaData);
}

Future<List> getAsistenciaPorDocente(String nombreDocente) async {
  List asistencias = [];
  QuerySnapshot querySnapshot = await db
      .collection('asignacion')
      .where('docente', isEqualTo: nombreDocente)
      .get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data()).toList());
  }
  return asistencias;
}

Future<List> getAsistenciasPorRangoFechas(DateTime fechaInicio, DateTime fechaFin) async {
  List asistencias = [];
  QuerySnapshot querySnapshot = await db
      .collection('asignacion')
      .get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .where('fecha/hora', isGreaterThanOrEqualTo: fechaInicio, isLessThan: fechaFin)
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data()).toList());
  }
  return asistencias;
}

Future<List> getAsistenciasPorRangoFechasEdificio(DateTime fechaInicio, DateTime fechaFin, String edificio) async {
  List asistencias = [];
  QuerySnapshot querySnapshot = await db
      .collection('asignacion')
      .where('edificio', isEqualTo: edificio)
      .get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .where('fecha/hora', isGreaterThanOrEqualTo: fechaInicio, isLessThan: fechaFin)
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data()).toList());
  }
  return asistencias;
}

Future<List<Map<String, dynamic>>> getAsistenciasPorRevisor(String nombreRevisor) async {
  List<Map<String, dynamic>> asistencias = [];
  QuerySnapshot querySnapshot = await db
      .collectionGroup('asistencia')
      .where('revisor', isEqualTo: nombreRevisor)
      .get();

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    DocumentSnapshot asignacionSnapshot = await doc.reference.parent.parent!.get();

    if (asignacionSnapshot.exists) {
      Map<String, dynamic>? asistenciaData = doc.data() as Map<String, dynamic>?;

      if (asistenciaData != null) {
        asistenciaData['asignacion'] = asignacionSnapshot.data() as Map<String, dynamic>?;
        asistencias.add(asistenciaData);
      }
    }
  }

  return asistencias;
}


