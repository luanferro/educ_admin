import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:either_dart/either.dart';

abstract class BuscarAlunoDataSource {
  Future<Either<Exception, AdministradorEntity>> buscarAdmin(String usuario);
  Future<String> carregarImagemPerfil(String imagemName);
}
