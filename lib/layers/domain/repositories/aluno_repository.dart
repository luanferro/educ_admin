import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';

abstract class AlunoRepository {
  Future<Either<Exception, AdministradorEntity>> buscarAdmin(String usuario);

  Future<Either<Exception, List<AlunoEntity>>> buscarAlunos(
      {required String turma});
  Future<String> buscarImagemPerfil(String imagemName);
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario);
}
