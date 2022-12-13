import 'package:cloud_firestore/cloud_firestore.dart';

class PontoEntity {
  String? tipo;
  num? pontos;
  String? motivo;
  String? categoria;

  PontoEntity({this.tipo, this.pontos, this.motivo, this.categoria});

  factory PontoEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PontoEntity(
        tipo: data?['tipo'],
        pontos: data?['pontos'],
        motivo: data?['motivo'],
        categoria: data?['categoria']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "tipo": tipo,
      "pontos": pontos,
      "motivo": motivo,
      "categoria": categoria,
    };
  }
}
