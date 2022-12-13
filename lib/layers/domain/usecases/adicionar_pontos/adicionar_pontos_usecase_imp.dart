import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';
import 'package:educ_admin/layers/domain/usecases/adicionar_pontos/adicionar_pontos_usecase.dart';

class AdicionarPontosUseCaseImp implements AdicionarPontosUseCase {
  final AlunoRepository _alunoRepository;

  AdicionarPontosUseCaseImp(this._alunoRepository);

  @override
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario) {
    return _alunoRepository.adicionarPontos(ponto, usuario);
  }
}
