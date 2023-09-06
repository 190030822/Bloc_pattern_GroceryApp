import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/configuration/utils/common_footer.dart';
import 'package:flutter_bloc_tutorial/features/error/bloc/error_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_add_new_product.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_product_tile_widget.dart';

class AdminProductsListScreen extends StatefulWidget {
  const AdminProductsListScreen({super.key});

  @override
  State<AdminProductsListScreen> createState() => _AdminProductsListScreenState();
}

class _AdminProductsListScreenState extends State<AdminProductsListScreen> {

  late ErrorBloc errorBloc;
  late AdminProductBloc adminProductBloc;

  @override
  void didChangeDependencies() {
    adminProductBloc = context.read<AdminProductBloc>();
    errorBloc = context.read<ErrorBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    adminProductBloc.add(AdminProductsLoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/adminAddNewProduct'),
            icon: Icon(Icons.add_box_outlined)
          )
        ],
      ),
      bottomNavigationBar: CommonFooterMenu(context).getFooterMenu(1),
      body: BlocConsumer<AdminProductBloc, AdminProductState>(
        listenWhen: (previous, current) => current is AdminProductListenState,
        buildWhen: (previous, current) => current is! AdminProductListenState,
        listener: (context, state) {
            switch (state.runtimeType) {
              case AdminProductsErrorState:
                {
                  AdminProductsErrorState adminProductsErrorState = state as AdminProductsErrorState;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("ERROR", style: TextStyle(color: Colors.red),),
                      content: Text(adminProductsErrorState.errMsg),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
                      ],
                    )
                  );
                  break;
                }
              case AdminAddProductSuccessState:
                {
                  AdminAddProductSuccessState adminAddProductSuccessState = state as AdminAddProductSuccessState;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(adminAddProductSuccessState.successMsg)));
                  break;
                }
              default:
                {}
            }
        },
        builder: (context, state) {
          
          if (state.runtimeType == AdminProductsLoadedState) {
            AdminProductsLoadedState adminProductsLoadedState = state as AdminProductsLoadedState;
            return ListView.builder(
              itemCount: adminProductsLoadedState.products.length,
              itemBuilder: (context, index) {
                return ProductsList(product : adminProductsLoadedState.products[index]);
              },
            );
          } else if (state.runtimeType == AdminProductInitial){
            return Center(child: CircularProgressIndicator(color: Colors.orange));
          } else {
              return Center(child: Text("Something went wrong"));
          }
        } 
      ),
    );
  }
}