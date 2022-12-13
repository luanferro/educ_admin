import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:either_dart/either.dart';

class BuscarPontosDataSourceImp {
  var db = FirebaseFirestore.instance;

  Future<Either<Exception, List<PontoEntity>>> buscarPontosGanhos(
      String usuario) async {
    try {
      List<PontoEntity> listaPontos = [];

      QuerySnapshot pontos = await db
          .collection("alunos")
          .doc(usuario)
          .collection("historicoPontos")
          .get();

      for (var doc in pontos.docs) {
        PontoEntity ponto = PontoEntity(
            tipo: doc.get("tipo"),
            pontos: doc.get("pontos"),
            motivo: doc.get("motivo"),
            categoria: doc.get("categoria"));
        listaPontos.add(ponto);
      }

      return Right(listaPontos);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
