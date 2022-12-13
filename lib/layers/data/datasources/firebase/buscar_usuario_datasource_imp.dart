import 'package:educ_admin/layers/data/datasources/buscar_usuario_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuscarUsuarioDataSourceImp implements BuscarUsuarioDataSource {
  @override
  String buscarUsuarioLogado() {
    try {
      String emailFirebase = FirebaseAuth.instance.currentUser?.email ?? '';
      int tamanhoEmail = emailFirebase.length;
      String complemento = '@educadmin.com';
      int tamanhoComplemento = complemento.length;
      int tamanhoUsuario = tamanhoEmail - tamanhoComplemento;
      String usuario = emailFirebase.substring(0, tamanhoUsuario);
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }
}
