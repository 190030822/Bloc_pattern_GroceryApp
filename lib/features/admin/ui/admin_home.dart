import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/constants.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Admin"),
        centerTitle: true,
      ),
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
                    child: Center(child: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        dashboardBlock("No of products", "100"),
                        dashboardBlock("No of users", "50"),
                      ]
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        dashboardBlock("No of orders", "100"),
                        dashboardBlock("Orders rate", "2%"),
                      ]
                    ),
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
        ],),
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
              Text("$heading", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("$data", style: TextStyle(color: Colors.blue),)
            ],
          ),
        ),
      ),
    );
  }
  
}