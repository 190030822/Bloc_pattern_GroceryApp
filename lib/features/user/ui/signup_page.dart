import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/configuration/utils/user_local_data.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _nameController = TextEditingController();
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
          height: MediaQuery.of(context).size.height-20,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Lottie.network(
                  height: 150,
                  'https://lottie.host/21b75b56-21df-45d9-9186-e8e0ad618ec1/b8pjNpT96F.json',
                  fit: BoxFit.cover,
                ),
                Text("Sign Up", style: TextStyle(color: figmaOrange, fontSize: 20, fontWeight: FontWeight.bold),),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Enter your Username",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please Enter Username";
                    if (value.length < 6) return "name should be above 6 characters";
                    else return null;
                  },
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Mail",
                    hintText: "Enter your mail",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please Enter Email";
                    else if (!isValidEmail(value)) return "Please Enter Valid Email (eg: abcd@gmail.com)";
                    else return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                     if (value == null || value.isEmpty) return "Please Enter Password";
                    else return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                 TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Re-Enter your password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaOrange)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: figmaRed))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please Enter Password again";
                    if (value != _passwordController.text) return "Password mismatched";
                    else return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ElevatedButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserLocalData.setUserName(_emailController.text);
                      UserLocalData.setPassword(_passwordController.text);
                      Navigator.pushNamedAndRemoveUntil(context, '/userHome', (route) => false);
                    }
                  },
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account ? "),
                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/'),
                    hoverColor: figmaOrange,
                    child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: figmaBlue)),
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