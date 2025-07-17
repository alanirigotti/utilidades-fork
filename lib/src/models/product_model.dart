class ProductModel {
  final int? id;
  final String nome;
  final double preco;
  final String descricao;

  ProductModel({
    this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
  });

  // Factory trata os dados da API
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      nome: json['nome'],
      preco:
          double.tryParse(json['preco'].toString()) ??
          0.0, // vem string do json, entao deve ser feito a conversão
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'preco': preco, 'descricao': descricao};
  }
}
