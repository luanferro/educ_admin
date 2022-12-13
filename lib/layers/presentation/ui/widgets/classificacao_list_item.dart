import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class ClassificacaoListItem extends StatelessWidget {
  ClassificacaoListItem(
      {super.key, required this.aluno, required this.posicao});

  final AlunoEntity aluno;
  final int posicao;
  var controller = GetIt.I.get<AlunoController>();

  var colorRanking = const Color.fromRGBO(0, 0, 0, 0);
  var colorBorder = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                    height: 25,
                    width: 25,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
                Container(
                  margin: marginIndex(posicao),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      posicao.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aluno.nome.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 71, 50, 108),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Icon(
              Icons.menu_book,
              color: corRanking(aluno.pontos!),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  Text(
                    aluno.pontos.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  corRanking(int pontos) {
    if (pontos < 400) {
      colorRanking = Colors.brown;
    } else if (pontos > 400 && pontos < 899) {
      colorRanking = Colors.grey;
    } else if (pontos > 900 && pontos < 1399) {
      colorRanking = const Color.fromRGBO(251, 192, 45, 1);
    } else if (pontos > 1400 && pontos < 1999) {
      colorRanking = const Color.fromRGBO(0, 200, 83, 1);
    } else if (pontos > 2000 && pontos < 2499) {
      colorRanking = const Color.fromRGBO(2, 119, 189, 1);
    } else if (pontos > 2500 && pontos < 2999) {
      colorRanking = const Color.fromRGBO(224, 64, 251, 1);
    } else {
      colorRanking = const Color.fromRGBO(183, 28, 28, 1);
    }
    return colorRanking;
  }

  marginIndex(int index) {
    if (index < 10) {
      return const EdgeInsets.only(left: 3);
    }
  }
}
