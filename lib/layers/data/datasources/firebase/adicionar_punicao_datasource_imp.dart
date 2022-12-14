import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_admin/layers/data/datasources/cadastrar_punicao_datasource.dart';
import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:intl/intl.dart';

class AdicionarPunicaoDataSourceImp implements AdicionarPunicaoDataSource {
  var db = FirebaseFirestore.instance;

  @override
  Future<bool> adicionarPunicao(
      PunicaoEntity punicaoEntity, String usuario, String professor) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd - kk:mm:ss').format(now);

      final punicao = <String, dynamic>{
        "nivel": punicaoEntity.nivel,
        "motivo": punicaoEntity.motivo,
        "data": formattedDate,
        "professor": professor
      };

      await db
          .collection("alunos")
          .doc(usuario)
          .collection("punicoes")
          .doc(formattedDate)
          .set(punicao);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> removerPunicao(
      PunicaoEntity punicaoEntity, String usuario) async {
    final collection = FirebaseFirestore.instance.collection('alunos');
    collection
        .doc(usuario)
        .collection("punicoes")
        .doc(punicaoEntity.data) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .catchError((error) => print('Delete failed: $error'));
  }
}
