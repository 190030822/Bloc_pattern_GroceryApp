import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/admin/ui/admin.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Admin())),
                child: Text("Admin Page"),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),
                child: Text("Users Page"),
              ),
            ],
          ),
        )
      ),
    );
  }
}