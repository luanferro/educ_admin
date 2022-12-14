import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_punicoes/buscar_punicoes_usecase.dart';
import 'package:either_dart/src/either.dart';

class BuscarPunicoesUseCaseImp implements BuscarPunicoesUseCase {
  final AlunoRepository _alunoRepository;

  BuscarPunicoesUseCaseImp(this._alunoRepository);
  @override
  Future<Either<Exception, List<PunicaoEntity>>> buscarPunicoes(
      String usuario) {
    return _alunoRepository.buscarPunicoes(usuario);
  }
}
