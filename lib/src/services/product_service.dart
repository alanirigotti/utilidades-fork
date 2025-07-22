import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utilidades/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:utilidades/src/services/auth_service.dart';
import 'dart:convert';

class ProductService {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_auth');
  }

  Future<List<ProductModel>> getAll(BuildContext context) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Authorization': 'Baerer $token'},
    );

    //validar a resposta
    if (response.statusCode == 401) {
      // se ele n ta logado, entao o app deve leva-lo a tela de login
      await AuthService().logout();

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      throw Exception("Usuário não autorizado. Feche o app e abra novamente.");
    } else if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar produtos");
    }
  }

  Future<void> create(ProductModel produto) async {
    final token = await _getToken();

    await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {
        'Authorization': 'Baerer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(produto.toJson()),
    );
  }

  Future<void> update(ProductModel produto) async {
    final token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/produtos/${produto.id}'),
      headers: {
        'Authorization': 'Baerer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(produto.toJson()),
    );
  }

  Future<void> delete(int id) async {
    final token = await _getToken();

    await http.delete(
      Uri.parse('$baseUrl/produtos/$id'),
      headers: {'Authorization': 'Baerer $token'},
    );
  }
}
