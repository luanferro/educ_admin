import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';

abstract class AdicionarPunicaoDataSource {
  Future<bool> adicionarPunicao(
      PunicaoEntity punicaoEntity, String usuario, String professor);
}
