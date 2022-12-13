import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UsuarioRepository {
  Future<Either<Exception, UserCredential>> logar(String usuario, String senha);
  String buscarUsuarioLogado();
}
