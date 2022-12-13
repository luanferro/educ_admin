import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/nota_entity.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_notas/buscar_notas_usecase.dart';

import '../../repositories/nota_repository.dart';

class BuscarNotasUseCaseImp implements BuscarNotasUseCase {
  final NotaRepository _notaRepository;

  BuscarNotasUseCaseImp(this._notaRepository);

  @override
  Future<Either<Exception, List<NotaEntity>>> buscarNotas(
      String usuario) async {
    return await _notaRepository.buscarNotas(usuario);
  }
}
