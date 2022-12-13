import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoEntity {
  String? nome;
  String? sexo;
  String? dataNascimento;
  int? matricula;
  String? ano;
  String? turma;
  String? usuario;
  String? senha;
  int? pontos;
  String? fotoPerfil;

  AlunoEntity(
      {this.nome,
      this.sexo,
      this.dataNascimento,
      this.matricula,
      this.ano,
      this.turma,
      this.usuario,
      this.senha,
      this.pontos,
      this.fotoPerfil});

  factory AlunoEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AlunoEntity(
        nome: data?['nome'],
        sexo: data?['sexo'],
        dataNascimento: data?['data_nascimento'],
        matricula: data?['matricula'],
        ano: data?['ano'],
        turma: data?['turma'],
        usuario: data?['usuario'],
        senha: data?['senha'],
        pontos: data?['pontos'],
        fotoPerfil: data?['fotoPerfil']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nome != null) "nome": nome,
      if (sexo != null) "sexo": sexo,
      if (dataNascimento != null) "data_nascimento": dataNascimento,
      if (matricula != null) "matricula": matricula,
      if (ano != null) "ano": ano,
      if (turma != null) "turma": turma,
      if (usuario != null) "usuario": usuario,
      if (senha != null) "senha": senha,
      if (pontos != null) "pontos": pontos,
      if (fotoPerfil != null) "fotoPerfil": fotoPerfil
    };
  }
}
