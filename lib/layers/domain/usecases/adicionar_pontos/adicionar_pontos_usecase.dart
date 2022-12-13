import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';

abstract class AdicionarPontosUseCase {
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario);
}
