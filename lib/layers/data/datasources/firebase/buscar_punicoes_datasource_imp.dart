import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/data/datasources/buscar_punicoes_datasource.dart';
import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:either_dart/either.dart';

class BuscarPunicoesDataSourceImp implements BuscarPunicoesDataSource {
  var db = FirebaseFirestore.instance;

  @override
  Future<Either<Exception, List<PunicaoEntity>>> buscarPunicoes(
      String usuario) async {
    try {
      List<PunicaoEntity> listaPontos = [];

      QuerySnapshot pontos = await db
          .collection("alunos")
          .doc(usuario)
          .collection("punicoes")
          .get();

      for (var doc in pontos.docs) {
        PunicaoEntity punicao = PunicaoEntity(
            nivel: doc.get("nivel"),
            motivo: doc.get("motivo"),
            data: doc.get("data"),
            professor: doc.get("professor"));
        listaPontos.add(punicao);
      }

      return Right(listaPontos);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
