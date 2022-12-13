import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_admin/buscar_admin_usecase.dart';

class BuscarAdminUseCaseImp implements BuscarAdminUseCase {
  final AlunoRepository _alunoRepository;

  BuscarAdminUseCaseImp(this._alunoRepository);

  @override
  Future<Either<Exception, AdministradorEntity>> buscarAdmin(String usuario) {
    return _alunoRepository.buscarAdmin(usuario);
  }
}
