import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthexample/exception/firebaseemailexcep.dart';
import 'package:firebaseauthexample/ui/auth/verificationcode.dart';
import 'package:firebaseauthexample/ui/button.dart';
import 'package:flutter/material.dart';

class PhoneSignUp extends StatefulWidget {
  const PhoneSignUp({super.key});

  @override
  State<PhoneSignUp> createState() => _PhoneSignUpState();
}

class _PhoneSignUpState extends State<PhoneSignUp> {
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void onTap() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.toString(),
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          ExceptionFromFirebase().firebaseemailEception(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              (context),
              MaterialPageRoute(
                  builder: (context) => VerificationScreen(
                        verificationId: verificationId,
                      )));
        },
        codeAutoRetrievalTimeout: (e) {
          ExceptionFromFirebase().firebaseemailEception(e.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn With Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.call_end_outlined),
              ),
            ),
            MyButton(onTap: onTap, title: 'Login')
          ],
        ),
      ),
    );
  }
}
