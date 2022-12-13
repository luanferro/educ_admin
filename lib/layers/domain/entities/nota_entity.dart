import 'package:cloud_firestore/cloud_firestore.dart';

class NotaEntity {
  final num nota;
  final String materia;
  final int bimestre;

  NotaEntity({
    required this.nota,
    required this.materia,
    required this.bimestre,
  });

  factory NotaEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotaEntity(
        nota: data?['nota'],
        materia: data?['materia'],
        bimestre: data?['bimestre']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nota": nota,
      "materia": materia,
      "bimestre": bimestre,
    };
  }
}
