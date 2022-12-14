import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/pages/home_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/aluno_controller.dart';

class AdicionarPunicoesPage extends StatefulWidget {
  const AdicionarPunicoesPage({super.key});

  @override
  State<AdicionarPunicoesPage> createState() => _AdicionarPunicoesPageState();
}

class _AdicionarPunicoesPageState extends State<AdicionarPunicoesPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  PunicaoEntity punicaoEntity = PunicaoEntity();
  String usuario = '';
  AlunoEntity alunoSelecionado = AlunoEntity();
  int nivelSelecionado = 0;
  final formKey = GlobalKey<FormState>();
  bool confirmacaoSuspensao = false;
  List<int> niveis = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    confirmacaoSuspensao = false;
    controllerUsuario.buscarUsuarioLogado();
    _reloadAlunos();
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          Container(
            height: altura / 3,
            color: Colors.deepPurpleAccent,
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: ((() async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()),
                        );
                      })),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  const Padding(
                      padding: EdgeInsets.only(
                    left: 15,
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Adicionar Punições",
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
                  height: altura * 0.75,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: largura * 0.56,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(35)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        value: alunoSelecionado.usuario,
                                        hint: Text("Selecione um aluno"),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: controller.alunos
                                            .map<DropdownMenuItem<String>>(
                                                (AlunoEntity alunoEntity) {
                                          return DropdownMenuItem(
                                              value: alunoEntity.usuario,
                                              child: Text(alunoEntity.nome!));
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            alunoSelecionado = controller.alunos
                                                .firstWhere((element) =>
                                                    element.usuario == value);
                                          });
                                          usuario = alunoSelecionado.usuario!;
                                        }),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(35)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: (nivelSelecionado != 0)
                                            ? nivelSelecionado
                                            : null,
                                        hint: Text("Nível"),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: niveis.map((int items) {
                                          return DropdownMenuItem(
                                              value: items,
                                              child: Text(items.toString()));
                                        }).toList(),
                                        onChanged: (int? value) {
                                          setState(() {
                                            nivelSelecionado = value!;
                                          });
                                          punicaoEntity.nivel =
                                              nivelSelecionado;
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: largura * 0.8,
                            constraints:
                                BoxConstraints(maxHeight: altura * 0.2),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                  maxLines: null,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo inválido';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Motivo",
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.grey[400]),
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                  ),
                                  onChanged: (value) =>
                                      punicaoEntity.motivo = value),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ((punicaoEntity.nivel ?? 0) == 5)
                              ? Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          activeColor: Colors.deepPurpleAccent,
                                          value: confirmacaoSuspensao,
                                          onChanged: (value) {
                                            setState(() {
                                              confirmacaoSuspensao = value!;
                                            });
                                          }),
                                      SizedBox(
                                        width: largura * 0.8,
                                        child: Text(
                                          "Estou ciente que este nivel de punição irá aplicar uma suspensão ao aluno.",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 48,
                            width: 309,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: ElevatedButton(
                                onPressed: () async => {
                                      if (!formKey.currentState!.validate())
                                        {
                                          await Future.delayed(
                                              const Duration(seconds: 2)),
                                          formKey.currentState?.reset(),
                                        },
                                      if (punicaoEntity.nivel == 5 &&
                                          confirmacaoSuspensao == false)
                                        {
                                          exibirAlertDialog(
                                              "Por favor, selecione a caixa de confirmação para registrar a punição",
                                              "Erro ao registrar punição!")
                                        }
                                      else
                                        {
                                          confirmacaoSuspensao = false,
                                          await controller.adicionarPunicao(
                                              punicaoEntity,
                                              usuario,
                                              controllerUsuario.usuario!),
                                          if (controller.punicaoIsSaved == true)
                                            {
                                              exibirAlertDialog(
                                                  "A punição foi registrada com sucesso.",
                                                  "Sucesso!"),
                                              formKey.currentState!.reset()
                                            }
                                          else
                                            {
                                              exibirAlertDialog(
                                                  "Ocorreu algum erro e não foi possivel registrar o punição. Tente novamente!",
                                                  "Erro ao registrar!")
                                            }
                                        }
                                    },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                ),
                                child: const Text("CONFIRMAR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  exibirAlertDialog(String texto, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
              title: Text(title),
              content: Text(texto));
        });
  }

  _reloadAlunos() async {
    await controller.buscarAlunos(turma: "");
    setState(() {});
  }
}
