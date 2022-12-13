import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';

abstract class BuscarAdminUseCase {
  Future<Either<Exception, AdministradorEntity>> buscarAdmin(String usuario);
}
