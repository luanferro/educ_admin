import 'package:educ_admin/layers/domain/repositories/usuario_repository.dart';
import 'package:educ_admin/layers/domain/usecases/login/login_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCaseImp implements LoginUseCase {
  final UsuarioRepository _usuarioRepository;

  LoginUseCaseImp(this._usuarioRepository);

  @override
  Future<Either<Exception, UserCredential>> logar(
      String usuario, String senha) async {
    return await _usuarioRepository.logar(usuario, senha);
  }
}
