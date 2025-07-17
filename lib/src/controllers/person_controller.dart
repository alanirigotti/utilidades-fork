import 'package:flutter/material.dart';
import 'package:utilidades/src/models/person_model.dart';

class PersonController extends ChangeNotifier {
  List<PersonModel> get persons => List.unmodifiable(_persons);

  Future<void> loadPersons() async {
    _persons.clear();
    _persons.addAll(await _db.getAllPersons());
    notifyListeners();
  }

  Future<void> addPerson(String nome, int idade) async {
    final person = PersonModel(id: id, idade: idade);
    await _db.insertPerson(person);
    await loadPersons();
  }

  Future<void> deletePerson(int id) async {}
}
