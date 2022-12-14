import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';

abstract class AdicionarPunicaoUseCase {
  Future<bool> adicionarPunicao(
      PunicaoEntity punicaoEntity, String usuario, String professor);
}
