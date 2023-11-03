import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseauthexample/exception/firebaseemailexcep.dart';
import 'package:firebaseauthexample/ui/auth/login.dart';
import 'package:firebaseauthexample/ui/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController enteredDataController = TextEditingController();
  TextEditingController enteredData2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // final databaseRef = FirebaseDatabase.instance.ref('Practise');

    DatabaseReference databaseRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://testoffirebaseauth-default-rtdb.asia-southeast1.firebasedatabase.app/')
        .ref("users");

    var name = _auth.currentUser!.email;
    debugPrint(name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hellow'),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              icon: const Icon(Icons.logout_outlined)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Flexible(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 5,
                controller: enteredDataController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.message_outlined),
                  hintText: 'Enter the messages',
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              minLines: 1,
              maxLines: 5,
              controller: enteredData2Controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.message_outlined),
                hintText: 'Enter the messages',
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MyButton(
                loading: loading,
                onTap: () {
                  try {
                    setState(() {
                      loading = true;
                    });
                    databaseRef.child(_auth.currentUser!.uid).set({
                      'title1': enteredDataController.text.toString(),
                      'title2': enteredData2Controller.text.toString()
                    });
                    ExceptionFromFirebase()
                        .firebaseemailEception('Added item in database');
                    enteredDataController.text = '';
                    enteredData2Controller.text = '';

                    setState(() {
                      loading = false;
                    });
                  } on FirebaseException catch (e) {
                    ExceptionFromFirebase().firebaseemailEception(e.message!);
                  }
                },
                title: 'Add')
          ],
        ),
      ),
    );
  }
}
