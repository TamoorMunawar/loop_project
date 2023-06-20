import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/categories.dart';
import '../screens/product.dart';
import 'app_route_constant.dart';


class MyAppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: AppRoutesConstant.homeRoute,
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomePage());
      },
    ),
    GoRoute(
        name: AppRoutesConstant.productRoute,
        path: '/stateNotifierProvider',
        pageBuilder: (context, state) {
          return MaterialPage(child: ProductScreen());
        }),
  ]);
}
