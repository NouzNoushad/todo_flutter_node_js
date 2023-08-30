import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/data/bloc/bloc_widget.dart';
import 'package:todo_flutter/presentation/todo_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  final GoRouter router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        builder: (context, index) {
          return const TodoHome();
        })
  ]);
}
