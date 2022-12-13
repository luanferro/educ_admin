import 'package:educ_admin/layers/domain/usecases/buscar_foto_perfil/buscar_foto_perfil_usecase.dart';

import '../../repositories/aluno_repository.dart';

class BuscarFotoPerfilUseCaseImp implements BuscarFotoPerfilUseCase {
  final AlunoRepository _alunoRepository;

  BuscarFotoPerfilUseCaseImp(this._alunoRepository);

  @override
  Future<String> buscarImagemPeril(String imagemName) {
    return _alunoRepository.buscarImagemPerfil(imagemName);
  }
}
