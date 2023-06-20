import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:loop_project/Model/product_model.dart';




class ProductService {
  List<Data> productList = [];

  var Url = "https://loopstech.com/rest/v1/products.php?cat_id=56";
  Future<List<Data>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(Url),
      );
      var responseData = ProductModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(response.body);
        productList = responseData.data!;
        print(productList.length);
        print("ccccccccccccccccccccccccccccccc");
        return productList;
      }
    } catch (e) {
      log(e.toString());
    }
    return productList;
  }
}
