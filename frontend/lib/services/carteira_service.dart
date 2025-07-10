import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/carteira.dart';

class CarteiraService {
  final String baseUrl;

  CarteiraService({required this.baseUrl});

  Future<List<Carteira>> getCarteiras() async {
    final url = Uri.parse('$baseUrl/carteiras/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Carteira.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar carteiras: ${response.statusCode}');
    }
  }
}
