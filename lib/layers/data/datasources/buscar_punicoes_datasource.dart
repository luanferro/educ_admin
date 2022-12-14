import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:either_dart/either.dart';

abstract class BuscarPunicoesDataSource {
  Future<Either<Exception, List<PunicaoEntity>>> buscarPunicoes(String usuario);
}
