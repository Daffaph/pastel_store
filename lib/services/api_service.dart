import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  // Ambil SEMUA produk (limit=0 berarti tanpa batas)
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl?limit=0'));
    return _parse(response);
  }

  // Cari produk berdasarkan kata kunci
  static Future<List<Product>> searchProducts(String query) async {
    final q = Uri.encodeQueryComponent(query);
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$q&limit=0'));
    return _parse(response);
  }

  static List<Product> _parse(http.Response response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['products'];
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }
  }
}
