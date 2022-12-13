// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '../../../domain/entities/nota_entity.dart';

class NotaListItem extends StatelessWidget {
  const NotaListItem({super.key, required this.nota, required this.materia});

  final String materia;
  final num nota;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset('images/icone_lista_nota.png', height: 70),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Materia:",
                    style: TextStyle(
                        color: Color.fromARGB(255, 71, 50, 108),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    materia,
                    style: const TextStyle(
                        fontSize: 23,
                        color: Color.fromARGB(255, 71, 50, 108),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Nota:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 71, 50, 108),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  formataNota(nota).toString(),
                  style: TextStyle(
                      fontSize: 30,
                      color: corNota(nota),
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color corNota(num nota) {
    if (nota > 7) {
      return const Color.fromARGB(255, 3, 145, 8);
    } else if (nota < 7 && nota > 4) {
      return const Color.fromARGB(255, 229, 225, 4);
    } else {
      return const Color.fromARGB(255, 255, 9, 9);
    }
  }

  formataNota(num nota) {
    if (nota == 10 || nota == 0) {
      return nota;
    } else {
      return nota.toDouble();
    }
  }
}
