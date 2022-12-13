import 'package:educ_admin/layers/presentation/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class AdicionarPunicoesPage extends StatelessWidget {
  const AdicionarPunicoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Container(color: Colors.amber)),
    );
  }
}
