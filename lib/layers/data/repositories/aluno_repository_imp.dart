import 'package:educ_admin/layers/data/datasources/adicionar_pontos_datasource.dart';
import 'package:educ_admin/layers/data/datasources/buscar_alunos_datasource.dart';
import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/data/datasources/buscar_aluno_datasource.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';

class AlunoRepositoryImp implements AlunoRepository {
  final BuscarAlunoDataSource _getAlunoDataSource;
  final BuscarAlunosDataSource _buscarAlunosDataSource;
  final AdicionarPontosDataSource _adicionarPontosDataSource;

  AlunoRepositoryImp(this._getAlunoDataSource, this._buscarAlunosDataSource,
      this._adicionarPontosDataSource);

  @override
  Future<Either<Exception, AdministradorEntity>> buscarAdmin(String usuario) {
    return _getAlunoDataSource.buscarAdmin(usuario);
  }

  @override
  Future<Either<Exception, List<AlunoEntity>>> buscarAlunos(
      {required String turma}) {
    return _buscarAlunosDataSource.buscarAlunos(turma: turma);
  }

  @override
  Future<String> buscarImagemPerfil(String imagemName) {
    return _getAlunoDataSource.carregarImagemPerfil(imagemName);
  }

  @override
  Future<bool> adicionarPontos(PontoEntity ponto, String usuario) {
    return _adicionarPontosDataSource.adicionarPontos(ponto, usuario);
  }
}
