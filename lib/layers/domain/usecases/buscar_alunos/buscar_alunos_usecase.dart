import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';

abstract class BuscarAlunosUseCase {
  Future<Either<Exception, List<AlunoEntity>>> buscarAlunos(
      {required String turma});
}
