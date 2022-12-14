import 'package:educ_admin/layers/domain/entities/ponto_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../controllers/aluno_controller.dart';
import '../../controllers/usuario_controller.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var elo = "";
  var colorRanking = Colors.transparent;
  XFile? imagem;
  XFile? imagemTemporaria;
  String pathImage = '';
  final ImagePicker _picker = ImagePicker();

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
  }

  @override
  Widget build(BuildContext context) {
    controllerUsuario.buscarUsuarioLogado();
    controller.buscarAdminUseCase(controllerUsuario.usuario ?? '');
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          Container(
            height: altura / 4,
            color: Colors.deepPurpleAccent,
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: altura * 0.7,
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
                          height: 70,
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
                                        Text(
                                          controller.administrador?.nome ?? '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
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
                                              "Cargo:",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: largura * 0.51,
                                            ),
                                            Text(
                                              controller.administrador?.cargo ??
                                                  '',
                                              style: TextStyle(
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
                                              "Punições Dadas:",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              pegarQntdPunicoes(),
                                              style: TextStyle(
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
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: altura * 0.14),
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              // ignore: sort_child_properties_last
              child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 55,
                      backgroundImage: (controller.pathImage != null)
                          ? NetworkImage(controller.pathImage ?? '')
                              as ImageProvider
                          : const AssetImage('images/semfoto.png'))),
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () {
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
                                pegarImagemGaleria();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Galeria")),
                          TextButton(
                              onPressed: () {
                                pegarImagemCamera();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Câmera"))
                        ],
                        title: const Text(
                            textAlign: TextAlign.center, "Selecionar Imagem"),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  void pegarImagemGaleria() async {
    imagemTemporaria = await _picker.pickImage(source: ImageSource.gallery);
    imagem = imagemTemporaria;
    //await CadastroAlunoDataSourceImp()
    //   .salvarImagemPerfil(controller.aluno?.usuario ?? '', imagem!.path);
    _reloadFotoPerfil();
  }

  void pegarImagemCamera() async {
    imagemTemporaria = await _picker.pickImage(source: ImageSource.camera);
    imagem = imagemTemporaria;
    // await CadastroAlunoDataSourceImp()
    //   .salvarImagemPerfil(controller.aluno?.usuario ?? '', imagem!.path);
    _reloadFotoPerfil();
  }

  void _reloadFotoPerfil() async {
    await controller
        .buscarAdminUseCase(controller.administrador?.usuario ?? '');
    var newPath = await Future.delayed(
        const Duration(seconds: 0),
        () => controller
            .buscarImagemStorage(controller.administrador?.fotoPerfil ?? ''));
    if (this.mounted) {
      setState(() {
        controller.pathImage = newPath;
      });
    }
  }

  String pegarQntdPunicoes() {
    int punicoesDadas = 0;

    for (var punicoes in controller.punicoes) {
      if (punicoes.professor == controllerUsuario.usuario) {
        punicoesDadas += 1;
      }
    }

    return punicoesDadas.toString();
  }
}
