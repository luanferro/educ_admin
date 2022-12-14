import 'package:cloud_firestore/cloud_firestore.dart';

class PunicaoEntity {
  num? nivel;
  String? motivo;
  String? data;
  String? professor;

  PunicaoEntity({this.nivel, this.motivo, this.data, this.professor});

  factory PunicaoEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PunicaoEntity(
        nivel: data?['nivel'],
        motivo: data?['motivo'],
        data: data?['motivo'],
        professor: data?['professor']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nivel": nivel,
      "motivo": motivo,
      "data": data,
      "professor": professor
    };
  }
}
