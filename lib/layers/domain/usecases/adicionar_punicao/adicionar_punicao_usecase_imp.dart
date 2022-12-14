import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';
import 'package:educ_admin/layers/domain/usecases/adicionar_punicao/adicionar_punicao_usecase.dart';

class AdicionarPunicaoUseCaseImp implements AdicionarPunicaoUseCase {
  final AlunoRepository _alunoRepository;

  AdicionarPunicaoUseCaseImp(this._alunoRepository);

  @override
  Future<bool> adicionarPunicao(
      PunicaoEntity punicaoEntity, String usuario, String professor) {
    return _alunoRepository.adicionarPunicao(punicaoEntity, usuario, professor);
  }
}
