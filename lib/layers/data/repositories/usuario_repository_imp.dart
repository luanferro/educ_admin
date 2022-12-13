import 'package:educ_admin/layers/data/datasources/buscar_usuario_datasource.dart';
import 'package:educ_admin/layers/data/datasources/login_datasource.dart';
import 'package:either_dart/either.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImp implements UsuarioRepository {
  final LoginDataSource _loginDataSource;
  final BuscarUsuarioDataSource _buscarUsuarioDataSource;

  UsuarioRepositoryImp(this._loginDataSource, this._buscarUsuarioDataSource);

  @override
  Future<Either<Exception, UserCredential>> logar(
      String usuario, String senha) {
    return _loginDataSource.logar(usuario, senha);
  }

  @override
  String buscarUsuarioLogado() {
    return _buscarUsuarioDataSource.buscarUsuarioLogado();
  }
}
