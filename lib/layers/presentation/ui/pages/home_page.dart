import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/ui/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../controllers/usuario_controller.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var elo = "";
  var colorRanking = Colors.transparent;
  XFile? imagem;
  XFile? imagemTemporaria;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    if (controller.administrador?.nome == null) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StartPage()));
      });
    }
    _reloadFotoPerfil();
  }

  @override
  Widget build(BuildContext context) {
    controllerUsuario.buscarUsuarioLogado();
    controller.buscarAdminUseCase(controllerUsuario.usuario ?? '');
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: altura,
        width: largura,
        child: FutureBuilder(
          future: buscarNome(),
          builder: ((context, snapshot) {
            if (snapshot.hasData && snapshot.data != '') {
              return Stack(
                children: <Widget>[
                  Container(
                    height: altura / 4,
                    color: Colors.transparent,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          )),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: altura * 0.2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: ((() async {
                                      controllerUsuario.deslogarUsuario();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()),
                                      );
                                    })),
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    )),
                                const Padding(
                                    padding: EdgeInsets.only(
                                  left: 15,
                                ))
                              ],
                            ),
                            SizedBox(
                              height: altura * 0.03,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    // ignore: sort_child_properties_last
                                    child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                            radius: 32,
                                            backgroundImage:
                                                (controller.pathImage != null)
                                                    ? NetworkImage(
                                                        controller.pathImage ??
                                                            '') as ImageProvider
                                                    : const AssetImage(
                                                        'images/semfoto.png'))),
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder()),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      pegarImagemGaleria();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text("Galeria")),
                                                TextButton(
                                                    onPressed: () {
                                                      pegarImagemCamera();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Câmera"))
                                              ],
                                              title: const Text(
                                                  textAlign: TextAlign.center,
                                                  "Selecionar Imagem"),
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(
                                    width: largura * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(controller.administrador?.nome ?? '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 9),
                        height: altura * 0.07,
                        width: largura * 0.8,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${(controller.administrador?.cargo ?? '')} - Supervisor",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: altura * 0.06,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: largura,
                            height: altura * 0.23,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: largura * 0.39,
                                  margin: const EdgeInsets.only(right: 15),
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3))
                                        ],
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "images/gerenciar_eventos.png",
                                          scale: 2,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Gerenciar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text("Eventos",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: largura * 0.39,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3))
                                        ],
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "images/gerenciar_desafios.png",
                                          scale: 2,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Gerenciar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text("Metas",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: largura,
                            height: altura * 0.23,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: largura * 0.39,
                                  margin: const EdgeInsets.only(right: 15),
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3))
                                        ],
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "images/gerenciar_metas.png",
                                          scale: 2,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Gerenciar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text("Desafios",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: largura * 0.39,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3))
                                        ],
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "images/gerenciar_notas.png",
                                          scale: 2,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Gerenciar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text("Notas",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.deepPurpleAccent,
                  size: 50,
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<String> buscarNome() {
    String nome;
    nome = controller.administrador?.nome ?? '';
    var futureNome = Future.value(nome);
    return futureNome;
  }

  void pegarImagemGaleria() async {
    imagemTemporaria = await _picker.pickImage(source: ImageSource.gallery);
    imagem = imagemTemporaria;
    //await CadastroAlunoDataSourceImp()
    //  .salvarImagemPerfil(controller.aluno?.usuario ?? '', imagem!.path);
    _reloadFotoPerfil();
  }

  void pegarImagemCamera() async {
    imagemTemporaria = await _picker.pickImage(source: ImageSource.camera);
    imagem = imagemTemporaria;
    //await CadastroAlunoDataSourceImp()
    //  .salvarImagemPerfil(controller.aluno?.usuario ?? '', imagem!.path);
    _reloadFotoPerfil();
  }

  void _reloadFotoPerfil() async {
    await controller
        .buscarAdminUseCase(controller.administrador?.usuario ?? '');
    var newPath = await Future.delayed(
        const Duration(seconds: 0),
        () => controller
            .buscarImagemStorage(controller.administrador?.fotoPerfil ?? ''));
    if (mounted) {
      setState(() {
        controller.pathImage = newPath;
      });
    }
  }
}
