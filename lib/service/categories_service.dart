import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/categories_model.dart';



class CategroyService {
  List<Data> categroyList = [];
  var Url = "https://loopstech.com/rest/v1/categories.php";
  Future<List<Data>> fetchCategroy() async {
    try {
      final response = await http.get(Uri.parse(Url),
      );
      var responseData = categoryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        categroyList = responseData.data!;
        return categroyList;
      }
    } catch (e) {
      log(e.toString());
    }
    return categroyList;
  }
}
