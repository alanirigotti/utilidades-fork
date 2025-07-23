import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utilidades/src/models/alunos_model.dart';

class AlunosController {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'alunos',
  );

  Future<void> adicionarAluno(AlunosModel aluno) {
    return _collection.add(aluno.toMap());
  }

  Future<void> atualizarAluno(AlunosModel aluno) {
    return _collection.doc(aluno.id).update(aluno.toMap());
  }
}
