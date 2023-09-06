import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/services/AuthService.dart';
import 'package:chatapp/widgets/ButtonWidget.dart';
import 'package:chatapp/widgets/TextFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormWidget(
                    controller: usernameController,
                    texthint: 'Enter Username',
                    obsure: false),
                const SizedBox(
                  height: 20,
                ),
                TextFormWidget(
                    controller: passwordController,
                    texthint: 'Enter Password',
                    obsure: true),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    onTap: () {
                      signUp();
                    },
                    text: 'Sign Up'),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have an account?  "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: const Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      if (formKey.currentState!.validate()) {
        await authService
            .signUp(usernameController.text, passwordController.text)
            .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                )));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Future signUp() async {
  //   if (formKey.currentState!.validate()) {
  //     await auth
  //         .createUserWithEmailAndPassword(
  //             email: usernameController.text.toString(),
  //             password: passwordController.text.toString())
  //         .then((value) => {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => LoginPage(),
  //                   ))
  //             });
  //   }
  // }
}
