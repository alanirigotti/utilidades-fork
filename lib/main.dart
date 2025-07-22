import 'package:flutter/material.dart';
import 'package:utilidades/firebase_options.dart';
import 'package:utilidades/src/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

// a aplicaçao vai aguardar a inicialização do fireabse pd dps conectar no app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AppWidget());
}

  /** riverpod - é um gerenciador de estado flexível e poderoso.
    usa provider para controlar e gerenciar os estados da aplicação. 
    
    é uma biblioteca de gerenciamento de estado desenvolvida por Remi Rousselet (criador do provider).
    ele foi criado para corrigir limitações do provider e oferecer uma abordagem mais robusta, segura e flexível.
    
    vantagens
    - seguro em tempo de compilação: detecta erros mais cedo
    - nao depende do buildcontext 
    - testavel e mdular
    - suporte nativo para providers assicronos como FutureProvider e StreamProvider 

    para usar precisamos instalar o pacote flutter_riverpod

    ----------------------

    BloC - Bussines Logic Componente
    é um padrão de arquitetura que separa a lógica de negócios da interface
    de usuário usando streams. Pode utilizar com a arquitetura MVC.
    ele foi criado pelo google para facilitar o reuso de logica em varias widgets.

    vantagens 
    - muito usado em apps corporativos
    - força em uma arquitetura bem definida
    - baseado em streams

    conceitos principais 
    - event: entrada enviada pelo usuario
    - state: saida do bloco
    - bloc: recebe eventos e emite estados 

    para usar precisamos instalar o pacote flutter_bloc

    cubit é uma versão mais simples e direto do bloc, sem eventos, voce apenas
    chama metodos e emite estados diretamente
   */

   /* class myApp extends StatelessWidget {
    @override
    Widget build (Buildcontext context) {
      return MaterialApp(
        home: BlocProvider(
          create: (_) => CounterCubit(),
          child: CounterPage(),
        ),
      );
    }
   } */
   



