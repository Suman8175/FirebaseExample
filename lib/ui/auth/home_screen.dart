import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  TextEditingController searchController = TextEditingController();

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
            Expanded(
                child: FirebaseAnimatedList(
                    query: databaseRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      final title = snapshot.child('title1').value.toString();
                      if (searchController.text.isEmpty) {
                        return ListTile(
                          title:
                              Text(snapshot.child('title1').value.toString()),
                          subtitle:
                              Text(snapshot.child('title2').value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Add'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (title.toLowerCase().contains(
                          searchController.text.toString().toLowerCase())) {
                        return ListTile(
                          title:
                              Text(snapshot.child('title1').value.toString()),
                          subtitle:
                              Text(snapshot.child('title2').value.toString()),
                        );
                      } else {
                        return Container();
                      }
                    })),
            Container(
              height: 5,
              color: Colors.amber,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                onChanged: (String value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: const InputDecoration(hintText: 'Search'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 5,
                controller: enteredDataController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.message_outlined),
                  hintText: 'Enter the message',
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
                      'title2': enteredData2Controller.text.toString(),
                      'id': _auth.currentUser!.uid
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
