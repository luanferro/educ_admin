import 'package:educ_admin/layers/domain/entities/aluno_entity.dart';
import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:educ_admin/layers/presentation/ui/widgets/aluno_list_item.dart';
import 'package:educ_admin/layers/presentation/ui/widgets/nota_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/nota_controller.dart';

class AlunosPage extends StatefulWidget {
  const AlunosPage({super.key});

  @override
  State<AlunosPage> createState() => _AlunosPageState();
}

class _AlunosPageState extends State<AlunosPage> {
  var controller = GetIt.I.get<AlunoController>();
  var controllerUsuario = GetIt.I.get<UsuarioController>();
  var controllerNota = GetIt.I.get<NotaController>();
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _punicoesQuery = TextEditingController();
  bool _isSearching = false;
  String _searchText = "";

  _AlunosPageState() {
    _punicoesQuery.addListener(() {
      if (_punicoesQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _punicoesQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: altura * 0.22,
        flexibleSpace: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Pesquisar Aluno",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _punicoesQuery,
                  onChanged: ((value) {
                    if (value != "") {
                      _handleSearchStart();
                    } else {
                      _handleSearchEnd();
                    }
                  }),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    hintText: "Pesquisar...",
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey[400]),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: altura / 1.5,
              child: (_isSearching)
                  ? ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      children: _buildSearchList(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  List<AlunoListItem> _buildList() {
    return controller.alunos
        .map((contact) => AlunoListItem(aluno: AlunoEntity()))
        .toList();
  }

  List<AlunoListItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return controller.alunos
          .map((contact) => AlunoListItem(aluno: contact))
          .toList();
    } else {
      List<AlunoEntity> searchList = [];
      for (int i = 0; i < controller.alunos.length; i++) {
        AlunoEntity aluno = controller.alunos.elementAt(i);
        if (aluno.nome!.toLowerCase().contains(_searchText.toLowerCase()) ||
            aluno.matricula!
                .toString()
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
          searchList.add(aluno);
        }
      }
      return searchList
          .map((contact) => AlunoListItem(
                aluno: contact,
              ))
          .toList();
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _punicoesQuery.clear();
    });
  }
}
