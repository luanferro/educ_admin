import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/nota_entity.dart';

abstract class BuscarNotasUseCase {
  Future<Either<Exception, List<NotaEntity>>> buscarNotas(String usario);
}
