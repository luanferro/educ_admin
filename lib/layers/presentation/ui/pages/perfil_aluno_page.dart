import 'package:educ_admin/layers/data/datasources/firebase/adicionar_punicao_datasource_imp.dart';
import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:educ_admin/layers/domain/entities/punicao_entity.dart';
import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/pages/alunos_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/start_page.dart';
import 'package:educ_admin/layers/presentation/ui/widgets/aluno_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pie_chart/pie_chart.dart';

class PerfilAlunoPage extends StatefulWidget {
  AlunoEntity alunoEntity;
  PerfilAlunoPage({super.key, required this.alunoEntity});

  @override
  State<PerfilAlunoPage> createState() => _PerfilAlunoPageState();
}

class _PerfilAlunoPageState extends State<PerfilAlunoPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var elo = "";
  var colorRanking = Colors.transparent;
  String pathImage = '';
  bool editarPunicao = false;
  Widget iconeEditar = Icon(Icons.mode_edit);

  List<Color> colorList = [
    const Color.fromRGBO(244, 67, 54, 0.6),
    const Color.fromRGBO(66, 165, 245, 0.6),
    const Color.fromRGBO(255, 238, 88, 0.6),
    const Color.fromRGBO(102, 187, 106, 0.6),
    const Color.fromRGBO(171, 71, 188, 0.6)
  ];

  @override
  void initState() {
    super.initState();
    _reloadFotoPerfil();
    controller.buscarPontos(widget.alunoEntity.usuario ?? '');
    controller.buscarPunicoes(widget.alunoEntity.usuario ?? '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;
    Map<String, double> dataMap = {
      "Frequência": double.parse(calcularPorcentagemCategoria('frequencia')),
      "Prova": double.parse(calcularPorcentagemCategoria('prova')),
      "Atividade": double.parse(calcularPorcentagemCategoria('atividade')),
      "Comportamento":
          double.parse(calcularPorcentagemCategoria('comportamento')),
      "Outros": double.parse(calcularPorcentagemCategoria('outros'))
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 20, left: 10),
            child: Row(
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
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: altura * 0.83,
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "",
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Nome:",
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize: 12),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 18),
                                          child: Text(
                                            widget.alunoEntity.nome ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Matricula:",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: largura * 0.51,
                                            ),
                                            Text(
                                              widget.alunoEntity.matricula
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "turma:",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              widget.alunoEntity.turma ?? '',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              dataMap: dataMap,
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              chartLegendSpacing: 60,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 6,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 32),
                                  child: Text(
                                    "Punições:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 22),
                                  child: IconButton(
                                      onPressed: () {
                                        (editarPunicao)
                                            ? setState(() {
                                                editarPunicao = false;
                                              })
                                            : setState(() {
                                                editarPunicao = true;
                                              });
                                      },
                                      icon: (editarPunicao)
                                          ? Icon(Icons.close)
                                          : Icon(Icons.mode_edit)),
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                height: altura * 0.35,
                                width: largura,
                                child: exibirLista(
                                  context,
                                ))
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: altura * 0.09),
            alignment: Alignment.topCenter,
            child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    radius: 55,
                    backgroundImage: (controller.pathImage != null)
                        ? NetworkImage(controller.pathImage ?? '')
                            as ImageProvider
                        : const AssetImage('images/semfoto.png'))),
          ),
        ],
      ),
    );
  }

  exibirLista(BuildContext context) {
    if (controller.alunos.isNotEmpty) {
      return montaLista(controller.punicoes, context);
    } else {
      return const Center(
        child: Text("Sem dados"),
      );
    }
  }

  Widget montaLista(List lista, BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"))
                        ],
                        title: Text("Punição"),
                        content: Text(lista[index].motivo!));
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: GestureDetector(
                onLongPress: (() {}),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: (editarPunicao)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Motivo:",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (lista[index].motivo!.length > 30)
                                  ? lista[index].motivo!.substring(0, 30) +
                                      "..."
                                  : lista[index].motivo!,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 71, 50, 108),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Pontos perdidos:",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              calcularPontosPerdidos(lista[index].nivel!),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 71, 50, 108),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      (editarPunicao)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  AdicionarPunicaoDataSourceImp()
                                      .removerPunicao(
                                          lista[index], "avaliador");
                                  lista.remove(lista[index]);
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: lista.length);
  }

  void _reloadFotoPerfil() async {
    var newPath = await Future.delayed(
        const Duration(seconds: 0),
        () => controller
            .buscarImagemStorage(widget.alunoEntity.fotoPerfil ?? ''));
    setState(() {
      controller.pathImage = newPath;
    });
  }

  calcularPorcentagemCategoria(String categoria) {
    List<PontoEntity> listaPontosCategoria = [];
    num pontosTotal = 0;
    num pontosCategoria = 0;

    for (var ponto in controller.pontos) {
      if (ponto.categoria == categoria) {
        listaPontosCategoria.add(ponto);
      }
      if (ponto.tipo == 'ganho') {
        pontosTotal += ponto.pontos!;
      } else if (ponto.tipo == 'perda') {
        pontosTotal -= ponto.pontos!;
      }
    }

    for (var ponto in listaPontosCategoria) {
      pontosCategoria += ponto.pontos!;
    }

    num porcentagem = (pontosCategoria * 100) / pontosTotal;
    return porcentagem.toStringAsFixed(1);
  }

  calcularPontosPerdidos(num nivel) {
    String texto = '';
    switch (nivel) {
      case 1:
        texto = '0';
        break;
      case 2:
        texto = '20';
        break;
      case 3:
        texto = '30';
        break;
      case 4:
        texto = '40';
        break;
      case 5:
        texto = '50';
        break;
      default:
        texto = '0';
    }
    return texto;
  }
}
