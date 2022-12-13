import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/data/datasources/adicionar_pontos_datasource.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdicionarPontosDataSourceImp implements AdicionarPontosDataSource {
  var db = FirebaseFirestore.instance;

  @override
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario) async {
    try {
      final pontos = <String, dynamic>{
        "categoria": ponto.categoria,
        "pontos": ponto.pontos,
        "motivo": ponto.motivo,
        "tipo": ponto.tipo
      };

      db
          .collection("alunos")
          .doc(usuario)
          .collection("historicoPontos")
          .doc()
          .set(pontos);
      return true;
    } catch (e) {
      return false;
    }
  }
}
