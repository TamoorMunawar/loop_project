import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:loop_project/Model/product_model.dart';
import '../service/product_service.dart';


@immutable
abstract class ProductState {}

class PInitialState extends ProductState {}

class PLoadingState extends ProductState {}

class PLoadedState extends ProductState {
  final List<Data> product;

  PLoadedState({required this.product});
}

class PErrorState extends ProductState {
  final String message;

  PErrorState({required this.message});
}



class ProductNotifier extends StateNotifier<ProductState> {
  final http.Client httpClient;
  ProductNotifier({required this.httpClient})  : super(PInitialState());
  final ProductService _httpService = ProductService();

  getProduct() async {
    try {
      state = PLoadingState();
      List<Data> Products = await _httpService.fetchProducts();
      state = PLoadedState(product: Products);
    } catch (e) {
      state = PErrorState(message: e.toString());
    }
  }
}
