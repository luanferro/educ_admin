import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/widgets/nota_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/nota_controller.dart';

class NotaPage extends StatefulWidget {
  const NotaPage({super.key});

  @override
  State<NotaPage> createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var controllerNota = GetIt.I.get<NotaController>();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: altura * 0.22,
          flexibleSpace: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Pesquisar Aluno",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container());
  }

  exibirLista(int bimestre) {
    if (bimestre == 1) {
      if (controllerNota.notas1bim.isNotEmpty) {
        return montaLista(controllerNota.notas1bim);
      } else {
        return painelListaVazia();
      }
    } else if (bimestre == 2) {
      if (controllerNota.notas2bim.isNotEmpty) {
        return montaLista(controllerNota.notas2bim);
      } else {
        return painelListaVazia();
      }
    } else if (bimestre == 3) {
      if (controllerNota.notas3bim.isNotEmpty) {
        return montaLista(controllerNota.notas3bim);
      } else {
        return painelListaVazia();
      }
    } else {
      if (controllerNota.notas4bim.isNotEmpty) {
        return montaLista(controllerNota.notas4bim);
      } else {
        return painelListaVazia();
      }
    }
  }

  montaLista(List lista) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (var nota in lista)
          NotaListItem(
            materia: nota.materia,
            nota: nota.nota,
          )
      ],
    );
  }

  painelListaVazia() {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: Text(
          "Dados do bimestre não encontrados",
          style: TextStyle(
              color: Color.fromARGB(255, 71, 50, 108),
              fontSize: 25,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
