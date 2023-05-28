import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_sepatu_3/models/category_model.dart';
import 'package:toko_sepatu_3/models/product_model.dart';

class CategoryService {
  String baseUrl = 'http://192.168.43.6/api';

  Future<List<CategoryModel>> getCategories() async {
    var url = '$baseUrl/categories';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> categories = [];

      for (var item in data) {
        categories.add(CategoryModel.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('gagal Get Categories');
    }
  }

  Future<List<ProductModel>> getCategoriesId(int id) async {
    var url = '$baseUrl/categories?id=$id';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['products'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
    } else {
      throw Exception('gagal Get Categories');
    }
  }
}
