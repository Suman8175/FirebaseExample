import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthexample/exception/firebaseemailexcep.dart';
import 'package:firebaseauthexample/ui/auth/login.dart';
import 'package:firebaseauthexample/ui/button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController signUpemail = TextEditingController();
  final TextEditingController signUppassword = TextEditingController();
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void onTap() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: signUpemail.text.toString(),
            password: signUppassword.text.toString());
        setState(() {
          loading = false;
        });
      } on FirebaseAuthException catch (error) {
        ExceptionFromFirebase().firebaseemailEception(error.message!);
        setState(() {
          loading = false;
        });
      }
    }
  }

  void movetonextPage() {
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    signUpemail.dispose();
    signUppassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: signUpemail,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: signUppassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outlined),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              loading: loading,
              onTap: onTap,
              title: 'SignUp',
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                    onPressed: movetonextPage, child: const Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
