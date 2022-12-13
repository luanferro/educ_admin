import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';

abstract class AdicionarPontosDataSource {
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario);
}
