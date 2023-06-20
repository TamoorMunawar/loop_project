import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../Model/categories_model.dart';
import '../service/categories_service.dart';


@immutable
abstract class CategroyState {}

class CInitialState extends CategroyState {}

class CLoadingState extends CategroyState {}

class CLoadedState extends CategroyState {
  final List<Data> categries;

  CLoadedState({required this.categries});
}

class CErrorState extends CategroyState {
  final String message;

  CErrorState({required this.message});
}



class CategroyNotifier extends StateNotifier<CategroyState> {
  final http.Client httpClient;
  CategroyNotifier({required this.httpClient})  : super(CInitialState());
  final CategroyService _httpService = CategroyService();

  getCategroy() async {
    try {
      state = CLoadingState();
      List<Data> Categroy = await _httpService.fetchCategroy();
      state = CLoadedState(categries: Categroy);
    } catch (e) {
      state = CErrorState(message: e.toString());
    }
  }
}
