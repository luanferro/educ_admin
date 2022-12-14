import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/pages/home_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/aluno_controller.dart';

class AdicionarPontosPage extends StatefulWidget {
  const AdicionarPontosPage({super.key});

  @override
  State<AdicionarPontosPage> createState() => _AdicionarPontosPageState();
}

class _AdicionarPontosPageState extends State<AdicionarPontosPage> {
  var controller = GetIt.I.get<AlunoController>();
  PontoEntity pontoEntity = PontoEntity();
  String usuario = '';
  AlunoEntity alunoSelecionado = AlunoEntity();
  String categoriaSelecionada = '';
  final formKey = GlobalKey<FormState>();
  String tipoPonto = '';
  List<String> categorias = [
    "Comportamento",
    "Frequência",
    "Prova",
    "Atividade",
    "Outros"
  ];

  @override
  void initState() {
    super.initState();

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
                  Text("Gerenciar Pontos",
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
                                width: largura * 0.8,
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(35)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Campo inválido';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLength: 9,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder.none,
                                        hintText: "Pontos",
                                        alignLabelWithHint: true,
                                        hintStyle: TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey[400]),
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onChanged: (value) => pontoEntity.pontos =
                                          int.tryParse(value)),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
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
                                        value: categoriaSelecionada.isNotEmpty
                                            ? categoriaSelecionada
                                            : null,
                                        hint: Text("Categoria"),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: categorias.map((String items) {
                                          return DropdownMenuItem(
                                              value: items, child: Text(items));
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            categoriaSelecionada = value!;
                                          });
                                          pontoEntity.categoria =
                                              categoriaSelecionada;
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: largura * 0.8,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
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
                                      pontoEntity.motivo = value),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: [
                                  Radio(
                                      activeColor: Colors.deepPurpleAccent,
                                      value: "ganho",
                                      groupValue: tipoPonto,
                                      onChanged: (value) {
                                        setState(() {
                                          tipoPonto = value!;
                                        });
                                        pontoEntity.tipo = tipoPonto;
                                      }),
                                  Text(
                                    "Adicionar",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      activeColor: Colors.deepPurpleAccent,
                                      value: "perda",
                                      groupValue: tipoPonto,
                                      onChanged: (value) {
                                        setState(() {
                                          tipoPonto = value!;
                                        });
                                        pontoEntity.tipo = tipoPonto;
                                      }),
                                  Text(
                                    "Retirar",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
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
                                      await controller.adicionarPontos(
                                          pontoEntity, usuario),
                                      if (controller.isSaved == true)
                                        {
                                          if (pontoEntity.tipo == "ganho")
                                            {
                                              exibirAlertDialog(
                                                  "Os pontos foram adicionados com sucesso",
                                                  "Salvo com sucesso!")
                                            }
                                          else
                                            {
                                              exibirAlertDialog(
                                                  "Os pontos foram retirados com sucesso",
                                                  "Salvo com sucesso!")
                                            },
                                          formKey.currentState!.reset()
                                        }
                                      else
                                        {
                                          if (pontoEntity.tipo == "ganho")
                                            {
                                              exibirAlertDialog(
                                                  "Ocorreu algum erro e não foi possivel adicionar os pontos",
                                                  "Erro ao salvar!")
                                            }
                                          else
                                            {
                                              exibirAlertDialog(
                                                  "Ocorreu algum erro e não foi possivel retirar os pontos",
                                                  "Erro ao salvar!")
                                            }
                                        },
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
