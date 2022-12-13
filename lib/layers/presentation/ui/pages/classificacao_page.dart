import 'package:educ_admin/layers/presentation/ui/widgets/classificacao_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/aluno_controller.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  var controller = GetIt.I.get<AlunoController>();
  var colorGeral = const Color.fromRGBO(255, 255, 255, 1);
  var colorTurma = const Color.fromARGB(255, 124, 77, 255);
  var colorTextGeral = Colors.black;
  var colorTextTurma = Colors.white;
  var elo = "";
  var colorRanking = Colors.transparent;

  @override
  void initState() {
    super.initState();

    _reloadList();
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          Container(
            height: altura / 3,
            color: Colors.deepPurpleAccent,
          ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ranking Alunos",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: altura * 0.7,
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              width: largura,
                              color: Colors.white,
                              child: exibirLista(context)),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  exibirLista(BuildContext context) {
    if (controller.alunos.isNotEmpty) {
      return montaLista(controller.alunos, context);
    } else {
      return const Center(
        child: Text("Sem dados"),
      );
    }
  }

  Widget montaLista(List lista, BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, int index) {
          return ClassificacaoListItem(
            aluno: lista[index],
            posicao: lista.indexOf(lista[index]) + 1,
          );
        },
        itemCount: lista.length);
  }

  Future<void> _reloadList() async {
    // ignore: prefer_typing_uninitialized_variables
    var newList;
    controller.alunos.clear();
    newList = await Future.delayed(
        const Duration(seconds: 0), () => controller.buscarAlunos(turma: ""));
    setState(() {
      controller.alunos = newList;
    });
  }
}
