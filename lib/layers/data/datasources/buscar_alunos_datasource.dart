import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:either_dart/either.dart';

abstract class BuscarAlunosDataSource {
  Future<Either<Exception, List<AlunoEntity>>> buscarAlunos(
      {required String turma});
}
