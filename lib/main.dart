import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repository/cart_repository.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/product_variant/product_variant_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc/user_address/user_address_bloc.dart';
import 'screen/auth_screen.dart';
import 'screen/main_screen.dart';
import '/repository/user_repository.dart';
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
  final userRepository = UserRepository();
  final cartRepository = CartRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProductBloc(productRepository: productRepository),
      ),
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(userRepository: userRepository),
      ),
      BlocProvider<UserAddressBloc>(
        create: (context) => UserAddressBloc(userRepository: userRepository),
      ),
      BlocProvider<ProductVariantBloc>(
        create: (context) => ProductVariantBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(cartRepository: cartRepository),
      ),
      
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> hasToken () async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    var value = await storage.read(key: 'token');

    if (value != null) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
          secondary: const Color(0xFFFFC107),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
