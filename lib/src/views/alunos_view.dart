import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/alunos_controller.dart';
import 'package:utilidades/src/models/alunos_model.dart';

class AlunosView extends StatefulWidget {
  const AlunosView({super.key});

  @override
  State<AlunosView> createState() => _AlunosViewState();
}

class _AlunosViewState extends State<AlunosView> {
  AlunosController _controller = AlunosController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _idade = TextEditingController();
  final TextEditingController _turma = TextEditingController();

  void _abrirDialog(AlunosModel? aluno) {
    String tituloDialog = 'Cadastrar aluno';
    String action = 'add';

    if (aluno != null) {
      _nome.text = aluno.nome;
      _idade.text = aluno.idade.toString();
      _turma.text = aluno.turma;
      tituloDialog = 'Editar aluno';
      action = 'edit';
    } else {
      _nome.clear();
      _idade.clear();
      _turma.clear();
    }
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Cadastrar aluno"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nome,
                  decoration: const InputDecoration(labelText: "Nome"),
                ),
                TextField(
                  controller: _idade,
                  decoration: const InputDecoration(labelText: "Idade"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _turma,
                  decoration: const InputDecoration(labelText: "Turma"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed:
                    () => {
                      if (_salvarAluno(action, aluno))
                        {Navigator.pop(context)}
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Erro ao salvar")),
                          ),
                        },
                    },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 20),
                    Text("Salvar"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => {Navigator.pop(context)},
                child: Icon(Icons.close),
              ),
            ],
          ),
    );
  }

  bool _salvarAluno(String action, AlunosModel? aluno) {
    final nome = _nome.text.trim();
    final idade = int.tryParse(_idade.text.trim()) ?? 0;
    final turma = _turma.text.trim();

    if (nome.isEmpty || turma.isEmpty || idade <= 0) {
      return false;
    }

    if (action == 'add') {
      _controller.adicionarAluno(
        AlunosModel(id: '', nome: nome, idade: idade, turma: turma),
      );
    } else {
      _controller.atualizarAluno(
        AlunosModel(id: aluno!.id, nome: nome, idade: idade, turma: turma),
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<List<AlunosModel>>(
          stream: _controller.getAlunos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum dado encontrado'));
            }

            final alunos = snapshot.data!;

            return ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];

                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Text(
                    'Idade: ${aluno.idade} | Turma: ${aluno.turma}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _abrirDialog,
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(onPressed: () => {}, icon: Icon(Icons.add)),
                      IconButton(
                        onPressed: () => _controller.deletarAluno(aluno.id),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
