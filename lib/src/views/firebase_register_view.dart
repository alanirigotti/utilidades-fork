import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/usuario_controller.dart';

class FirebaseRegisterView extends StatefulWidget {
  const FirebaseRegisterView({super.key});

  @override
  State<FirebaseRegisterView> createState() => _FirebaseRegisterViewState();
}

class _FirebaseRegisterViewState extends State<FirebaseRegisterView> {
  bool _loading = false;
  String? _erro;
  final _formKey = GlobalKey<FormState>();
  final UsuarioController _controller = UsuarioController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _erro = null;
      });

      final usuario = await _controller.cadastrar(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
      );

      setState(() {
        _loading = false;
      });

      if (usuario != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso')),
        );
        Navigator.pop(context);
      } else {
        setState(() {
          _erro = "Erro ao cadastrar o usuário";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro firebase')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_erro != null) ...[
                Text(_erro!, style: const TextStyle(color: Colors.red)),
                SizedBox(height: 20),
              ],
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe seu nome'
                            : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe seu e-mail'
                            : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                validator:
                    (value) =>
                        value == null || value.length < 6
                            ? 'Senha inválida'
                            : null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: () => _cadastrar,
                    child: Text('Cadastrar'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
