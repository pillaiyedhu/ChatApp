import 'package:chatapp/screens/SignUpPage.dart';
import 'package:chatapp/screens/UsersPage.dart';
import 'package:chatapp/services/AuthService.dart';
import 'package:chatapp/widgets/ButtonWidget.dart';
import 'package:chatapp/widgets/TextFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      login();
                    },
                    text: 'Login'),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont Have an account?  "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ));
                        },
                        child: Text('Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      if (formKey.currentState!.validate()) {
        await authService
            .signIn(usernameController.text, passwordController.text)
            .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersPage(),
                )));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Future login() async {
  //   if (formKey.currentState!.validate()) {
  //     await auth
  //         .signInWithEmailAndPassword(
  //             email: usernameController.text,
  //             password: passwordController.text)
  //         .then((value) => {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => ThreadsPage(),
  //                   ))
  //             });
  //   }
  // }
}
