import 'package:educ_admin/layers/domain/usecases/login/login_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/buscar_usuario/buscar_usuario_usecase.dart';

class UsuarioController {
  final LoginUseCase _loginUseCase;
  final BuscarUsuarioUseCase _buscarUsuarioUseCase;

  String? usuario;
  String? senha;
  Either<Exception, UserCredential>? retorno;
  bool? isLogado;

  UsuarioController(this._loginUseCase, this._buscarUsuarioUseCase);

  logarUseCase(String usuario, String senha) async {
    retorno = await _loginUseCase.logar(usuario, senha);
    if (retorno!.isRight && retorno?.right != null) {
      isLogado = true;
    } else {
      isLogado = false;
    }
  }

  buscarUsuarioLogado() {
    usuario = _buscarUsuarioUseCase.buscarUsuarioLogado();
  }

  deslogarUsuario() {
    usuario = "";
    senha = "";
    FirebaseAuth.instance.signOut();
  }
}
