import 'package:educ_admin/layers/data/datasources/adicionar_pontos_datasource.dart';
import 'package:educ_admin/layers/data/datasources/firebase/buscar_aluno_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/firebase/buscar_pontos_datasource_imp.dart';
import 'package:educ_admin/layers/domain/entities/administrador_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:educ_admin/layers/domain/usecases/adicionar_pontos/adicionar_pontos_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_alunos/buscar_alunos_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_foto_perfil/buscar_foto_perfil_usecase.dart';

import 'package:either_dart/either.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_admin/buscar_admin_usecase.dart';

class AlunoController {
  final BuscarAdminUseCase _buscarAdminUseCase;
  final BuscarAlunosUseCase _buscarAlunosUseCase;
  final BuscarFotoPerfilUseCase _buscarFotoPerfilUseCase;
  final AdicionarPontosUseCase _adicionarPontosUseCase;

  AlunoController(this._buscarAdminUseCase, this._buscarAlunosUseCase,
      this._buscarFotoPerfilUseCase, this._adicionarPontosUseCase);

  Either<Exception, AdministradorEntity>? retorno;
  Either<Exception, List<AlunoEntity>>? retornoAlunos;
  Either<Exception, List<PontoEntity>>? retornoPontos;
  AdministradorEntity? administrador;
  List<AlunoEntity> alunos = [];
  Either<Exception, bool>? retornoUsuario;
  Exception? erro;
  String? pathImage;
  List<String> eventos = [];
  List<PontoEntity> pontos = [];
  bool isSaved = false;

  buscarAdminUseCase(String usuario) async {
    retorno = await _buscarAdminUseCase.buscarAdmin(usuario);
    if (retorno!.isRight) {
      administrador = retorno!.right;
    }
  }

  buscarAlunos({required String turma}) async {
    alunos.clear();
    retornoAlunos = await _buscarAlunosUseCase.buscarAlunos(turma: turma);
    if (retornoAlunos!.isRight) {
      for (var aluno in retornoAlunos!.right) {
        alunos.add(aluno);
      }
      return alunos;
    }
  }

  buscarImagemStorage(String nomeImagem) async {
    try {
      pathImage = await _buscarFotoPerfilUseCase.buscarImagemPeril(nomeImagem);
      return pathImage;
    } catch (e) {
      pathImage = null;
      return null;
    }
  }

  buscarEventos() async {
    eventos = await BuscarAlunoDataSourceImp().carregarImagensEventos();
  }

  buscarPontos(String usuario) async {
    pontos.clear();
    retornoPontos =
        await BuscarPontosDataSourceImp().buscarPontosGanhos(usuario);
    if (retornoPontos!.isRight) {
      for (var ponto in retornoPontos!.right) {
        pontos.add(ponto);
      }
      return pontos;
    }
  }

  adicionarPontos(PontoEntity ponto, String usuario) async {
    try {
      await _adicionarPontosUseCase.adicionarPontos(ponto, usuario);
      isSaved = true;
      return isSaved;
    } catch (e) {
      isSaved = false;
      return isSaved;
    }
  }
}
