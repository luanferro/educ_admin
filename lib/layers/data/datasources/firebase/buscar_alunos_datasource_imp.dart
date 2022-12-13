// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/data/datasources/buscar_alunos_datasource.dart';
import 'package:either_dart/src/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';

class BuscarAlunosDataSourceImp implements BuscarAlunosDataSource {
  @override
  Future<Either<Exception, List<AlunoEntity>>> buscarAlunos(
      {required String turma}) async {
    var db = FirebaseFirestore.instance;
    try {
      List<AlunoEntity> listaAlunos = [];
      List<AlunoEntity> listaAlunosTurma = [];

      QuerySnapshot alunos = await db.collection("alunos").get();

      listaAlunos = [];

      for (var doc in alunos.docs) {
        AlunoEntity aluno = AlunoEntity(
            nome: doc.get("nome"),
            sexo: doc.get("sexo"),
            dataNascimento: doc.get("data_nascimento"),
            matricula: doc.get("matricula"),
            ano: doc.get("ano"),
            turma: doc.get("turma"),
            usuario: doc.get("usuario"),
            fotoPerfil: doc.get("fotoPerfil"),
            senha: doc.get("senha"),
            pontos: doc.get("pontos"));

        listaAlunos.add(aluno);
      }

      listaAlunos.sort(
        (a, b) => a.pontos!.compareTo(b.pontos!),
      );

      listaAlunos = listaAlunos.reversed.toList();

      if (turma != "") {
        for (var aluno in listaAlunos) {
          if (aluno.turma!.contains(turma)) {
            listaAlunosTurma.add(aluno);
          }
        }
        return Right(listaAlunosTurma);
      }

      return Right(listaAlunos);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
