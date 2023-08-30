import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:flutter_bloc_tutorial/features/admin/ui/admin_home.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_products_list_screen.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  List<Widget> screens = [
    LazyScreen((context) => AdminProductsListScreen()),
    // LazyScreen((context) => AdminProductsListScreen()),
    AdminHome(),
    AdminHome()
  ];

  int _selectedIndex = 0;

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
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.integration_instructions),
            label: "orders",
          ),

        ]
      ),
      body: IndexedStack(
        index : _selectedIndex,
        children: screens,
      )
    );

  }
}

class LazyScreen extends StatefulWidget {
  final WidgetBuilder builder;

  LazyScreen(this.builder);

  @override
  _LazyScreenState createState() => _LazyScreenState();
}

class _LazyScreenState extends State<LazyScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}