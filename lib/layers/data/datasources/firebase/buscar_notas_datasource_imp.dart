import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/domain/entities/nota_entity.dart';
import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/data/datasources/buscar_notas_datasource.dart';

class BuscarNotasDataSourceImp implements BuscarNotasDataSource {
  var db = FirebaseFirestore.instance;

  @override
  Future<Either<Exception, List<NotaEntity>>> getNotas(String usuario) async {
    try {
      List<NotaEntity> listaNotas = [];

      QuerySnapshot notas =
          await db.collection("alunos").doc(usuario).collection("notas").get();

      listaNotas = [];

      for (var doc in notas.docs) {
        NotaEntity nota = NotaEntity(
            nota: doc.get("nota"),
            materia: doc.get("materia"),
            bimestre: doc.get("bimestre"));
        listaNotas.add(nota);
      }

      return Right(listaNotas);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
