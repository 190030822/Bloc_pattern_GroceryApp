import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/configuration/utils/user_local_data.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          height: 500,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Lottie.network(
                  height: 150,
                  'https://lottie.host/a6b84af4-b9aa-405d-a7dc-35e2c7e3c677/34CpjHdIvX.json',
                  fit: BoxFit.cover,
                  reverse: true,
                ),
                Text("Login", style: TextStyle(color: figmaOrange, fontSize: 20, fontWeight: FontWeight.bold),),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Icon(Icons.email),
                    labelStyle: TextStyle(color: figmaLightBlue),
                    hintText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please Enter Email";
                    else if (!isValidEmail(value)) return "Please Enter Valid Email (eg: abcd@gmail.com)";
                    else null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: Icon(Icons.key),
                    labelStyle: TextStyle(color: figmaLightBlue),
                    hintText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                     if (value == null || value.isEmpty) return "Please Enter Email";
                    else null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Builder(
                  builder: (context) {
                    return ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text("Login"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_emailController.text == "admin@gmail.com") {
                            Navigator.pushNamed(context, '/adminHome');
                          } else {
                            if (_emailController.text == UserLocalData.getUserName() && _passwordController.text == UserLocalData.getPassword()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfull")));
                            Navigator.pushNamed(context, '/userHome');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
                            }
                          }
                        }
                      },
                    );
                  }
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/userSignUp'),
                    hoverColor: figmaOrange,
                    child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: figmaBlue)),
                  ),
                ],
              )
              ],
            ),
          ),
        )
      )
    );
  }

    bool isValidEmail(String email) {
      final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      return emailRegExp.hasMatch(email);
  }
}