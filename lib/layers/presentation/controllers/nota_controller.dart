import 'package:educ_admin/layers/domain/entities/nota_entity.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_notas/buscar_notas_usecase.dart';
import 'package:either_dart/either.dart';

class NotaController {
  final BuscarNotasUseCase _buscarNotasUseCase;

  NotaController(this._buscarNotasUseCase);
  Either<Exception, List<NotaEntity>>? retorno;
  List<NotaEntity> notas1bim = [];
  List<NotaEntity> notas2bim = [];
  List<NotaEntity> notas3bim = [];
  List<NotaEntity> notas4bim = [];

  buscarNotasUseCase(String usuario) async {
    notas1bim.clear();
    notas2bim.clear();
    notas3bim.clear();
    notas4bim.clear();
    retorno = await _buscarNotasUseCase.buscarNotas(usuario);
    if (retorno!.isRight) {
      for (var nota in retorno!.right) {
        if (nota.bimestre == 1) {
          notas1bim.add(nota);
        } else if (nota.bimestre == 2) {
          notas2bim.add(nota);
        } else if (nota.bimestre == 3) {
          notas3bim.add(nota);
        } else {
          notas4bim.add(nota);
        }
      }
    }
  }
}
