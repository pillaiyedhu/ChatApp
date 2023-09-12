import 'package:chatapp/screens/SignUpPage.dart';
import 'package:chatapp/screens/ThreadsPage.dart';
import 'package:chatapp/screens/UsersPage.dart';
import 'package:chatapp/services/AuthService.dart';
import 'package:chatapp/services/RemoteConfigService.dart';
import 'package:chatapp/widgets/ButtonWidget.dart';
import 'package:chatapp/widgets/TextFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

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
  final remoteConfig = FirebaseRemoteConfigService();

  // static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  // static FirebaseInAppMessaging firebaseInAppMessaging =
  //     FirebaseInAppMessaging.instance;

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
                Text(remoteConfig.getString(FirebaseRemoteConfigKeys.message)),
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
                      // firebaseInAppMessaging.triggerEvent('Review');
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
                  builder: (context) => ThreadsPage(),
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
