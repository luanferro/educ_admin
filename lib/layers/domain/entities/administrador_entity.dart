import 'package:cloud_firestore/cloud_firestore.dart';

class AdministradorEntity {
  String? nome;
  String? cargo;
  String? fotoPerfil;
  String? usuario;

  AdministradorEntity({this.cargo, this.nome, this.fotoPerfil, this.usuario});

  factory AdministradorEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AdministradorEntity(
        nome: data?['nome'],
        cargo: data?['cargo'],
        usuario: data?['usuario'],
        fotoPerfil: data?['fotoPerfil']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nome != null) "nome": nome,
      if (cargo != null) "cargo": cargo,
      if (usuario != null) "usuario": usuario,
      if (fotoPerfil != null) "fotoPerfil": fotoPerfil
    };
  }
}
