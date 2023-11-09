import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/configuration/utils/common_footer.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late AdminProductBloc adminProductBloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () => FirebaseAuth.instance.signInAnonymously()); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adminProductBloc = context.read<AdminProductBloc>();
    adminProductBloc.add(AdminProductsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: figmaOrange,
              ),
              child: Text(
                'Grocery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.logout)),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Grocery Admin"),
        centerTitle: true,
      ),
      bottomNavigationBar: CommonFooterMenu(context).getFooterMenu(0),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: figmaOrange,
                    ),
                    child: Center(
                        child: Text(
                      "Dashboard",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    child: Row(children: [
                      BlocBuilder<AdminProductBloc, AdminProductState>(
                        builder: (context, state) {
                          return dashboardBlock(no_of_products, "100");
                        },
                      ),
                      dashboardBlock(no_of_users, "50"),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      dashboardBlock(no_of_orders, "100"),
                      dashboardBlock(orders_rate, "2%"),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(),
              // child: GridView.count(
              //   crossAxisCount: 2,
              //   children: [
              //     ElevatedButton.icon(onPressed: null, icon: Icon(Icons.create_new_folder), label: Text("Create",)),
              //     ElevatedButton.icon(onPressed: null, icon: Icon(Icons.edit), label: Text("Update",)),
              //     ElevatedButton.icon(onPressed: null, icon: Icon(Icons.create_new_folder), label: Text("",))

              //     // ElevatedButton(onPressed: null, child: Center(child: Text("Create Product"),)),
              //     // ElevatedButton(onPressed: null, child: Center(child: Text("Update Product"),)),
              //     // ElevatedButton(onPressed: null, child: Center(child: Text("Get Products"),)),
              //     // ElevatedButton(onPressed: null, child: Center(child: Text("Delete Products"),))
              //   ],
              // )
            )
          ],
        ),
      ),
    );
  }

  Widget dashboardBlock(String heading, String data) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        color: figmaLightestGrey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                heading,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              BlocBuilder<AdminProductBloc, AdminProductState>(
                buildWhen: (previous, current) => (current is AdminProductsLoadedState || current is AdminProductInitial),
                builder: (context, state) {
                  switch(state.runtimeType) {
                    case AdminProductInitial : return CircularProgressIndicator();
                    case AdminProductsLoadedState : {
                      AdminProductsLoadedState adminProductsLoadedState = state as AdminProductsLoadedState;
                      return Text(
                        "${adminProductsLoadedState.products.length}",
                        style: TextStyle(color: Colors.blue),
                      );
                    } 
                    default:return Text(data, style: TextStyle(color: Colors.blue));
                  }
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
