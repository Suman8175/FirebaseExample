import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthexample/exception/firebaseemailexcep.dart';
import 'package:firebaseauthexample/ui/auth/home_screen.dart';
import 'package:firebaseauthexample/ui/auth/phone_signup.dart';
import 'package:firebaseauthexample/ui/auth/signup.dart';
import 'package:firebaseauthexample/ui/button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void onTap() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString());
        setState(() {
          loading = false;
        });
        movetonextPage();
      } on FirebaseAuthException catch (error) {
        ExceptionFromFirebase().firebaseemailEception(error.message!);
        setState(() {
          loading = false;
        });
      }
    }
  }

  void movetonextPage() {
    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void movetoSignPage() {
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  void signInWithPhoneNumber() {
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const PhoneSignUp()));
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                      controller: email,
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
                      controller: password,
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
              title: 'Login',
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                    onPressed: movetoSignPage, child: const Text('Signup'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: signInWithPhoneNumber,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: const Center(
                  child: Text('Login With Phone Number'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
