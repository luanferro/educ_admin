import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/nota_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/pages/adicionar_pontos_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/adicionar_punicoes_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/classificacao_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/home_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/alunos_page.dart';
import 'package:educ_admin/layers/presentation/ui/pages/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var controllerNota = GetIt.I.get<NotaController>();
  final pageViewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _reloadFotoPerfil();
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        allowImplicitScrolling: true,
        controller: pageViewController,
        children: const [
          HomePage(),
          PerfilPage(),
          ClassificacaoPage(),
          AlunosPage()
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: Container(
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdicionarPontosPage()),
                                    );
                                  },
                                  child: Text("Pontos")),
                            ),
                            Container(
                              width: 200,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdicionarPunicoesPage()),
                                    );
                                  },
                                  child: Text("Puni????es")),
                            ),
                          ],
                        ),
                      ));
                });
          },
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              currentIndex: pageViewController.page?.round() ?? 0,
              onTap: (index) {
                pageViewController.jumpToPage(index);
                if (index == 0) {
                  setState(() {});
                }
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepPurpleAccent,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: 'Classifica????o',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Alunos',
                ),
              ],
            );
          }),
    );
  }

  void _reloadFotoPerfil() async {
    await controller
        .buscarAdminUseCase(controller.administrador?.usuario ?? '');
    var newPath = await Future.delayed(
        const Duration(seconds: 0),
        () => controller
            .buscarImagemStorage(controller.administrador?.fotoPerfil ?? ''));
    setState(() {
      controller.pathImage = newPath;
    });
  }
}
