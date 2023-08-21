import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/product_bloc.dart';
import 'package:provider/provider.dart';

void main(){
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<CartRepo>(
          create: (context) => CartRepo(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(Provider.of<CartRepo>(context, listen: false))
        ),
        BlocProvider(
          create: (context) => CartBloc(Provider.of<CartRepo>(context, listen: false))
        ),
        BlocProvider(
          create: (context) => ProductBloc(Provider.of<CartRepo>(context, listen: false))
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          useMaterial3: true,
        ),
        home: Home(),
      ),
    );
  }
}





