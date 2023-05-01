import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'bloc/product/product_bloc.dart';
import 'screen/main_screen.dart';

import 'repository/product_repository.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final productRepository = ProductRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProductBloc(productRepository: productRepository),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: MainScreen(),
      ),
    );
  }
}
